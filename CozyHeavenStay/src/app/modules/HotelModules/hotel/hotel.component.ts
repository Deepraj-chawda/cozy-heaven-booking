import { Component, inject } from '@angular/core';
import { Booking } from '../../../models/booking.Model';
import { FormArray, FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { HotelService } from '../../../services/hotel.service';
import { Hotel } from '../../../models/hotel.Model';
import { SearchHotelDTO } from '../../../models/DTO/search-hotel-dto.Model';
import { NavigationEnd, Router } from '@angular/router';
import { INDIAN_CITIES } from '../../../utils/Cities';
import { Observable, map, startWith } from 'rxjs';
import { OperatorFunction } from 'rxjs';
import { debounceTime, distinctUntilChanged,  } from 'rxjs/operators';
import { JsonPipe } from '@angular/common';
import { RoomConstants } from '../../../utils/RoomConstants';

@Component({
  selector: 'app-hotel',
  templateUrl: './hotel.component.html',
  styleUrl: './hotel.component.css'
})
export class HotelComponent {
  searchForm: FormGroup;
  hotelService : HotelService = inject(HotelService);
  hotelList;
  filteredList  ;
  filteredHotels;
  minDate: Date; 
  user;
  router :Router = inject(Router);
  locations: string[] = INDIAN_CITIES;
  filteredOptions: Observable<string[]>;
  roomConstrant = RoomConstants;

  model: any;

  search: OperatorFunction<string, readonly string[]> = (text$: Observable<string>) =>
    text$.pipe(
      debounceTime(200),
      distinctUntilChanged(),
      map((term) =>
        term.length < 1 ? [] : this.locations.filter((v) => v.toLowerCase().indexOf(term.toLowerCase()) > -1).slice(0, 10),
      ),
  );


  roomTypes: string[] = ['Single', 'Double', 'Suite'];
  priceRanges: string[] = ['₹0 - ₹500', '₹500 - ₹1000', '₹1000 - ₹1500', '₹1500 - ₹2000', '₹2000+'];
  customerRatings: number[] = [3, 3.5, 4, 4.5];
  filterCriteria: FormGroup;

  constructor(private formBuilder: FormBuilder) {
    this.filterCriteria = this.formBuilder.group({
      roomType: new FormArray([]),
      priceRange: new FormArray([]),
      customerRating: new FormArray([])
    });
  }


 
  ngOnInit(): void {

    const today = new Date();
    const tomorrow = new Date();
    tomorrow.setDate(tomorrow.getDate() + 1);

    this.searchForm = new FormGroup({
      location: new FormControl ('', [Validators.required]),
      selectedDates: new FormControl ([today, tomorrow], [Validators.required]),
      numberOfRooms: new FormControl (1, [Validators.required]),
      numberOfAdults: new FormControl (1, [ Validators.required]),
      numberOfChildren: new FormControl (0, [Validators.required]) 
    });
    this.minDate = new Date();    

    this.user = JSON.parse(localStorage.getItem('user'));

    this.hotelService.getAllHotels(this.user.token).subscribe(
      (res) => {
        this.hotelList = res;
        this.hotelList = this.hotelList.data;
        this.filteredList = this.hotelList;        
      },
      error => {
        console.log(error);
      }
    );

    this.router.events.subscribe((event) => {
      if (event instanceof NavigationEnd) {
        window.scrollTo(0, 0);
      }
    });

    this.filteredOptions = this.searchForm.get('location').valueChanges.pipe(
      startWith(''),
      map(value => this._filter(value))
    );
  
  }

  private _filter(value: string): string[] {
    const filterValue = value.toLowerCase();
    return this.locations.filter(option => option.toLowerCase().includes(filterValue));
  }

  onSubmit() {
    const searchData: SearchHotelDTO = new SearchHotelDTO(
      this.searchForm.get('location').value,
      this.searchForm.get('selectedDates').value[0],
      this.searchForm.get('selectedDates').value[1],
      this.searchForm.get('numberOfRooms').value,
      this.searchForm.get('numberOfAdults').value,
      this.searchForm.get('numberOfChildren').value
    );
  
    this.filteredList = this.hotelList.filter(hotel => {
      let matchesCriteria = true;
  
      if (searchData.location) {
        matchesCriteria = matchesCriteria && hotel.location.trim().toLowerCase().includes(searchData.location.trim().toLowerCase());
      }
  
      if (searchData.checkInDate && searchData.checkOutDate) {
        matchesCriteria = matchesCriteria && hotel.rooms.some(room =>
          !room.bookings.some(booking =>
            (new Date(searchData.checkInDate) >= new Date(booking.checkInDate) && new Date(searchData.checkInDate) < new Date(booking.checkOutDate)) ||
            (new Date(searchData.checkOutDate) > new Date(booking.checkInDate) && new Date(searchData.checkOutDate) <= new Date(booking.checkOutDate))
          )
        );
      }
  
      // Apply numberOfRooms filter
      if (searchData.numberOfRooms) {
        matchesCriteria = matchesCriteria && hotel.rooms.length >= searchData.numberOfRooms;
      }
  
      // Apply occupancy filter
      if (searchData.numberOfAdults && searchData.numberOfChildren) {
        const totalPersons = searchData.numberOfAdults + searchData.numberOfChildren;
        matchesCriteria = matchesCriteria && hotel.rooms.some(room => room.maxOccupancy >= totalPersons);
      }  
      return matchesCriteria;
    });  
  }
  


  addAdult(data){
    if(data) {
      this.searchForm.patchValue({
        numberOfAdults: +this.searchForm.value.numberOfAdults + 1
      })
    }else{
      if(this.searchForm.value.numberOfAdults > 1) {
        this.searchForm.patchValue({
          numberOfAdults: +this.searchForm.value.numberOfAdults - 1
        })
      }      
    }    
  }

  noOfChildren(data) {
    if(data) {
      this.searchForm.patchValue({
        numberOfChildren: +this.searchForm.value.numberOfChildren + 1
      })
    }else{
      if(this.searchForm.value.numberOfChildren > 0){
        this.searchForm.patchValue({
          numberOfChildren: +this.searchForm.value.numberOfChildren - 1
        })
      }      
    }    
  }

  noOfRooms(data) {
    if(data) {
      if(this.searchForm.value.numberOfRooms <  8){
        this.searchForm.patchValue({
          numberOfRooms: +this.searchForm.value.numberOfRooms + 1
        })
      }      
    }else{
      if(this.searchForm.value.numberOfRooms > 1){
        this.searchForm.patchValue({
          numberOfRooms: +this.searchForm.value.numberOfRooms - 1
        })
      }
      
    }    
  }

  onChangeRoom(event) {
    const roomArray = this.filterCriteria.get('roomType') as FormArray;
    if(event.target.checked){
      roomArray.push(new FormControl(event.target.value));
    }else{
      let i = 0;
      roomArray.controls.forEach(control => { 
        if(control.value === event.target.value){
          roomArray.removeAt(i);
        }
        i++;
      })
    }
  }

  onChangePrice(event) {    
    const priceArray = this.filterCriteria.get('priceRange') as FormArray;
    if(event.target.checked){
      priceArray.push(new FormControl(event.target.value));
    }else{
      let i = 0;
      priceArray.controls.forEach(control => { 
        if(control.value === event.target.value){
          priceArray.removeAt(i);
        }
        i++;
      })
    }
  }

 

  onChangeRating(event) {
    const ratingArray = this.filterCriteria.get('customerRating') as FormArray;
    if(event.target.checked){
      ratingArray.push(new FormControl(event.target.value));
    }else{
      let i = 0;
      ratingArray.controls.forEach(control => { 
        if(control.value === event.target.value){
          ratingArray.removeAt(i);
        }
        i++;
      })
    }
  }

  applyFilters(): void {
    this.filteredList = this.hotelList.filter((hotel) => {
      let matchesCriteria = true;
  
      // Filter by Room Type
      const selectedRoomTypes: string[] = this.filterCriteria.get('roomType').value;
      if (selectedRoomTypes.length > 0) {
        matchesCriteria = matchesCriteria && hotel.rooms.some((room) => selectedRoomTypes.includes(room.roomType));
      }
  
      // Filter by Price Range
      const selectedPriceRanges: string[] = this.filterCriteria.get('priceRange').value;
      if (selectedPriceRanges.length > 0) {
        matchesCriteria = matchesCriteria && this.checkPriceRange(hotel, selectedPriceRanges);
      }
  
      // Filter by Customer Rating
      const selectedRatings: number[] = this.filterCriteria.get('customerRating').value;
      if (selectedRatings.length > 0) {
        matchesCriteria = matchesCriteria && this.checkRatings(hotel.reviews,selectedRatings);
      }
  
      return matchesCriteria;
    });
  }
  
  checkRatings(reviews,selectedRatings){
    let avgrating = this.GetAvgRating(reviews);
    let minrating = Math.min(...selectedRatings);
   
    if(avgrating>=minrating){
      return true;
    }
    else{
      return false;
    }
  }

  checkPriceRange(hotel: Hotel, selectedPriceRanges: string[]): boolean {
    let roomPrices = hotel.rooms.map(room => room.baseFare); // Get an array of room base fares
    roomPrices = [Math.min(...roomPrices)];

  return roomPrices.some(roomPrice => {
    for (const selectedRange of selectedPriceRanges) {
      let [min, max] = selectedRange.split(' - ').map(s => parseInt(s.replace(/\D/g, ''), 10)); 
      
      if(min==2000){
        max = 1000000000;
      }
      if (!isNaN(min) && !isNaN(max) && roomPrice >= min && roomPrice <= max) {
        return true; 
      }
    }
    return false;
  });
  }
  

  clearFilters(): void {
    this.filterCriteria.patchValue({
      roomType: [],
      priceRange: [],
      customerRating: []
    });

    this.filteredList = this.hotelList;
    let controlArray;

    //Resetting Room 
    controlArray = this.filterCriteria.get('roomType') as FormArray;
    controlArray.clear();


    //Resetting Price Range
    controlArray = this.filterCriteria.get('priceRange') as FormArray;
    controlArray.clear();

    //Resetting Customer Rating
    controlArray = this.filterCriteria.get('customerRating') as FormArray;
    controlArray.clear();
  }
  

  GetAvgRating(ratingArr) {
    if (ratingArr?.length === 0) return 0
    let totalReviewCount = 0;
    ratingArr?.forEach(element => {
      totalReviewCount += element.rating
    });
  
    const multiplier = Math.pow(10, 1)
    const avgReviewCount =
      Math.round((totalReviewCount / ratingArr?.length) * multiplier) / multiplier
  
    return avgReviewCount
  }
}

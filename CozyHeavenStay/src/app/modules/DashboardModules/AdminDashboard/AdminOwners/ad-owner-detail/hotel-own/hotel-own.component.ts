import { Component, EventEmitter, Input, Output, inject } from '@angular/core';
import { HotelService } from '../../../../../../services/hotel.service';
import { ToastrService } from 'ngx-toastr';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'app-hotel-own',
  templateUrl: './hotel-own.component.html',
  styleUrl: './hotel-own.component.css'
})
export class HotelOwnComponent {
@Input() data;
hotelService : HotelService = inject(HotelService);
toaster : ToastrService = inject(ToastrService);
router : Router = inject(Router);
activatedRoute : ActivatedRoute = inject(ActivatedRoute);
ownerId : number;
user;
@Output() booleanValue = new EventEmitter<boolean>();



deleteHotel(id:number) {

  this.activatedRoute.params.subscribe(params => {
    this.ownerId= params['id'];
  });
  this.user = JSON.parse(localStorage.getItem("user"));
  this.hotelService.deleteHotel(id,this.user.token).subscribe({
    next: data => {
      this.toaster.success('Hotel deleted successfully');
      this.router.navigate(['/manage-owners/detail/'+ this.ownerId]);
      this.booleanValue.emit(true);
    },
    error: error => {
      this.toaster.error('Something went wrong');
    }
  })
}
}

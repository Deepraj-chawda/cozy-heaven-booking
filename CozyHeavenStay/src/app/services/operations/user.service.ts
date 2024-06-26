import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { BehaviorSubject, Observable, throwError } from 'rxjs';
import { catchError, finalize, tap } from 'rxjs/operators';
import { User } from '../../models/User.Model';
import { userEndpoints } from '../apis';
import { ToastrService } from 'ngx-toastr';
import { Admin } from '../../models/Admin.Model';

@Injectable({
  providedIn: 'root'
})
export class UserService {
    toastr : ToastrService = inject(ToastrService);
    http: HttpClient = inject(HttpClient);
    private dynamicDataSubject = new BehaviorSubject<any>(true);
    dynamicData$ = this.dynamicDataSubject.asObservable();

  setDynamicData(data: boolean) {
    this.dynamicDataSubject.next(data);
  }

  setToken(token: string ){
    const httpOptions = {
      headers: new HttpHeaders({
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${token}` 
      })
    };
    return httpOptions;
  }

  getAllUsers(token:string): Observable<User[]> {     
    return this.http.get<User[]>(userEndpoints.GET_ALL_USERS_API,this.setToken(token))
      .pipe(
        catchError(this.handleError)
      );
  }

  getUserById(id: number, token : string): Observable<any> { 
    return this.http.get<any>(`${userEndpoints.GET_USER_BY_ID_API}${id}`, this.setToken(token))
      .pipe(
        catchError(this.handleError)
      );
  }

  createUser(User: User, token : string): Observable<User> { 
    return this.http.post<User>(userEndpoints.CREATE_USER_API, User, this.setToken(token))
      .pipe(
        catchError(this.handleError)
      );
  }

  updateUser(User: User, token : string): Observable<any> { 
    const loadingToast = this.toastr.info('Updating User...', 'Please wait', {
        disableTimeOut: true,
        closeButton: false,
        positionClass: 'toast-top-center'
      });

    return this.http.put<any>(`${userEndpoints.UPDATE_USER_API}`, User, this.setToken(token))
      .pipe(
        tap((res) => {
            this.toastr.clear();
            this.handleCreateUser(res);
        }),
        catchError((err) => {
            if (loadingToast) {
                this.toastr.clear();
            }
            this.toastr.error('Failed to Update', 'Error');
            return throwError(() => err);
        }),
        finalize(() => {
            if (loadingToast) {
                this.toastr.clear();
            }
        })
      );
  }

  deleteUser(id: number, token : string): Observable<any> {
    const loadingToast = this.toastr.info('Updating User...', 'Please wait', {
      disableTimeOut: true,
      closeButton: false,
      positionClass: 'toast-top-center'
    });

    return this.http.delete<any>(`${userEndpoints.DELETE_USER_API}${id}`, this.setToken(token))
      .pipe(
        tap((res) => {
          this.toastr.clear();
        }),
        catchError((err) => {
          if (loadingToast) {
            this.toastr.clear();
          }
          this.toastr.error('Failed to Update', 'Error');
          return throwError(() => err);
        }),
        finalize(() => {
          if (loadingToast) {
            this.toastr.clear();
          }
        })        
      );
  }

  uploadDisplayPicture(formData: FormData, token : string): Observable<any> {

    const loadingToast = this.toastr.info('Uploading Image...', 'Please wait', {
        disableTimeOut: true,
        closeButton: false,
        positionClass: 'toast-top-center'
      });

      const httpOptions = {
        headers: new HttpHeaders({
          'Authorization': `Bearer ${token}` 
        })
      };

    return this.http.post<any>(`${userEndpoints.UPLOAD_DISPLAY_PICTURE_API}`, formData, httpOptions)
    .pipe(
        catchError(error => {
          if (loadingToast) {
            this.toastr.clear();
          }
          this.toastr.error('Failed to sign up', 'Error');
          
          return throwError(() => error);
        }),tap((res) => {
            this.handleCreateUser(res);
        }),
        finalize(() => {
          if (loadingToast) {
            this.toastr.clear();
          }
        })
      );
  }

  private handleError(error: any) {
    console.error('API Error:', error);
    return throwError('Something went wrong; please try again later.');
  }

  private handleCreateUser(res){
    const expiresInTs = new Date().getTime() + ((3 * 60 * 60) * 1000);
    const expiresIn = new Date(expiresInTs);
    let user : any;

    if(res.user.role == "Admin") {
      user = new Admin(
        res.user.adminId,
        res.user.firstName,
        res.user.lastName,
        res.user.email,
        res.user.password,
        res.user.profileImage,
        res.user.role,
        res.user.token,
        res.user.resetPasswordExpires,
        //expiresIn
      )

    }else if(res.user.role == "Owner"){
      user = new User(
        res.user.ownerId,
        res.user.firstName,
        res.user.lastName,
        res.user.email,
        res.user.password,
        res.user.gender,
        res.user.contactNumber,
        res.user.address,
        res.user.role,
        res.user.profileImage,
        res.user.token,
        res.user.resetPasswordExpires,
        //expiresIn
    );

    }else{
      user = new User(
        res.user.userId,
        res.user.firstName,
        res.user.lastName,
        res.user.email,
        res.user.password,
        res.user.gender,
        res.user.contactNumber,
        res.user.address,
        //expiresIn,
        res.user.role,
        res.user.profileImage,
        res.user.token,
        res.user.resetPasswordExpires,
    );
    }     
    
    localStorage.setItem("user" , JSON.stringify(user));
  }
}

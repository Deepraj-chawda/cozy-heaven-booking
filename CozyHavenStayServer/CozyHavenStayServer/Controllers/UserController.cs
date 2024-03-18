﻿using CloudinaryDotNet.Actions;
using CloudinaryDotNet;
using CozyHavenStayServer.Interfaces;
using CozyHavenStayServer.Models;
using CozyHavenStayServer.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using CozyHavenStayServer.Models.DTO;

namespace CozyHavenStayServer.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly IUserServices _userServices;
        private readonly IAdminServices _adminServices;
        private readonly IHotelOwnerServices _hotelOwnerServices;
        private readonly ILogger<UserController> _logger;
        private readonly ICloudinaryService _cloudinaryService;


        public UserController(ILogger<UserController> logger, IUserServices userServices, ICloudinaryService cloudinaryService, 
        IAdminServices adminServices, IHotelOwnerServices hotelOwnerServices)
        {
            _hotelOwnerServices = hotelOwnerServices;
            _adminServices = adminServices;
            _logger = logger;
            _userServices = userServices;
            _cloudinaryService = cloudinaryService;
        }


        //GetAllUsers
        [Authorize(Roles = "Admin, User, Owner")]
        [HttpGet]
        [Route("GetAllUsers")]
        public async Task<ActionResult<List<User>>> GetAllUsersAsync()
        {
            try
            {
                var users = await _userServices.GetAllUsersAsync();

                if(users == null || users.Count <= 0)
                {
                    return NotFound(new
                    {
                        success = false,
                        message = "No data found"
                    });
                }

                return Ok(new
                {
                    success = true,
                    data = users 
                });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message);
                return StatusCode(StatusCodes.Status500InternalServerError, new
                {
                    success = false,
                    error = "An error occurred while fetching users."
                });
            }
        }


        //GetUserById
        [Authorize(Roles = "Admin, User, Owner")]
        [HttpGet]
        [Route("GetUserById/{id}", Name = "GetUserById")]
        public async Task<ActionResult<User>> GetUserByIdAsync(int id)
        {
            try
            {
                if(id <= 0)
                {
                    _logger.LogWarning("Bad Request");
                    return BadRequest(new
                    {
                        success = false,
                        message = "Invalid User Id"
                    });
                }
                var user = await _userServices.GetUserByIdAsync(id);


                if (user == null)
                {
                    _logger.LogError("User not found with given Id");
                    return NotFound(new
                    {
                        success = false,
                        message = $"The 'user' with Id: {id} not found"
                    });
                }

                return Ok(new
                {
                    success =true,
                    data = user
                });
            }
            catch(Exception ex)
            {
                _logger.LogError(ex.Message);
                return StatusCode(StatusCodes.Status500InternalServerError, new
                {
                    success = false,
                    error = "An error occurred while fetching user."
                });
            }
        }


        //GetUserByName
        [Authorize(Roles = "Admin, User, Owner")]
        [HttpGet]
        [Route("GetUserByEmail/{email}")]
        public async Task<ActionResult<User>> GetUserByNameAsync(string email)
        {
            try
            {
                if (string.IsNullOrEmpty(email))
                {
                    _logger.LogWarning("Bad Request");
                    return BadRequest(new
                    {
                        success = false,
                        message = "Invalid User Email"
                    });
                }

                var user = await _userServices.GetUserByEmailAsync(email);

                if (user == null)
                {
                    _logger.LogError("User not found with given name");
                    return NotFound(new
                    {
                        success = false,
                        message = $"The 'user' with Email: {email} not found"
                    });
                }

                return Ok(new
                {
                    success = true,
                    data = user
                });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message);
                return StatusCode(StatusCodes.Status500InternalServerError, new
                {
                    success = false,
                    error = "An error occurred while fetching user."
                });
            }
        }

        //CreateUser
        [Authorize(Roles = "User")]
        [HttpPost]
        [Route("CreateUser")]
        public async Task<ActionResult<User>> CreateUserAsync([FromBody] User model)
        {
            try
            {
                if (model == null)
                {
                    _logger.LogWarning("Bad Request");
                    return BadRequest(new
                    {
                        success = false,
                        message = "Null Object"
                    });
                }

                var createdUser = await _userServices.CreateUserAsync(model);

                //return CreatedAtRoute("GetStudentById", new { id = createdUser.UserId }, User);
                if (createdUser == null)
                {
                    return BadRequest( new
                    {
                        success = false,
                        message = "Failed to create User"
                    });
                }
                return Ok(new
                {
                    success = true,
                    data = createdUser
                });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message);
                return StatusCode(StatusCodes.Status500InternalServerError, new
                {
                    success = false,
                    error = "An error occurred while creating user."
                });
            }
        }


        //UpdateUser
        [Authorize(Roles = "User")]
        [HttpPut]
        [Route("UpdateUser")]
        public async Task<ActionResult<User>> UpdateUserAsync([FromBody] User model)
        {
            try
            {
                if (model == null || model.UserId <= 0)
                {
                    _logger.LogWarning("Bad Request");
                    return BadRequest(new
                    {
                        success = false,
                        message = "Invalid Data"
                    });
                }

                var updateStatus = await _userServices.UpdateUserAsync(model);

                if (updateStatus)
                {
                    return Ok(new
                    {
                        success = true,
                        message = "User updated successfully",
                        user = model
                    });
                }
                else
                {
                    return NotFound(new
                    {
                        success = false,
                        message = "User not found"
                    });
                }               

            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message);
                return StatusCode(StatusCodes.Status500InternalServerError, new
                {
                    success = false,
                    error = "An error occurred while updating user."
                });
            }
        }


        //DeleteUser
        [Authorize(Roles = "Admin, User")]
        [HttpDelete]
        [Route("DeleteUser/{id}")]
        public async Task<ActionResult<bool>> DeleteUserAsync(int id)
        {
            try
            {
                if (id <= 0)
                {
                    _logger.LogWarning("Bad Request");
                    return BadRequest(new
                    {
                        success = false,
                        message = "Invalid User Id"
                    });
                }

                var deleteStatus = await _userServices.DeleteUserAsync(id);

                if(deleteStatus)
                {
                    return Ok(new
                    {
                        success = true,
                        message = "User deleted successfully"
                    });
                }
                else
                {
                    return NotFound(new
                    {
                        success = false,
                        message = "User Not found"
                    });
                }
                
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message);
                return StatusCode(StatusCodes.Status500InternalServerError, new
                {
                    success = false,
                    error = "An error occurred while deleting user."
                });
            }
        }


        //UploadDisplay Picture
        [Authorize(Roles = "Admin, User, Owner")]
        [HttpPost]
        [Route("UploadDisplayPicture")]
        public async Task<ActionResult> UploadDisplayPicture([FromForm] UploadPicDTO model)
        {
            try
            {

                if (model.id <= 0)
                {
                    _logger.LogWarning("Bad Request");
                    return BadRequest(new
                    {
                        success = false,
                        message = "Invalid User Id"
                    });
                }
                dynamic user;
                if(model.Role == "User"){
                user = await _userServices.GetUserByIdAsync(model.id);  
                }else if(model.Role == "Admin"){
                    user = await _adminServices.GetAdminByIdAsync(model.id);
                }else{
                    user = await _hotelOwnerServices.GetHotelOwnerByIdAsync(model.id);
                }
                if (user == null)
                {
                    return NotFound(new
                    {
                        success = false,
                        message = "User not found"
                    });
                }

                if (model.file == null || model.file.Length == 0)
                {
                    return BadRequest("No file uploaded.");
                }

                var result = await _cloudinaryService.UploadImageAsync(model.file); 
                user.ProfileImage = result.SecureUrl.ToString();
                var status = false;
                if(model.Role == "User"){
                    status =await _userServices.UpdateUserAsync(user,false);  
                }else if(model.Role == "Admin"){
                    status =await _adminServices.UpdateAdminAsync(user,false);
                }else{
                    status = await _hotelOwnerServices.UpdateHotelOwnerAsync(user,false);
                }

                if (status)
                {
                    return Ok(new
                    {
                        success = true,
                        message = "Image Uploaded Successfully",
                        user,
                        imgRes = result
                    });
                }
                else
                {
                    return NotFound(new
                    {
                        success = false,
                        message = "User Not found"
                    });
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message);
                return StatusCode(StatusCodes.Status500InternalServerError, new
                {
                    success = false,
                    error = "An error occurred while adding user dp."
                });
            }
        }

    }
}

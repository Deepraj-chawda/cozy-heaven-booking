USE [CozyHavenStayDB1]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 18-03-2024 20:53:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Admin]    Script Date: 18-03-2024 20:53:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Admin](
	[AdminId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](100) NOT NULL,
	[LastName] [nvarchar](100) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[Password] [nvarchar](255) NOT NULL,
	[profileImage] [nvarchar](255) NOT NULL,
	[Role] [nvarchar](50) NULL,
	[ResetPasswordExpires] [datetime2](7) NULL,
	[Token] [nvarchar](max) NULL,
 CONSTRAINT [PK_Admin] PRIMARY KEY CLUSTERED 
(
	[AdminId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Booking]    Script Date: 18-03-2024 20:53:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Booking](
	[BookingId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[RoomId] [int] NOT NULL,
	[NumberOfGuests] [int] NOT NULL,
	[CheckInDate] [datetime] NOT NULL,
	[CheckOutDate] [datetime] NOT NULL,
	[TotalFare] [decimal](10, 2) NOT NULL,
	[Status] [nvarchar](30) NOT NULL,
	[HotelId] [int] NULL,
	[PaymentId] [int] NULL,
 CONSTRAINT [PK_Booking] PRIMARY KEY CLUSTERED 
(
	[BookingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HotelImages]    Script Date: 18-03-2024 20:53:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HotelImages](
	[ImageId] [int] IDENTITY(1,1) NOT NULL,
	[HotelId] [int] NOT NULL,
	[ImageUrl] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_HotelImages] PRIMARY KEY CLUSTERED 
(
	[ImageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HotelOwners]    Script Date: 18-03-2024 20:53:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HotelOwners](
	[OwnerId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](100) NOT NULL,
	[LastName] [nvarchar](100) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[Password] [nvarchar](255) NOT NULL,
	[Gender] [nvarchar](50) NOT NULL,
	[ContactNumber] [nvarchar](20) NOT NULL,
	[Address] [nvarchar](max) NOT NULL,
	[ProfileImage] [nvarchar](255) NOT NULL,
	[Role] [nvarchar](50) NULL,
	[ResetPasswordExpires] [datetime2](7) NULL,
	[Token] [nvarchar](max) NULL,
 CONSTRAINT [PK_HotelOwners] PRIMARY KEY CLUSTERED 
(
	[OwnerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Hotels]    Script Date: 18-03-2024 20:53:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Hotels](
	[HotelId] [int] IDENTITY(1,1) NOT NULL,
	[OwnerId] [int] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Location] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[Amenities] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Hotels] PRIMARY KEY CLUSTERED 
(
	[HotelId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payment]    Script Date: 18-03-2024 20:53:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payment](
	[PaymentId] [int] IDENTITY(1,1) NOT NULL,
	[BookingId] [int] NOT NULL,
	[RefundId] [int] NULL,
	[PaymentMode] [nvarchar](50) NULL,
	[Status] [nvarchar](50) NULL,
	[Amount] [decimal](10, 2) NOT NULL,
	[PaymentDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Payment] PRIMARY KEY CLUSTERED 
(
	[PaymentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Refund]    Script Date: 18-03-2024 20:53:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Refund](
	[RefundId] [int] IDENTITY(1,1) NOT NULL,
	[PaymentId] [int] NOT NULL,
	[RefundAmount] [decimal](10, 2) NOT NULL,
	[RefundDate] [datetime] NOT NULL,
	[Reason] [nvarchar](500) NULL,
	[RefundStatus] [nvarchar](50) NULL,
 CONSTRAINT [PK_Refund] PRIMARY KEY CLUSTERED 
(
	[RefundId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reviews]    Script Date: 18-03-2024 20:53:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reviews](
	[ReviewId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[HotelId] [int] NOT NULL,
	[Rating] [int] NOT NULL,
	[Comments] [nvarchar](max) NOT NULL,
	[Date] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Reviews] PRIMARY KEY CLUSTERED 
(
	[ReviewId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Room]    Script Date: 18-03-2024 20:53:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Room](
	[RoomId] [int] IDENTITY(1,1) NOT NULL,
	[HotelId] [int] NOT NULL,
	[RoomType] [nvarchar](255) NOT NULL,
	[MaxOccupancy] [int] NOT NULL,
	[BedType] [nvarchar](100) NOT NULL,
	[BaseFare] [decimal](10, 2) NOT NULL,
	[RoomSize] [nvarchar](50) NOT NULL,
	[Acstatus] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Room] PRIMARY KEY CLUSTERED 
(
	[RoomId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoomImages]    Script Date: 18-03-2024 20:53:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoomImages](
	[ImageId] [int] IDENTITY(1,1) NOT NULL,
	[RoomId] [int] NOT NULL,
	[ImageUrl] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_RoomImages] PRIMARY KEY CLUSTERED 
(
	[ImageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 18-03-2024 20:53:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](100) NOT NULL,
	[LastName] [nvarchar](100) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[Password] [nvarchar](255) NOT NULL,
	[Gender] [nvarchar](50) NOT NULL,
	[ContactNumber] [nvarchar](20) NOT NULL,
	[Address] [nvarchar](max) NOT NULL,
	[Role] [nvarchar](50) NULL,
	[ProfileImage] [nvarchar](255) NOT NULL,
	[ResetPasswordExpires] [datetime2](7) NULL,
	[Token] [nvarchar](max) NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20240218194720_CozyHeavenStayMig', N'6.0.13')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20240218195057_CozyHeavenStayMigV1', N'6.0.13')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20240219103243_CozyMG', N'6.0.13')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20240227112852_Token-mig', N'6.0.13')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20240229133816_paymentMig', N'6.0.13')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20240312191527_reviewMig', N'6.0.13')
GO
SET IDENTITY_INSERT [dbo].[Admin] ON 

INSERT [dbo].[Admin] ([AdminId], [FirstName], [LastName], [Email], [Password], [profileImage], [Role], [ResetPasswordExpires], [Token]) VALUES (1, N'Admin', N'Bhai', N'admin123@gmail.com', N'FNQAbHvEsScUoRu84NALrwHZSPLsBZWvM0nbSmom3DbiGzjf', N'https://res.cloudinary.com/dnamivbjx/image/upload/v1710277346/CozyHeaven/p2.png', N'Admin', NULL, NULL)
SET IDENTITY_INSERT [dbo].[Admin] OFF
GO
SET IDENTITY_INSERT [dbo].[Booking] ON 

INSERT [dbo].[Booking] ([BookingId], [UserId], [RoomId], [NumberOfGuests], [CheckInDate], [CheckOutDate], [TotalFare], [Status], [HotelId], [PaymentId]) VALUES (1, 1, 1, 1, CAST(N'2024-03-13T06:00:00.000' AS DateTime), CAST(N'2024-03-14T13:00:00.000' AS DateTime), CAST(700.00 AS Decimal(10, 2)), N'Confirmed', 1, NULL)
INSERT [dbo].[Booking] ([BookingId], [UserId], [RoomId], [NumberOfGuests], [CheckInDate], [CheckOutDate], [TotalFare], [Status], [HotelId], [PaymentId]) VALUES (2, 2, 12, 2, CAST(N'2024-03-13T06:00:00.000' AS DateTime), CAST(N'2024-03-14T13:00:00.000' AS DateTime), CAST(1300.00 AS Decimal(10, 2)), N'Canceled', 7, 2)
INSERT [dbo].[Booking] ([BookingId], [UserId], [RoomId], [NumberOfGuests], [CheckInDate], [CheckOutDate], [TotalFare], [Status], [HotelId], [PaymentId]) VALUES (3, 2, 3, 1, CAST(N'2024-03-13T06:00:00.000' AS DateTime), CAST(N'2024-03-14T13:00:00.000' AS DateTime), CAST(1300.00 AS Decimal(10, 2)), N'Canceled', 2, 3)
INSERT [dbo].[Booking] ([BookingId], [UserId], [RoomId], [NumberOfGuests], [CheckInDate], [CheckOutDate], [TotalFare], [Status], [HotelId], [PaymentId]) VALUES (1001, 2, 1, 2, CAST(N'2024-03-15T06:00:00.000' AS DateTime), CAST(N'2024-03-16T13:00:00.000' AS DateTime), CAST(1100.00 AS Decimal(10, 2)), N'Canceled', 1, 1001)
INSERT [dbo].[Booking] ([BookingId], [UserId], [RoomId], [NumberOfGuests], [CheckInDate], [CheckOutDate], [TotalFare], [Status], [HotelId], [PaymentId]) VALUES (1002, 2, 5, 1, CAST(N'2024-03-15T06:00:00.000' AS DateTime), CAST(N'2024-03-16T13:00:00.000' AS DateTime), CAST(1540.00 AS Decimal(10, 2)), N'Confirmed', 3, 1002)
INSERT [dbo].[Booking] ([BookingId], [UserId], [RoomId], [NumberOfGuests], [CheckInDate], [CheckOutDate], [TotalFare], [Status], [HotelId], [PaymentId]) VALUES (1003, 2, 5, 3, CAST(N'2024-03-17T06:00:00.000' AS DateTime), CAST(N'2024-03-21T13:00:00.000' AS DateTime), CAST(2020.00 AS Decimal(10, 2)), N'Pending', 3, 1003)
INSERT [dbo].[Booking] ([BookingId], [UserId], [RoomId], [NumberOfGuests], [CheckInDate], [CheckOutDate], [TotalFare], [Status], [HotelId], [PaymentId]) VALUES (1004, 2, 1, 3, CAST(N'2024-03-22T06:00:00.000' AS DateTime), CAST(N'2024-03-29T13:00:00.000' AS DateTime), CAST(1500.00 AS Decimal(10, 2)), N'Confirmed', 1, 1004)
INSERT [dbo].[Booking] ([BookingId], [UserId], [RoomId], [NumberOfGuests], [CheckInDate], [CheckOutDate], [TotalFare], [Status], [HotelId], [PaymentId]) VALUES (1005, 2, 2, 1, CAST(N'2024-03-18T06:00:00.000' AS DateTime), CAST(N'2024-03-19T13:00:00.000' AS DateTime), CAST(1900.00 AS Decimal(10, 2)), N'Confirmed', 1, 1005)
SET IDENTITY_INSERT [dbo].[Booking] OFF
GO
SET IDENTITY_INSERT [dbo].[HotelImages] ON 

INSERT [dbo].[HotelImages] ([ImageId], [HotelId], [ImageUrl]) VALUES (1, 1, N'http://res.cloudinary.com/dnamivbjx/image/upload/v1710270657/CozyHeaven/Hotel/hotel1.jpg.jpg')
INSERT [dbo].[HotelImages] ([ImageId], [HotelId], [ImageUrl]) VALUES (2, 1, N'http://res.cloudinary.com/dnamivbjx/image/upload/v1710270659/CozyHeaven/Hotel/hotel10.png.png')
INSERT [dbo].[HotelImages] ([ImageId], [HotelId], [ImageUrl]) VALUES (3, 1, N'http://res.cloudinary.com/dnamivbjx/image/upload/v1710270660/CozyHeaven/Hotel/hotel11.png.png')
INSERT [dbo].[HotelImages] ([ImageId], [HotelId], [ImageUrl]) VALUES (4, 1, N'http://res.cloudinary.com/dnamivbjx/image/upload/v1710270662/CozyHeaven/Hotel/hotel12.png.png')
INSERT [dbo].[HotelImages] ([ImageId], [HotelId], [ImageUrl]) VALUES (5, 2, N'http://res.cloudinary.com/dnamivbjx/image/upload/v1710270664/CozyHeaven/Hotel/hotel13.jpg.jpg')
INSERT [dbo].[HotelImages] ([ImageId], [HotelId], [ImageUrl]) VALUES (6, 2, N'http://res.cloudinary.com/dnamivbjx/image/upload/v1710270665/CozyHeaven/Hotel/hotel14.png.png')
INSERT [dbo].[HotelImages] ([ImageId], [HotelId], [ImageUrl]) VALUES (7, 2, N'http://res.cloudinary.com/dnamivbjx/image/upload/v1710270667/CozyHeaven/Hotel/hotel15.png.png')
INSERT [dbo].[HotelImages] ([ImageId], [HotelId], [ImageUrl]) VALUES (8, 2, N'http://res.cloudinary.com/dnamivbjx/image/upload/v1710270669/CozyHeaven/Hotel/hotel16.png.png')
INSERT [dbo].[HotelImages] ([ImageId], [HotelId], [ImageUrl]) VALUES (9, 3, N'http://res.cloudinary.com/dnamivbjx/image/upload/v1710270671/CozyHeaven/Hotel/hotel17.png.png')
INSERT [dbo].[HotelImages] ([ImageId], [HotelId], [ImageUrl]) VALUES (10, 3, N'http://res.cloudinary.com/dnamivbjx/image/upload/v1710270673/CozyHeaven/Hotel/hotel18.png.png')
INSERT [dbo].[HotelImages] ([ImageId], [HotelId], [ImageUrl]) VALUES (11, 3, N'http://res.cloudinary.com/dnamivbjx/image/upload/v1710270675/CozyHeaven/Hotel/hotel19.png.png')
INSERT [dbo].[HotelImages] ([ImageId], [HotelId], [ImageUrl]) VALUES (12, 3, N'http://res.cloudinary.com/dnamivbjx/image/upload/v1710270677/CozyHeaven/Hotel/hotel2.png.png')
INSERT [dbo].[HotelImages] ([ImageId], [HotelId], [ImageUrl]) VALUES (13, 4, N'http://res.cloudinary.com/dnamivbjx/image/upload/v1710270679/CozyHeaven/Hotel/hotel20.png.png')
INSERT [dbo].[HotelImages] ([ImageId], [HotelId], [ImageUrl]) VALUES (14, 4, N'http://res.cloudinary.com/dnamivbjx/image/upload/v1710270681/CozyHeaven/Hotel/hotel21.png.png')
INSERT [dbo].[HotelImages] ([ImageId], [HotelId], [ImageUrl]) VALUES (15, 4, N'http://res.cloudinary.com/dnamivbjx/image/upload/v1710270683/CozyHeaven/Hotel/hotel22.png.png')
INSERT [dbo].[HotelImages] ([ImageId], [HotelId], [ImageUrl]) VALUES (16, 4, N'http://res.cloudinary.com/dnamivbjx/image/upload/v1710270686/CozyHeaven/Hotel/hotel23.png.png')
INSERT [dbo].[HotelImages] ([ImageId], [HotelId], [ImageUrl]) VALUES (17, 5, N'http://res.cloudinary.com/dnamivbjx/image/upload/v1710270687/CozyHeaven/Hotel/hotel24.png.png')
INSERT [dbo].[HotelImages] ([ImageId], [HotelId], [ImageUrl]) VALUES (18, 5, N'http://res.cloudinary.com/dnamivbjx/image/upload/v1710270689/CozyHeaven/Hotel/hotel25.jpg.jpg')
INSERT [dbo].[HotelImages] ([ImageId], [HotelId], [ImageUrl]) VALUES (19, 5, N'http://res.cloudinary.com/dnamivbjx/image/upload/v1710270691/CozyHeaven/Hotel/hotel26.png.png')
INSERT [dbo].[HotelImages] ([ImageId], [HotelId], [ImageUrl]) VALUES (20, 5, N'http://res.cloudinary.com/dnamivbjx/image/upload/v1710270693/CozyHeaven/Hotel/hotel27.png.png')
INSERT [dbo].[HotelImages] ([ImageId], [HotelId], [ImageUrl]) VALUES (21, 6, N'https://res.cloudinary.com/dnamivbjx/image/upload/v1710275459/CozyHeaven/hotel9.png')
INSERT [dbo].[HotelImages] ([ImageId], [HotelId], [ImageUrl]) VALUES (22, 6, N'https://res.cloudinary.com/dnamivbjx/image/upload/v1710275465/CozyHeaven/hotel10.png')
INSERT [dbo].[HotelImages] ([ImageId], [HotelId], [ImageUrl]) VALUES (23, 6, N'https://res.cloudinary.com/dnamivbjx/image/upload/v1710275469/CozyHeaven/hotel11.png')
INSERT [dbo].[HotelImages] ([ImageId], [HotelId], [ImageUrl]) VALUES (24, 6, N'https://res.cloudinary.com/dnamivbjx/image/upload/v1710275471/CozyHeaven/hotel12.png')
INSERT [dbo].[HotelImages] ([ImageId], [HotelId], [ImageUrl]) VALUES (25, 7, N'https://res.cloudinary.com/dnamivbjx/image/upload/v1710275849/CozyHeaven/hotel1.jpg')
INSERT [dbo].[HotelImages] ([ImageId], [HotelId], [ImageUrl]) VALUES (26, 7, N'https://res.cloudinary.com/dnamivbjx/image/upload/v1710275465/CozyHeaven/hotel10.png')
INSERT [dbo].[HotelImages] ([ImageId], [HotelId], [ImageUrl]) VALUES (27, 7, N'https://res.cloudinary.com/dnamivbjx/image/upload/v1710275469/CozyHeaven/hotel11.png')
INSERT [dbo].[HotelImages] ([ImageId], [HotelId], [ImageUrl]) VALUES (28, 7, N'https://res.cloudinary.com/dnamivbjx/image/upload/v1710275471/CozyHeaven/hotel12.png')
SET IDENTITY_INSERT [dbo].[HotelImages] OFF
GO
SET IDENTITY_INSERT [dbo].[HotelOwners] ON 

INSERT [dbo].[HotelOwners] ([OwnerId], [FirstName], [LastName], [Email], [Password], [Gender], [ContactNumber], [Address], [ProfileImage], [Role], [ResetPasswordExpires], [Token]) VALUES (1, N'Lucy', N'Evans', N'owner123@gmail.com', N'FsP1vlSMA5Uw2iHY/jXUdClUuQuMPAHE/ds1fb3SpPXqfIeQ', N'Female', N'5465658547', N'Delhi', N'https://api.dicebear.com/5.x/initials/svg?seed=OwnerOne', N'Owner', NULL, N'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im93bmVyMTIzQGdtYWlsLmNvbSIsInJvbGUiOiJPd25lciIsIm5iZiI6MTcxMDI3NTIyMywiZXhwIjoxNzEwMjg2MDIzLCJpYXQiOjE3MTAyNzUyMjN9.YTOEnOXf2lpaofBonyXA-0sxAP8cozqDn-akJVZp6h-8-GmZkBT9GGeNkz0C1VKPhkalmXlakxdoWBFnem7OqQ')
INSERT [dbo].[HotelOwners] ([OwnerId], [FirstName], [LastName], [Email], [Password], [Gender], [ContactNumber], [Address], [ProfileImage], [Role], [ResetPasswordExpires], [Token]) VALUES (2, N'Owner', N'Two', N'owner321@gmail.com', N'CiApHC2I/gUhwKMTUWeB8JUAyuIPNJ4CvLi525eWuRkxh0dk', N'female', N'7845954568', N'Navi Mumbai', N'https://api.dicebear.com/5.x/initials/svg?seed=OwnerTwo', N'Owner', NULL, NULL)
SET IDENTITY_INSERT [dbo].[HotelOwners] OFF
GO
SET IDENTITY_INSERT [dbo].[Hotels] ON 

INSERT [dbo].[Hotels] ([HotelId], [OwnerId], [Name], [Location], [Description], [Amenities]) VALUES (1, 1, N'Royal Oasis', N'Main Street, Mumbai, 400001, Maharashtra, India', N'Luxury hotel with stunning views', N'WiFi,Swimming Pool,Spa,Gym,Restaurant')
INSERT [dbo].[Hotels] ([HotelId], [OwnerId], [Name], [Location], [Description], [Amenities]) VALUES (2, 2, N'Golden Tulip Grand', N'MG Road, Bangalore, 560001, Karnataka, India', N'Elegant hotel in the heart of the city', N'WiFi,Restaurant,Bar,Conference Rooms')
INSERT [dbo].[Hotels] ([HotelId], [OwnerId], [Name], [Location], [Description], [Amenities]) VALUES (3, 1, N'Serenity Residency', N'Park Street, Kolkata, 700001, West Bengal, India', N'Tranquil retreat for business and leisure travelers', N'WiFi,Spa,Gym,Restaurant')
INSERT [dbo].[Hotels] ([HotelId], [OwnerId], [Name], [Location], [Description], [Amenities]) VALUES (4, 1, N'Paradise Palace', N'Station Road, Jaipur, 302001, Rajasthan, India', N'Exquisite luxury experience with royal heritage', N'WiFi,Swimming Pool,Spa,Restaurant')
INSERT [dbo].[Hotels] ([HotelId], [OwnerId], [Name], [Location], [Description], [Amenities]) VALUES (5, 2, N'Emerald Heights', N'Lake Road, Udaipur, 313001, Rajasthan, India', N'Breathtaking views of lakes and palaces', N'WiFi,Spa,Gym,Restaurant,Lounge')
INSERT [dbo].[Hotels] ([HotelId], [OwnerId], [Name], [Location], [Description], [Amenities]) VALUES (6, 1, N'Mountain View Lodge', N'EFG Street,Shimla,745847,Himachal Pradesh,India', N'Tranquil lodge amidst scenic mountains', N'WiFi, Nature Trails, Campfire')
INSERT [dbo].[Hotels] ([HotelId], [OwnerId], [Name], [Location], [Description], [Amenities]) VALUES (7, 1, N'Grand Palace Hotel', N'EFG Street,Shimla,745878,Himachal Pradesh,India', N'Tranquil lodge amidst scenic mountains and rivers', N'WiFi, Nature Trails, Campfire, Bonefire, Free dining')
SET IDENTITY_INSERT [dbo].[Hotels] OFF
GO
SET IDENTITY_INSERT [dbo].[Payment] ON 

INSERT [dbo].[Payment] ([PaymentId], [BookingId], [RefundId], [PaymentMode], [Status], [Amount], [PaymentDate]) VALUES (1, 1, NULL, N'Online', N'Paid', CAST(700.00 AS Decimal(10, 2)), CAST(N'2024-03-12T19:51:36.007' AS DateTime))
INSERT [dbo].[Payment] ([PaymentId], [BookingId], [RefundId], [PaymentMode], [Status], [Amount], [PaymentDate]) VALUES (2, 2, 1, N'Online', N'Refunded', CAST(1300.00 AS Decimal(10, 2)), CAST(N'2024-03-13T03:46:49.007' AS DateTime))
INSERT [dbo].[Payment] ([PaymentId], [BookingId], [RefundId], [PaymentMode], [Status], [Amount], [PaymentDate]) VALUES (3, 3, 2, N'Online', N'Refunded', CAST(1300.00 AS Decimal(10, 2)), CAST(N'2024-03-13T04:07:11.250' AS DateTime))
INSERT [dbo].[Payment] ([PaymentId], [BookingId], [RefundId], [PaymentMode], [Status], [Amount], [PaymentDate]) VALUES (1001, 1001, 3, N'Online', N'Refunded', CAST(1100.00 AS Decimal(10, 2)), CAST(N'2024-03-15T09:06:30.687' AS DateTime))
INSERT [dbo].[Payment] ([PaymentId], [BookingId], [RefundId], [PaymentMode], [Status], [Amount], [PaymentDate]) VALUES (1002, 1002, NULL, N'Online', N'Paid', CAST(1540.00 AS Decimal(10, 2)), CAST(N'2024-03-15T09:34:33.593' AS DateTime))
INSERT [dbo].[Payment] ([PaymentId], [BookingId], [RefundId], [PaymentMode], [Status], [Amount], [PaymentDate]) VALUES (1003, 1003, NULL, N'None', N'Pending', CAST(2020.00 AS Decimal(10, 2)), CAST(N'2024-03-15T09:35:13.660' AS DateTime))
INSERT [dbo].[Payment] ([PaymentId], [BookingId], [RefundId], [PaymentMode], [Status], [Amount], [PaymentDate]) VALUES (1004, 1004, NULL, N'Online', N'Paid', CAST(1500.00 AS Decimal(10, 2)), CAST(N'2024-03-15T09:48:43.140' AS DateTime))
INSERT [dbo].[Payment] ([PaymentId], [BookingId], [RefundId], [PaymentMode], [Status], [Amount], [PaymentDate]) VALUES (1005, 1005, NULL, N'Online', N'Paid', CAST(1900.00 AS Decimal(10, 2)), CAST(N'2024-03-18T14:57:32.527' AS DateTime))
SET IDENTITY_INSERT [dbo].[Payment] OFF
GO
SET IDENTITY_INSERT [dbo].[Refund] ON 

INSERT [dbo].[Refund] ([RefundId], [PaymentId], [RefundAmount], [RefundDate], [Reason], [RefundStatus]) VALUES (1, 2, CAST(1300.00 AS Decimal(10, 2)), CAST(N'2024-03-13T04:12:08.847' AS DateTime), N'Booking Canceled', N'Approved')
INSERT [dbo].[Refund] ([RefundId], [PaymentId], [RefundAmount], [RefundDate], [Reason], [RefundStatus]) VALUES (2, 3, CAST(1300.00 AS Decimal(10, 2)), CAST(N'2024-03-15T08:42:00.420' AS DateTime), N'Booking Canceled', N'Pending')
INSERT [dbo].[Refund] ([RefundId], [PaymentId], [RefundAmount], [RefundDate], [Reason], [RefundStatus]) VALUES (3, 1001, CAST(1100.00 AS Decimal(10, 2)), CAST(N'2024-03-15T09:36:51.500' AS DateTime), N'Booking Canceled', N'Approved')
SET IDENTITY_INSERT [dbo].[Refund] OFF
GO
SET IDENTITY_INSERT [dbo].[Reviews] ON 

INSERT [dbo].[Reviews] ([ReviewId], [UserId], [HotelId], [Rating], [Comments], [Date]) VALUES (1, 1, 1, 4, N'I had a great experience staying at this hotel. The room was comfortable, the staff was friendly and helpful. The location is convenient, with easy access to nearby attractions. Overall, I highly recommend this hotel for a pleasant stay.', CAST(N'2024-01-12T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Reviews] ([ReviewId], [UserId], [HotelId], [Rating], [Comments], [Date]) VALUES (2, 1, 2, 5, N'My stay at this hotel was amazing! The room was clean and spacious, and the view from the window was breathtaking. The hotel staff provided excellent service, and the amenities were top-notch. I would definitely stay here again.', CAST(N'2024-02-07T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Reviews] ([ReviewId], [UserId], [HotelId], [Rating], [Comments], [Date]) VALUES (3, 1, 3, 3, N'Overall, my stay at this hotel was decent. The room was okay, but nothing exceptional. The staff was friendly, but the service could be improved. The location is convenient, close to public transportation.', CAST(N'2024-01-12T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Reviews] ([ReviewId], [UserId], [HotelId], [Rating], [Comments], [Date]) VALUES (4, 1, 4, 5, N'I had an excellent experience at this hotel. The room was cozy and well-maintained. The staff went above and beyond to ensure a pleasant stay. The hotel amenities were fantastic, especially the pool and spa.', CAST(N'2024-03-11T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Reviews] ([ReviewId], [UserId], [HotelId], [Rating], [Comments], [Date]) VALUES (5, 1, 5, 2, N'Unfortunately, my experience at this hotel was disappointing. The room was not clean upon arrival, and the staff seemed indifferent to guest concerns. The location was convenient, but I expected better service.', CAST(N'2023-02-07T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Reviews] ([ReviewId], [UserId], [HotelId], [Rating], [Comments], [Date]) VALUES (6, 1, 1, 5, N'My stay at this hotel was amazing! The room was clean and spacious, and the view from the window was breathtaking. The hotel staff provided excellent service, and the amenities were top-notch. I would definitely stay here again.', CAST(N'2024-03-12T20:25:58.4910000' AS DateTime2))
INSERT [dbo].[Reviews] ([ReviewId], [UserId], [HotelId], [Rating], [Comments], [Date]) VALUES (7, 2, 7, 5, N'I had an excellent experience at this hotel. The room was cozy and well-maintained. The staff went above and beyond to ensure a pleasant stay. The hotel amenities were fantastic, especially the pool and spa.', CAST(N'2024-03-13T03:45:53.6690000' AS DateTime2))
INSERT [dbo].[Reviews] ([ReviewId], [UserId], [HotelId], [Rating], [Comments], [Date]) VALUES (1001, 2, 3, 3, N'nice hotel', CAST(N'2024-03-15T09:33:46.1500000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[Reviews] OFF
GO
SET IDENTITY_INSERT [dbo].[Room] ON 

INSERT [dbo].[Room] ([RoomId], [HotelId], [RoomType], [MaxOccupancy], [BedType], [BaseFare], [RoomSize], [Acstatus]) VALUES (1, 1, N'Single', 1, N'Single bed', CAST(1000.00 AS Decimal(10, 2)), N'70 m2 / 753 ft2', N'AC')
INSERT [dbo].[Room] ([RoomId], [HotelId], [RoomType], [MaxOccupancy], [BedType], [BaseFare], [RoomSize], [Acstatus]) VALUES (2, 1, N'Double', 2, N'Double bed', CAST(1500.00 AS Decimal(10, 2)), N'80 m2 / 861 ft2', N'Non-AC')
INSERT [dbo].[Room] ([RoomId], [HotelId], [RoomType], [MaxOccupancy], [BedType], [BaseFare], [RoomSize], [Acstatus]) VALUES (3, 2, N'Double', 2, N'King size', CAST(2000.00 AS Decimal(10, 2)), N'90 m2 / 968 ft2', N'AC')
INSERT [dbo].[Room] ([RoomId], [HotelId], [RoomType], [MaxOccupancy], [BedType], [BaseFare], [RoomSize], [Acstatus]) VALUES (4, 2, N'Suite', 4, N'Double bed', CAST(3000.00 AS Decimal(10, 2)), N'100 m2 / 1076 ft2', N'AC')
INSERT [dbo].[Room] ([RoomId], [HotelId], [RoomType], [MaxOccupancy], [BedType], [BaseFare], [RoomSize], [Acstatus]) VALUES (5, 3, N'Single', 1, N'Single bed', CAST(1200.00 AS Decimal(10, 2)), N'70 m2 / 753 ft2', N'AC')
INSERT [dbo].[Room] ([RoomId], [HotelId], [RoomType], [MaxOccupancy], [BedType], [BaseFare], [RoomSize], [Acstatus]) VALUES (6, 3, N'Double', 2, N'Double bed', CAST(1800.00 AS Decimal(10, 2)), N'80 m2 / 861 ft2', N'Non-AC')
INSERT [dbo].[Room] ([RoomId], [HotelId], [RoomType], [MaxOccupancy], [BedType], [BaseFare], [RoomSize], [Acstatus]) VALUES (7, 4, N'Single', 1, N'Single bed', CAST(1100.00 AS Decimal(10, 2)), N'70 m2 / 753 ft2', N'AC')
INSERT [dbo].[Room] ([RoomId], [HotelId], [RoomType], [MaxOccupancy], [BedType], [BaseFare], [RoomSize], [Acstatus]) VALUES (8, 4, N'Double', 2, N'Double bed', CAST(1600.00 AS Decimal(10, 2)), N'80 m2 / 861 ft2', N'AC')
INSERT [dbo].[Room] ([RoomId], [HotelId], [RoomType], [MaxOccupancy], [BedType], [BaseFare], [RoomSize], [Acstatus]) VALUES (9, 5, N'Single', 1, N'Single bed', CAST(1300.00 AS Decimal(10, 2)), N'70 m2 / 753 ft2', N'Non-AC')
INSERT [dbo].[Room] ([RoomId], [HotelId], [RoomType], [MaxOccupancy], [BedType], [BaseFare], [RoomSize], [Acstatus]) VALUES (10, 5, N'Suite', 4, N'King size', CAST(2500.00 AS Decimal(10, 2)), N'100 m2 / 1076 ft2', N'AC')
INSERT [dbo].[Room] ([RoomId], [HotelId], [RoomType], [MaxOccupancy], [BedType], [BaseFare], [RoomSize], [Acstatus]) VALUES (11, 6, N'Double', 2, N'Double bed', CAST(1799.00 AS Decimal(10, 2)), N'90 m2 / 968 ft2', N'Non-AC')
INSERT [dbo].[Room] ([RoomId], [HotelId], [RoomType], [MaxOccupancy], [BedType], [BaseFare], [RoomSize], [Acstatus]) VALUES (12, 7, N'Double', 2, N'Single bed', CAST(1000.00 AS Decimal(10, 2)), N'90 m2 / 968 ft2', N'Non-AC')
INSERT [dbo].[Room] ([RoomId], [HotelId], [RoomType], [MaxOccupancy], [BedType], [BaseFare], [RoomSize], [Acstatus]) VALUES (13, 7, N'Double', 2, N'Single bed', CAST(800.00 AS Decimal(10, 2)), N'80 m2 / 861 ft2', N'AC')
SET IDENTITY_INSERT [dbo].[Room] OFF
GO
SET IDENTITY_INSERT [dbo].[RoomImages] ON 

INSERT [dbo].[RoomImages] ([ImageId], [RoomId], [ImageUrl]) VALUES (1, 1, N'http://res.cloudinary.com/dnamivbjx/image/upload/v1710270823/CozyHeaven/Room/room1.png.png')
INSERT [dbo].[RoomImages] ([ImageId], [RoomId], [ImageUrl]) VALUES (2, 2, N'http://res.cloudinary.com/dnamivbjx/image/upload/v1710270834/CozyHeaven/Room/room2.png.png')
INSERT [dbo].[RoomImages] ([ImageId], [RoomId], [ImageUrl]) VALUES (3, 3, N'http://res.cloudinary.com/dnamivbjx/image/upload/v1710270836/CozyHeaven/Room/room3.png.png')
INSERT [dbo].[RoomImages] ([ImageId], [RoomId], [ImageUrl]) VALUES (4, 4, N'http://res.cloudinary.com/dnamivbjx/image/upload/v1710270838/CozyHeaven/Room/room4.png.png')
INSERT [dbo].[RoomImages] ([ImageId], [RoomId], [ImageUrl]) VALUES (5, 5, N'http://res.cloudinary.com/dnamivbjx/image/upload/v1710270840/CozyHeaven/Room/room5.png.png')
INSERT [dbo].[RoomImages] ([ImageId], [RoomId], [ImageUrl]) VALUES (6, 6, N'http://res.cloudinary.com/dnamivbjx/image/upload/v1710270841/CozyHeaven/Room/room6.png.png')
INSERT [dbo].[RoomImages] ([ImageId], [RoomId], [ImageUrl]) VALUES (7, 7, N'http://res.cloudinary.com/dnamivbjx/image/upload/v1710270844/CozyHeaven/Room/room7.png.png')
INSERT [dbo].[RoomImages] ([ImageId], [RoomId], [ImageUrl]) VALUES (8, 8, N'http://res.cloudinary.com/dnamivbjx/image/upload/v1710270845/CozyHeaven/Room/room8.png.png')
INSERT [dbo].[RoomImages] ([ImageId], [RoomId], [ImageUrl]) VALUES (9, 9, N'http://res.cloudinary.com/dnamivbjx/image/upload/v1710270847/CozyHeaven/Room/room9.png.png')
INSERT [dbo].[RoomImages] ([ImageId], [RoomId], [ImageUrl]) VALUES (10, 10, N'http://res.cloudinary.com/dnamivbjx/image/upload/v1710270825/CozyHeaven/Room/room10.png.png')
INSERT [dbo].[RoomImages] ([ImageId], [RoomId], [ImageUrl]) VALUES (11, 11, N'https://res.cloudinary.com/dnamivbjx/image/upload/v1710275514/CozyHeaven/room8.png')
INSERT [dbo].[RoomImages] ([ImageId], [RoomId], [ImageUrl]) VALUES (12, 12, N'https://res.cloudinary.com/dnamivbjx/image/upload/v1710275895/CozyHeaven/room10.png')
INSERT [dbo].[RoomImages] ([ImageId], [RoomId], [ImageUrl]) VALUES (13, 13, N'https://res.cloudinary.com/dnamivbjx/image/upload/v1710275895/CozyHeaven/room10.png')
INSERT [dbo].[RoomImages] ([ImageId], [RoomId], [ImageUrl]) VALUES (14, 13, N'https://res.cloudinary.com/dnamivbjx/image/upload/v1710275514/CozyHeaven/room8.png')
INSERT [dbo].[RoomImages] ([ImageId], [RoomId], [ImageUrl]) VALUES (15, 12, N'https://res.cloudinary.com/dnamivbjx/image/upload/v1710275514/CozyHeaven/room8.png')
SET IDENTITY_INSERT [dbo].[RoomImages] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [Email], [Password], [Gender], [ContactNumber], [Address], [Role], [ProfileImage], [ResetPasswordExpires], [Token]) VALUES (1, N'User', N'Mike', N'user123@gmail.com', N'i2+pISaWYGr1SCWTQUtkmUDuvOXYIrsekgsJzJWj4KGoMmY+', N'Male', N'1254658795', N'Mumbai', N'User', N'https://res.cloudinary.com/dnamivbjx/image/upload/v1710274002/CozyHeaven/p1.png', NULL, N'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InVzZXIxMjNAZ21haWwuY29tIiwicm9sZSI6IlVzZXIiLCJuYmYiOjE3MTAyNzQzODYsImV4cCI6MTcxMDI4NTE4NiwiaWF0IjoxNzEwMjc0Mzg2fQ.hPjMfhhtzB00xHqeB5I-uVq6Etfli7EFthLdVpjKZrmRLu6aYiaL8MhI_MHSExpRIz_CCkokoyIhaVd7V6CwoQ')
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [Email], [Password], [Gender], [ContactNumber], [Address], [Role], [ProfileImage], [ResetPasswordExpires], [Token]) VALUES (2, N'Deepraj', N'chawda', N'deeprajchawda@gmail.com', N'hhH4Ld1UFtu2Wc6eVq86Tb/WS3VDUUkAE2/f6dAmTRATWarq', N'male', N'9644230409', N'agrod', N'User', N'https://res.cloudinary.com/dnamivbjx/image/upload/v1710303229/CozyHeaven/01.jpg', CAST(N'2024-03-15T15:31:24.9532307' AS DateTime2), N'A736635296CEE268D1CAD5F080E0EE594126144CB85B0D70692D807AB1228F36209F98515EE1A734A9A5C11123009DEC7C27B057CD27B11E1C1C24B4C9F6CDA2')
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [Email], [Password], [Gender], [ContactNumber], [Address], [Role], [ProfileImage], [ResetPasswordExpires], [Token]) VALUES (3, N'Deepraj', N'chawda', N'deeprajchawda11@gmail.com', N'W80cHXPs5dZ4KM01ugRj+50K7Fa54lmehNeKhDs0JsBQhPRW', N'male', N'9644230409', N'agrod', N'User', N'https://api.dicebear.com/5.x/initials/svg?seed=Deeprajchawda', NULL, NULL)
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [Email], [Password], [Gender], [ContactNumber], [Address], [Role], [ProfileImage], [ResetPasswordExpires], [Token]) VALUES (1001, N'Deepraj', N'chawda', N'deeprajchawda123@gmail.com', N'oyVm7dFbQfTrKNM4gIwt3Z/u7VFoLCormOo5YPjpN3uKAUUQ', N'male', N'9644230409', N'agrod', N'User', N'https://api.dicebear.com/5.x/initials/svg?seed=Deeprajchawda', NULL, NULL)
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [Email], [Password], [Gender], [ContactNumber], [Address], [Role], [ProfileImage], [ResetPasswordExpires], [Token]) VALUES (1002, N'Deepraj', N'chawda', N'deepraj123@gmail.com', N'uq4i+riS6tXM0UHRVGvpUS1/o6rasx4FFf6ciDaVdbb1TuOW', N'male', N'9644230409', N'agrod', N'User', N'https://api.dicebear.com/5.x/initials/svg?seed=Deeprajchawda', NULL, NULL)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
ALTER TABLE [dbo].[Admin] ADD  DEFAULT (N'Admin') FOR [Role]
GO
ALTER TABLE [dbo].[HotelOwners] ADD  DEFAULT (N'Owner') FOR [Role]
GO
ALTER TABLE [dbo].[Refund] ADD  DEFAULT (N'Not Approved') FOR [RefundStatus]
GO
ALTER TABLE [dbo].[Reviews] ADD  DEFAULT ('0001-01-01T00:00:00.0000000') FOR [Date]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (N'Guest') FOR [Role]
GO
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD  CONSTRAINT [FK_Booking_Hotel] FOREIGN KEY([HotelId])
REFERENCES [dbo].[Hotels] ([HotelId])
GO
ALTER TABLE [dbo].[Booking] CHECK CONSTRAINT [FK_Booking_Hotel]
GO
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD  CONSTRAINT [FK_Booking_Room] FOREIGN KEY([RoomId])
REFERENCES [dbo].[Room] ([RoomId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Booking] CHECK CONSTRAINT [FK_Booking_Room]
GO
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD  CONSTRAINT [FK_Booking_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Booking] CHECK CONSTRAINT [FK_Booking_User]
GO
ALTER TABLE [dbo].[HotelImages]  WITH CHECK ADD  CONSTRAINT [FK_HotelImage_Hotel] FOREIGN KEY([HotelId])
REFERENCES [dbo].[Hotels] ([HotelId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[HotelImages] CHECK CONSTRAINT [FK_HotelImage_Hotel]
GO
ALTER TABLE [dbo].[Hotels]  WITH CHECK ADD  CONSTRAINT [FK_Hotel_HotelOwner] FOREIGN KEY([OwnerId])
REFERENCES [dbo].[HotelOwners] ([OwnerId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Hotels] CHECK CONSTRAINT [FK_Hotel_HotelOwner]
GO
ALTER TABLE [dbo].[Payment]  WITH CHECK ADD  CONSTRAINT [FK_Payment_Booking] FOREIGN KEY([BookingId])
REFERENCES [dbo].[Booking] ([BookingId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Payment] CHECK CONSTRAINT [FK_Payment_Booking]
GO
ALTER TABLE [dbo].[Refund]  WITH CHECK ADD  CONSTRAINT [FK_Refund_Payment] FOREIGN KEY([PaymentId])
REFERENCES [dbo].[Payment] ([PaymentId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Refund] CHECK CONSTRAINT [FK_Refund_Payment]
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD  CONSTRAINT [FK_Review_Hotel] FOREIGN KEY([HotelId])
REFERENCES [dbo].[Hotels] ([HotelId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Reviews] CHECK CONSTRAINT [FK_Review_Hotel]
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD  CONSTRAINT [FK_Review_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Reviews] CHECK CONSTRAINT [FK_Review_User]
GO
ALTER TABLE [dbo].[Room]  WITH CHECK ADD  CONSTRAINT [FK_Room_Hotel] FOREIGN KEY([HotelId])
REFERENCES [dbo].[Hotels] ([HotelId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Room] CHECK CONSTRAINT [FK_Room_Hotel]
GO
ALTER TABLE [dbo].[RoomImages]  WITH CHECK ADD  CONSTRAINT [FK_RoomImage_Room] FOREIGN KEY([RoomId])
REFERENCES [dbo].[Room] ([RoomId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RoomImages] CHECK CONSTRAINT [FK_RoomImage_Room]
GO

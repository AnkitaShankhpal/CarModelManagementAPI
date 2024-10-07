-- Create the CarModelManagement2DB database
CREATE DATABASE [CarModelManagementDB]
GO

-- Use the newly created database
USE [CarModelManagementDB]
GO

-- Drop existing tables if they exist to avoid conflicts
IF OBJECT_ID('dbo.CarImages', 'U') IS NOT NULL DROP TABLE dbo.CarImages;
IF OBJECT_ID('dbo.SalesRecords', 'U') IS NOT NULL DROP TABLE dbo.SalesRecords;
IF OBJECT_ID('dbo.CarModels', 'U') IS NOT NULL DROP TABLE dbo.CarModels;
IF OBJECT_ID('dbo.Salesmen', 'U') IS NOT NULL DROP TABLE dbo.Salesmen;

-- ================================================
-- Table: Salesmen
-- ================================================
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Salesmen](
	[SalesmanId] [int] IDENTITY(1,1) NOT NULL,
	[SalesmanName] [nvarchar](100) NOT NULL,
	[LastYearTotalSales] [decimal](18, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SalesmanId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

-- ================================================
-- Table: SalesRecords
-- ================================================
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SalesRecords](
	[SalesRecordId] [int] IDENTITY(1,1) NOT NULL,
	[SalesmanId] [int] NULL,
	[Brand] [nvarchar](50) NOT NULL,
	[Class] [nvarchar](10) NOT NULL,
	[NumberOfCarsSold] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SalesRecordId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SalesRecords]  WITH CHECK ADD FOREIGN KEY([SalesmanId])
REFERENCES [dbo].[Salesmen] ([SalesmanId])
GO

-- ================================================
-- Table: CarModels
-- ================================================
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CarModels](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Brand] [nvarchar](50) NOT NULL,
	[Class] [nvarchar](10) NOT NULL,
	[ModelName] [nvarchar](100) NOT NULL,
	[ModelCode] [nvarchar](10) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[Features] [nvarchar](max) NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[DateOfManufacturing] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[SortOrder] [int] NOT NULL,
	[ImagePath] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

-- ================================================
-- Table: CarImages
-- ================================================
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CarImages](
	[ImageId] [int] IDENTITY(1,1) NOT NULL,
	[CarModelId] [int] NULL,
	[ImageUrl] [nvarchar](255) NOT NULL,
	[UploadDate] [datetime] NULL,
	[FileSize] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ImageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[CarImages] ADD  DEFAULT (getdate()) FOR [UploadDate]
GO

ALTER TABLE [dbo].[CarImages]  WITH CHECK ADD FOREIGN KEY([CarModelId])
REFERENCES [dbo].[CarModels] ([Id])
GO

ALTER TABLE [dbo].[CarImages]  WITH CHECK ADD CHECK  (([FileSize]<=(5242880)))
GO

USE [master]
GO
/****** Object:  Database [AfpEat]    Script Date: 05/03/2020 16:51:09 ******/
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'AfpEat')
BEGIN
CREATE DATABASE [AfpEat]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'AfpEat', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\AfpEat.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'AfpEat_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\AfpEat_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
END
GO
ALTER DATABASE [AfpEat] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [AfpEat].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [AfpEat] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [AfpEat] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [AfpEat] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [AfpEat] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [AfpEat] SET ARITHABORT OFF 
GO
ALTER DATABASE [AfpEat] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [AfpEat] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [AfpEat] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [AfpEat] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [AfpEat] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [AfpEat] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [AfpEat] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [AfpEat] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [AfpEat] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [AfpEat] SET  DISABLE_BROKER 
GO
ALTER DATABASE [AfpEat] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [AfpEat] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [AfpEat] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [AfpEat] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [AfpEat] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [AfpEat] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [AfpEat] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [AfpEat] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [AfpEat] SET  MULTI_USER 
GO
ALTER DATABASE [AfpEat] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [AfpEat] SET DB_CHAINING OFF 
GO
ALTER DATABASE [AfpEat] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [AfpEat] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [AfpEat] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [AfpEat] SET QUERY_STORE = OFF
GO
USE [AfpEat]
GO
/****** Object:  Table [dbo].[Allergene]    Script Date: 05/03/2020 16:51:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Allergene]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Allergene](
	[IdAllergene] [int] IDENTITY(1,1) NOT NULL,
	[Nom] [varchar](50) NOT NULL,
	[statut] [bit] NOT NULL,
 CONSTRAINT [PK_Allergene] PRIMARY KEY CLUSTERED 
(
	[IdAllergene] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Categorie]    Script Date: 05/03/2020 16:51:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Categorie]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Categorie](
	[IdCategorie] [int] IDENTITY(1,1) NOT NULL,
	[Nom] [varchar](50) NOT NULL,
	[Statut] [bit] NOT NULL,
 CONSTRAINT [PK_Categorie] PRIMARY KEY CLUSTERED 
(
	[IdCategorie] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Commande]    Script Date: 05/03/2020 16:51:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Commande]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Commande](
	[IdCommande] [int] IDENTITY(1,1) NOT NULL,
	[IdUtilisateur] [int] NOT NULL,
	[IdRestaurant] [int] NOT NULL,
	[DateCommande] [datetime] NOT NULL,
	[IdEtatCommande] [int] NOT NULL,
	[Prix] [decimal](10, 2) NOT NULL,
 CONSTRAINT [PK_Commande] PRIMARY KEY CLUSTERED 
(
	[IdCommande] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[CommandeProduit]    Script Date: 05/03/2020 16:51:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CommandeProduit]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CommandeProduit](
	[IdCommande] [int] NOT NULL,
	[IdProduit] [int] NOT NULL,
	[Quantite] [int] NOT NULL,
	[Prix] [decimal](10, 2) NOT NULL,
	[IdCommandeProduit] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_CommandeProduit] PRIMARY KEY CLUSTERED 
(
	[IdCommandeProduit] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[CommandeProduitMenu]    Script Date: 05/03/2020 16:51:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CommandeProduitMenu]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CommandeProduitMenu](
	[IdCommandeProduit] [int] NOT NULL,
	[IdMenu] [int] NOT NULL,
 CONSTRAINT [PK_CommandeProduitMenu] PRIMARY KEY CLUSTERED 
(
	[IdCommandeProduit] ASC,
	[IdMenu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[EtatCommande]    Script Date: 05/03/2020 16:51:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EtatCommande]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[EtatCommande](
	[IdEtatCommande] [int] IDENTITY(1,1) NOT NULL,
	[Nom] [varchar](50) NOT NULL,
	[Statut] [bit] NOT NULL,
 CONSTRAINT [PK_EtatCommande] PRIMARY KEY CLUSTERED 
(
	[IdEtatCommande] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Menu]    Script Date: 05/03/2020 16:51:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Menu]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Menu](
	[IdMenu] [int] IDENTITY(1,1) NOT NULL,
	[Nom] [varchar](50) NOT NULL,
	[Prix] [decimal](10, 2) NOT NULL,
	[Statut] [bit] NOT NULL,
	[IdRestaurant] [int] NOT NULL,
 CONSTRAINT [PK_Menu] PRIMARY KEY CLUSTERED 
(
	[IdMenu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[MenuCategorie]    Script Date: 05/03/2020 16:51:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MenuCategorie]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MenuCategorie](
	[IdMenu] [int] NOT NULL,
	[IdCategorie] [int] NOT NULL,
 CONSTRAINT [PK_MenuProduit] PRIMARY KEY CLUSTERED 
(
	[IdMenu] ASC,
	[IdCategorie] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Operation]    Script Date: 05/03/2020 16:51:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Operation]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Operation](
	[IdOperation] [int] IDENTITY(1,1) NOT NULL,
	[IdUtilisateur] [int] NOT NULL,
	[Montant] [decimal](10, 2) NOT NULL,
	[IdTypeVersement] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
 CONSTRAINT [PK_Operation] PRIMARY KEY CLUSTERED 
(
	[IdOperation] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Photo]    Script Date: 05/03/2020 16:51:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Photo]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Photo](
	[IdPhoto] [int] IDENTITY(1,1) NOT NULL,
	[Nom] [varchar](max) NOT NULL,
	[Statut] [bit] NOT NULL,
	[Url] [varchar](max) NOT NULL,
 CONSTRAINT [PK_Photo] PRIMARY KEY CLUSTERED 
(
	[IdPhoto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Produit]    Script Date: 05/03/2020 16:51:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Produit]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Produit](
	[IdProduit] [int] IDENTITY(1,1) NOT NULL,
	[IdRestaurant] [int] NOT NULL,
	[IdCategorie] [int] NOT NULL,
	[Nom] [varchar](50) NOT NULL,
	[Prix] [decimal](10, 2) NOT NULL,
	[Description] [varchar](max) NOT NULL,
	[Quantite] [int] NOT NULL,
	[Statut] [bit] NOT NULL,
 CONSTRAINT [PK_Produit] PRIMARY KEY CLUSTERED 
(
	[IdProduit] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ProduitAllergene]    Script Date: 05/03/2020 16:51:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProduitAllergene]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ProduitAllergene](
	[IdProduit] [int] NOT NULL,
	[IdAllergene] [int] NOT NULL,
 CONSTRAINT [PK_ProduitAllergene] PRIMARY KEY CLUSTERED 
(
	[IdProduit] ASC,
	[IdAllergene] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ProduitCompose]    Script Date: 05/03/2020 16:51:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProduitCompose]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ProduitCompose](
	[IdProduit] [int] NOT NULL,
	[IdProduitPere] [int] NOT NULL,
 CONSTRAINT [PK_ProduitCompose] PRIMARY KEY CLUSTERED 
(
	[IdProduit] ASC,
	[IdProduitPere] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ProduitMenu]    Script Date: 05/03/2020 16:51:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProduitMenu]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ProduitMenu](
	[IdCommandeProduit] [int] NOT NULL,
	[IdMenu] [int] NOT NULL,
 CONSTRAINT [PK_ProduitMenu] PRIMARY KEY CLUSTERED 
(
	[IdCommandeProduit] ASC,
	[IdMenu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ProduitPhoto]    Script Date: 05/03/2020 16:51:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProduitPhoto]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ProduitPhoto](
	[IdProduit] [int] NOT NULL,
	[IdPhoto] [int] NOT NULL,
 CONSTRAINT [PK_ProduitPhoto] PRIMARY KEY CLUSTERED 
(
	[IdProduit] ASC,
	[IdPhoto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Restaurant]    Script Date: 05/03/2020 16:51:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Restaurant]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Restaurant](
	[IdRestaurant] [int] IDENTITY(1,1) NOT NULL,
	[Nom] [varchar](50) NOT NULL,
	[Responsable] [varchar](50) NOT NULL,
	[IdTypeCuisine] [int] NOT NULL,
	[Adresse] [varchar](50) NOT NULL,
	[CodePostal] [varchar](50) NOT NULL,
	[Ville] [varchar](50) NOT NULL,
	[Mobile] [varchar](50) NOT NULL,
	[Telephone] [varchar](50) NOT NULL,
	[Login] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[Tag] [varchar](50) NULL,
	[Budget] [varchar](50) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[Description] [varchar](max) NOT NULL,
 CONSTRAINT [PK_Restaurant] PRIMARY KEY CLUSTERED 
(
	[IdRestaurant] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[RestaurantPhoto]    Script Date: 05/03/2020 16:51:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RestaurantPhoto]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RestaurantPhoto](
	[IdRestaurant] [int] NOT NULL,
	[IdPhoto] [int] NOT NULL,
 CONSTRAINT [PK_RestaurantPhoto] PRIMARY KEY CLUSTERED 
(
	[IdRestaurant] ASC,
	[IdPhoto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[SessionUtilisateur]    Script Date: 05/03/2020 16:51:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SessionUtilisateur]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SessionUtilisateur](
	[IdSession] [varchar](200) NOT NULL,
	[dateSession] [datetime] NOT NULL,
 CONSTRAINT [PK_SessionUtilisateur] PRIMARY KEY CLUSTERED 
(
	[IdSession] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[TypeCuisine]    Script Date: 05/03/2020 16:51:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TypeCuisine]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TypeCuisine](
	[IdTypeCuisine] [int] IDENTITY(1,1) NOT NULL,
	[Nom] [varchar](50) NOT NULL,
	[Statut] [bit] NOT NULL,
 CONSTRAINT [PK_TypeCuisine] PRIMARY KEY CLUSTERED 
(
	[IdTypeCuisine] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[TypeCuisinePhoto]    Script Date: 05/03/2020 16:51:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TypeCuisinePhoto]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TypeCuisinePhoto](
	[IdTypeCuisine] [int] NOT NULL,
	[IdPhoto] [int] NOT NULL,
 CONSTRAINT [PK_TypeCuisinePhoto] PRIMARY KEY CLUSTERED 
(
	[IdTypeCuisine] ASC,
	[IdPhoto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[TypeVersement]    Script Date: 05/03/2020 16:51:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TypeVersement]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TypeVersement](
	[IdTypeVersement] [int] IDENTITY(1,1) NOT NULL,
	[Nom] [varchar](50) NOT NULL,
	[Statut] [bit] NOT NULL,
 CONSTRAINT [PK_TypeVersement] PRIMARY KEY CLUSTERED 
(
	[IdTypeVersement] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Utilisateur]    Script Date: 05/03/2020 16:51:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Utilisateur]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Utilisateur](
	[IdUtilisateur] [int] IDENTITY(1,1) NOT NULL,
	[Nom] [varchar](50) NOT NULL,
	[Prenom] [varchar](50) NOT NULL,
	[Matricule] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[TypeCompte] [bit] NOT NULL,
	[Statut] [bit] NOT NULL,
	[IdSession] [varchar](max) NULL,
	[Solde] [decimal](10, 2) NULL,
 CONSTRAINT [PK_Utilisateur] PRIMARY KEY CLUSTERED 
(
	[IdUtilisateur] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [dbo].[Allergene] ON 

INSERT [dbo].[Allergene] ([IdAllergene], [Nom], [statut]) VALUES (1, N'Anhydride sulfureux et sulfites', 1)
INSERT [dbo].[Allergene] ([IdAllergene], [Nom], [statut]) VALUES (2, N'Arachides', 1)
INSERT [dbo].[Allergene] ([IdAllergene], [Nom], [statut]) VALUES (3, N'Céleri', 1)
INSERT [dbo].[Allergene] ([IdAllergene], [Nom], [statut]) VALUES (4, N'Crustacés', 1)
INSERT [dbo].[Allergene] ([IdAllergene], [Nom], [statut]) VALUES (5, N'Fruits à coques', 1)
INSERT [dbo].[Allergene] ([IdAllergene], [Nom], [statut]) VALUES (6, N'Gluten', 1)
INSERT [dbo].[Allergene] ([IdAllergene], [Nom], [statut]) VALUES (7, N'Graine de sésame', 1)
INSERT [dbo].[Allergene] ([IdAllergene], [Nom], [statut]) VALUES (8, N'Lait', 1)
INSERT [dbo].[Allergene] ([IdAllergene], [Nom], [statut]) VALUES (9, N'Lupin', 1)
INSERT [dbo].[Allergene] ([IdAllergene], [Nom], [statut]) VALUES (10, N'Mollusques', 1)
INSERT [dbo].[Allergene] ([IdAllergene], [Nom], [statut]) VALUES (11, N'Moutarde', 1)
INSERT [dbo].[Allergene] ([IdAllergene], [Nom], [statut]) VALUES (12, N'Oeufs', 1)
INSERT [dbo].[Allergene] ([IdAllergene], [Nom], [statut]) VALUES (13, N'Poissons', 1)
INSERT [dbo].[Allergene] ([IdAllergene], [Nom], [statut]) VALUES (14, N'Soja', 1)
SET IDENTITY_INSERT [dbo].[Allergene] OFF
SET IDENTITY_INSERT [dbo].[Categorie] ON 

INSERT [dbo].[Categorie] ([IdCategorie], [Nom], [Statut]) VALUES (1, N'Entrée Froide', 1)
INSERT [dbo].[Categorie] ([IdCategorie], [Nom], [Statut]) VALUES (2, N'Entrée Chaude', 1)
INSERT [dbo].[Categorie] ([IdCategorie], [Nom], [Statut]) VALUES (3, N'Plat', 1)
INSERT [dbo].[Categorie] ([IdCategorie], [Nom], [Statut]) VALUES (4, N'Dessert', 1)
INSERT [dbo].[Categorie] ([IdCategorie], [Nom], [Statut]) VALUES (5, N'Boisson', 1)
INSERT [dbo].[Categorie] ([IdCategorie], [Nom], [Statut]) VALUES (6, N'Salade', 1)
INSERT [dbo].[Categorie] ([IdCategorie], [Nom], [Statut]) VALUES (7, N'Pâtes', 1)
INSERT [dbo].[Categorie] ([IdCategorie], [Nom], [Statut]) VALUES (8, N'Panini', 1)
SET IDENTITY_INSERT [dbo].[Categorie] OFF
SET IDENTITY_INSERT [dbo].[Commande] ON 

INSERT [dbo].[Commande] ([IdCommande], [IdUtilisateur], [IdRestaurant], [DateCommande], [IdEtatCommande], [Prix]) VALUES (1, 1, 1, CAST(N'2020-02-27T11:03:44.880' AS DateTime), 1, CAST(5.00 AS Decimal(10, 2)))
INSERT [dbo].[Commande] ([IdCommande], [IdUtilisateur], [IdRestaurant], [DateCommande], [IdEtatCommande], [Prix]) VALUES (2, 1, 1, CAST(N'2020-03-05T14:01:50.793' AS DateTime), 1, CAST(8.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[Commande] OFF
SET IDENTITY_INSERT [dbo].[CommandeProduit] ON 

INSERT [dbo].[CommandeProduit] ([IdCommande], [IdProduit], [Quantite], [Prix], [IdCommandeProduit]) VALUES (1, 1, 1, CAST(5.00 AS Decimal(10, 2)), 1)
INSERT [dbo].[CommandeProduit] ([IdCommande], [IdProduit], [Quantite], [Prix], [IdCommandeProduit]) VALUES (2, 4, 1, CAST(3.00 AS Decimal(10, 2)), 2)
INSERT [dbo].[CommandeProduit] ([IdCommande], [IdProduit], [Quantite], [Prix], [IdCommandeProduit]) VALUES (2, 1, 1, CAST(5.00 AS Decimal(10, 2)), 3)
SET IDENTITY_INSERT [dbo].[CommandeProduit] OFF
SET IDENTITY_INSERT [dbo].[EtatCommande] ON 

INSERT [dbo].[EtatCommande] ([IdEtatCommande], [Nom], [Statut]) VALUES (1, N'En Attente', 1)
INSERT [dbo].[EtatCommande] ([IdEtatCommande], [Nom], [Statut]) VALUES (2, N'En Cours', 1)
INSERT [dbo].[EtatCommande] ([IdEtatCommande], [Nom], [Statut]) VALUES (3, N'Livré', 1)
SET IDENTITY_INSERT [dbo].[EtatCommande] OFF
SET IDENTITY_INSERT [dbo].[Menu] ON 

INSERT [dbo].[Menu] ([IdMenu], [Nom], [Prix], [Statut], [IdRestaurant]) VALUES (1, N'Menu1', CAST(15.00 AS Decimal(10, 2)), 1, 1)
INSERT [dbo].[Menu] ([IdMenu], [Nom], [Prix], [Statut], [IdRestaurant]) VALUES (2, N'Menu2', CAST(12.00 AS Decimal(10, 2)), 1, 1)
SET IDENTITY_INSERT [dbo].[Menu] OFF
INSERT [dbo].[MenuCategorie] ([IdMenu], [IdCategorie]) VALUES (1, 1)
INSERT [dbo].[MenuCategorie] ([IdMenu], [IdCategorie]) VALUES (1, 2)
INSERT [dbo].[MenuCategorie] ([IdMenu], [IdCategorie]) VALUES (1, 3)
INSERT [dbo].[MenuCategorie] ([IdMenu], [IdCategorie]) VALUES (2, 3)
INSERT [dbo].[MenuCategorie] ([IdMenu], [IdCategorie]) VALUES (2, 4)
INSERT [dbo].[MenuCategorie] ([IdMenu], [IdCategorie]) VALUES (2, 5)
SET IDENTITY_INSERT [dbo].[Photo] ON 

INSERT [dbo].[Photo] ([IdPhoto], [Nom], [Statut], [Url]) VALUES (1, N'MonResto', 1, N'/Images/Upload/restaurant1.jpg')
INSERT [dbo].[Photo] ([IdPhoto], [Nom], [Statut], [Url]) VALUES (2, N'korean-cabbage-in-chili-sauce-1120406_1920.jpg', 1, N'/Images/Upload/korean-cabbage-in-chili-sauce-1120406_1920.jpg')
INSERT [dbo].[Photo] ([IdPhoto], [Nom], [Statut], [Url]) VALUES (3, N'Pizza.jpg', 1, N'/Images/Upload/Pizza.jpg')
INSERT [dbo].[Photo] ([IdPhoto], [Nom], [Statut], [Url]) VALUES (4, N'Libannais.jpg', 1, N'/Images/Upload/Libannais.jpg')
INSERT [dbo].[Photo] ([IdPhoto], [Nom], [Statut], [Url]) VALUES (5, N'Mexicain.jpg', 1, N'/Images/Upload/Mexicain.jpg')
INSERT [dbo].[Photo] ([IdPhoto], [Nom], [Statut], [Url]) VALUES (6, N'Japonnais.jpg', 1, N'/Images/Upload/Japonnais.jpg')
INSERT [dbo].[Photo] ([IdPhoto], [Nom], [Statut], [Url]) VALUES (7, N'Indien.jpg', 1, N'/Images/Upload/Indien.jpg')
INSERT [dbo].[Photo] ([IdPhoto], [Nom], [Statut], [Url]) VALUES (8, N'Burger.jpg', 1, N'/Images/Upload/Burger.jpg')
INSERT [dbo].[Photo] ([IdPhoto], [Nom], [Statut], [Url]) VALUES (9, N'Chinois.jpg', 1, N'/Images/Upload/Chinois.jpg')
INSERT [dbo].[Photo] ([IdPhoto], [Nom], [Statut], [Url]) VALUES (10, N'Thai.jpg', 1, N'/Images/Upload/Thai.jpg')
INSERT [dbo].[Photo] ([IdPhoto], [Nom], [Statut], [Url]) VALUES (11, N'kebab-2451112_1920.jpg', 1, N'/Images/Upload/kebab-2451112_1920.jpg')
INSERT [dbo].[Photo] ([IdPhoto], [Nom], [Statut], [Url]) VALUES (12, N'animals-215872_1280.jpg', 1, N'/Images/Upload/animals-215872_1280.jpg')
INSERT [dbo].[Photo] ([IdPhoto], [Nom], [Statut], [Url]) VALUES (13, N'brick-wall-1834784_1920.jpg', 1, N'/Images/Upload/brick-wall-1834784_1920.jpg')
INSERT [dbo].[Photo] ([IdPhoto], [Nom], [Statut], [Url]) VALUES (14, N'panini.jpg', 1, N'/Images/Upload/panini.jpg')
INSERT [dbo].[Photo] ([IdPhoto], [Nom], [Statut], [Url]) VALUES (15, N'religieuse.jpg', 1, N'/Images/Upload/religieuse.jpg')
INSERT [dbo].[Photo] ([IdPhoto], [Nom], [Statut], [Url]) VALUES (16, N'salade.jpg', 1, N'/Images/Upload/salade.jpg')
INSERT [dbo].[Photo] ([IdPhoto], [Nom], [Statut], [Url]) VALUES (17, N'carottes.jpg', 1, N'/Images/Upload/carottes.jpg')
INSERT [dbo].[Photo] ([IdPhoto], [Nom], [Statut], [Url]) VALUES (18, N'pad-thai-674089_1920.jpg', 1, N'/Images/Upload/pad-thai-674089_1920.jpg')
INSERT [dbo].[Photo] ([IdPhoto], [Nom], [Statut], [Url]) VALUES (19, N'ravioli-1949698_1920.jpg', 1, N'/Images/Upload/ravioli-1949698_1920.jpg')
INSERT [dbo].[Photo] ([IdPhoto], [Nom], [Statut], [Url]) VALUES (20, N'spaghetti-569067_1920.jpg', 1, N'/Images/Upload/spaghetti-569067_1920.jpg')
INSERT [dbo].[Photo] ([IdPhoto], [Nom], [Statut], [Url]) VALUES (21, N'noodles-1631863_1920.jpg', 1, N'/Images/Upload/noodles-1631863_1920.jpg')
SET IDENTITY_INSERT [dbo].[Photo] OFF
SET IDENTITY_INSERT [dbo].[Produit] ON 

INSERT [dbo].[Produit] ([IdProduit], [IdRestaurant], [IdCategorie], [Nom], [Prix], [Description], [Quantite], [Statut]) VALUES (1, 1, 8, N'Panini Viande Hachée', CAST(5.00 AS Decimal(10, 2)), N'Panini Viande hachée', 20, 1)
INSERT [dbo].[Produit] ([IdProduit], [IdRestaurant], [IdCategorie], [Nom], [Prix], [Description], [Quantite], [Statut]) VALUES (2, 1, 4, N'Religieuse Chocolat', CAST(2.00 AS Decimal(10, 2)), N'Religieuse Chocolat', 100, 1)
INSERT [dbo].[Produit] ([IdProduit], [IdRestaurant], [IdCategorie], [Nom], [Prix], [Description], [Quantite], [Statut]) VALUES (3, 2, 1, N'Carottes rapées', CAST(1.00 AS Decimal(10, 2)), N'Carottes rapées sauce vinaigrette', 25, 1)
INSERT [dbo].[Produit] ([IdProduit], [IdRestaurant], [IdCategorie], [Nom], [Prix], [Description], [Quantite], [Statut]) VALUES (4, 1, 6, N'Salade Niçoise', CAST(3.00 AS Decimal(10, 2)), N'Salade Niçoise', 15, 1)
INSERT [dbo].[Produit] ([IdProduit], [IdRestaurant], [IdCategorie], [Nom], [Prix], [Description], [Quantite], [Statut]) VALUES (5, 1, 3, N'PadThai', CAST(5.00 AS Decimal(10, 2)), N'padthai', 10, 1)
INSERT [dbo].[Produit] ([IdProduit], [IdRestaurant], [IdCategorie], [Nom], [Prix], [Description], [Quantite], [Statut]) VALUES (6, 2, 3, N'Ravioli', CAST(12.00 AS Decimal(10, 2)), N'ravioli', 10, 1)
INSERT [dbo].[Produit] ([IdProduit], [IdRestaurant], [IdCategorie], [Nom], [Prix], [Description], [Quantite], [Statut]) VALUES (7, 1, 3, N'pates', CAST(15.00 AS Decimal(10, 2)), N'pates', 7, 1)
SET IDENTITY_INSERT [dbo].[Produit] OFF
INSERT [dbo].[ProduitPhoto] ([IdProduit], [IdPhoto]) VALUES (1, 14)
INSERT [dbo].[ProduitPhoto] ([IdProduit], [IdPhoto]) VALUES (2, 15)
INSERT [dbo].[ProduitPhoto] ([IdProduit], [IdPhoto]) VALUES (3, 17)
INSERT [dbo].[ProduitPhoto] ([IdProduit], [IdPhoto]) VALUES (4, 16)
INSERT [dbo].[ProduitPhoto] ([IdProduit], [IdPhoto]) VALUES (5, 18)
INSERT [dbo].[ProduitPhoto] ([IdProduit], [IdPhoto]) VALUES (6, 19)
INSERT [dbo].[ProduitPhoto] ([IdProduit], [IdPhoto]) VALUES (7, 20)
INSERT [dbo].[ProduitPhoto] ([IdProduit], [IdPhoto]) VALUES (7, 21)
SET IDENTITY_INSERT [dbo].[Restaurant] ON 

INSERT [dbo].[Restaurant] ([IdRestaurant], [Nom], [Responsable], [IdTypeCuisine], [Adresse], [CodePostal], [Ville], [Mobile], [Telephone], [Login], [Password], [Tag], [Budget], [Email], [Description]) VALUES (1, N'Boulang', N'Moi', 17, N'10 rue de labas', N'75011', N'Paris 11', N'0612131415', N'0145632145', N'boul', N'boul', N'1', N'1         ', N'toi@boul.fr', N'Cognitis enim pilatorum caesorumque funeribus nemo deinde ad has stationes appulit navem, sed ut Scironis praerupta letalia declinantes litoribus Cypriis contigui navigabant, quae Isauriae scopulis sunt controversa.

Cum haec taliaque sollicitas eius aures everberarent expositas semper eius modi rumoribus et patentes, varia animo tum miscente consilia, tandem id ut optimum factu elegit: et Vrsicinum primum ad se venire summo cum honore mandavit ea specie ut pro rerum tunc urgentium captu disponeretur concordi consilio, quibus virium incrementis Parthicarum gentium a arma minantium impetus frangerentur.

Apud has gentes, quarum exordiens initium ab Assyriis ad Nili cataractas porrigitur et confinia Blemmyarum, omnes pari sorte sunt bellatores seminudi coloratis sagulis pube tenus amicti, equorum adiumento pernicium graciliumque camelorum per diversa se raptantes, in tranquillis vel turbidis rebus: nec eorum quisquam aliquando stivam adprehendit vel arborem colit aut arva subigendo quaeritat victum, sed errant semper per spatia longe lateque distenta sine lare sine sedibus fixis aut legibus: nec idem perferunt diutius caelum aut tractus unius soli illis umquam placet.')
INSERT [dbo].[Restaurant] ([IdRestaurant], [Nom], [Responsable], [IdTypeCuisine], [Adresse], [CodePostal], [Ville], [Mobile], [Telephone], [Login], [Password], [Tag], [Budget], [Email], [Description]) VALUES (2, N'Kalys', N'Durand', 17, N'10 rue d''en face', N'75011', N'Paris 11', N'0612365478', N'0145236587', N'kalys', N'123456', N'aucune', N'1         ', N'kalys@kalys.fr', N'Quid? qui se etiam nunc subsidiis patrimonii aut amicorum liberalitate sustentant, hos perire patiemur? An, si qui frui publico non potuit per hostem, hic tegitur ipsa lege censoria; quem is frui non sinit, qui est, etiamsi non appellatur, hostis, huic ferri auxilium non oportet? Retinete igitur in provincia diutius eum, qui de sociis cum hostibus, de civibus cum sociis faciat pactiones, qui hoc etiam se pluris esse quam collegam putet, quod ille vos tristia voltuque deceperit, ipse numquam se minus quam erat, nequam esse simularit. Piso autem alio quodam modo gloriatur se brevi tempore perfecisse, ne Gabinius unus omnium nequissimus existimaretur.')
INSERT [dbo].[Restaurant] ([IdRestaurant], [Nom], [Responsable], [IdTypeCuisine], [Adresse], [CodePostal], [Ville], [Mobile], [Telephone], [Login], [Password], [Tag], [Budget], [Email], [Description]) VALUES (3, N'Au Lion D''Or', N'ROGOGINE', 24, N'12 rue Montgallet', N'75012', N'Paris', N'0645457878', N'0145784512', N'ping', N'123456', N'123', N'1         ', N'rogogine.maxime@me.com', N'Hacque adfabilitate confisus cum eadem postridie feceris, ut incognitus haerebis et repentinus, hortatore illo hesterno clientes numerando, qui sis vel unde venias diutius ambigente agnitus vero tandem et adscitus in amicitiam si te salutandi adsiduitati dederis triennio indiscretus et per tot dierum defueris tempus, reverteris ad paria perferenda, nec ubi esses interrogatus et quo tandem miser discesseris, aetatem omnem frustra in stipite conteres summittendo.

Victus universis caro ferina est lactisque abundans copia qua sustentantur, et herbae multiplices et siquae alites capi per aucupium possint, et plerosque mos vidimus frumenti usum et vini penitus ignorantes.')
SET IDENTITY_INSERT [dbo].[Restaurant] OFF
INSERT [dbo].[RestaurantPhoto] ([IdRestaurant], [IdPhoto]) VALUES (1, 1)
INSERT [dbo].[RestaurantPhoto] ([IdRestaurant], [IdPhoto]) VALUES (2, 13)
INSERT [dbo].[RestaurantPhoto] ([IdRestaurant], [IdPhoto]) VALUES (3, 12)
INSERT [dbo].[SessionUtilisateur] ([IdSession], [dateSession]) VALUES (N'dhgpvhhmoc3rq1onhelgntwl', CAST(N'2020-03-05T16:44:22.077' AS DateTime))
SET IDENTITY_INSERT [dbo].[TypeCuisine] ON 

INSERT [dbo].[TypeCuisine] ([IdTypeCuisine], [Nom], [Statut]) VALUES (17, N'Coréen', 1)
INSERT [dbo].[TypeCuisine] ([IdTypeCuisine], [Nom], [Statut]) VALUES (18, N'Pizza', 1)
INSERT [dbo].[TypeCuisine] ([IdTypeCuisine], [Nom], [Statut]) VALUES (19, N'Libannais', 1)
INSERT [dbo].[TypeCuisine] ([IdTypeCuisine], [Nom], [Statut]) VALUES (20, N'Mexicain', 1)
INSERT [dbo].[TypeCuisine] ([IdTypeCuisine], [Nom], [Statut]) VALUES (21, N'Japonais', 1)
INSERT [dbo].[TypeCuisine] ([IdTypeCuisine], [Nom], [Statut]) VALUES (22, N'Indien', 1)
INSERT [dbo].[TypeCuisine] ([IdTypeCuisine], [Nom], [Statut]) VALUES (23, N'FastFood', 1)
INSERT [dbo].[TypeCuisine] ([IdTypeCuisine], [Nom], [Statut]) VALUES (24, N'Chinois', 1)
INSERT [dbo].[TypeCuisine] ([IdTypeCuisine], [Nom], [Statut]) VALUES (25, N'Thaï', 1)
INSERT [dbo].[TypeCuisine] ([IdTypeCuisine], [Nom], [Statut]) VALUES (26, N'Kebab', 1)
SET IDENTITY_INSERT [dbo].[TypeCuisine] OFF
INSERT [dbo].[TypeCuisinePhoto] ([IdTypeCuisine], [IdPhoto]) VALUES (17, 2)
INSERT [dbo].[TypeCuisinePhoto] ([IdTypeCuisine], [IdPhoto]) VALUES (18, 3)
INSERT [dbo].[TypeCuisinePhoto] ([IdTypeCuisine], [IdPhoto]) VALUES (19, 4)
INSERT [dbo].[TypeCuisinePhoto] ([IdTypeCuisine], [IdPhoto]) VALUES (20, 5)
INSERT [dbo].[TypeCuisinePhoto] ([IdTypeCuisine], [IdPhoto]) VALUES (21, 6)
INSERT [dbo].[TypeCuisinePhoto] ([IdTypeCuisine], [IdPhoto]) VALUES (22, 7)
INSERT [dbo].[TypeCuisinePhoto] ([IdTypeCuisine], [IdPhoto]) VALUES (23, 8)
INSERT [dbo].[TypeCuisinePhoto] ([IdTypeCuisine], [IdPhoto]) VALUES (24, 9)
INSERT [dbo].[TypeCuisinePhoto] ([IdTypeCuisine], [IdPhoto]) VALUES (25, 10)
INSERT [dbo].[TypeCuisinePhoto] ([IdTypeCuisine], [IdPhoto]) VALUES (26, 11)
SET IDENTITY_INSERT [dbo].[TypeVersement] ON 

INSERT [dbo].[TypeVersement] ([IdTypeVersement], [Nom], [Statut]) VALUES (1, N'Chéque', 1)
INSERT [dbo].[TypeVersement] ([IdTypeVersement], [Nom], [Statut]) VALUES (2, N'Espèce', 1)
INSERT [dbo].[TypeVersement] ([IdTypeVersement], [Nom], [Statut]) VALUES (3, N'Paypal', 1)
INSERT [dbo].[TypeVersement] ([IdTypeVersement], [Nom], [Statut]) VALUES (4, N'Virement', 1)
INSERT [dbo].[TypeVersement] ([IdTypeVersement], [Nom], [Statut]) VALUES (5, N'Ticket Resto', 1)
SET IDENTITY_INSERT [dbo].[TypeVersement] OFF
SET IDENTITY_INSERT [dbo].[Utilisateur] ON 

INSERT [dbo].[Utilisateur] ([IdUtilisateur], [Nom], [Prenom], [Matricule], [Password], [TypeCompte], [Statut], [IdSession], [Solde]) VALUES (1, N'Rogogine', N'Maxime', N'123456', N'azerty', 1, 1, N'qrhvwsbidd3qxl4haukiwtjq', CAST(487.00 AS Decimal(10, 2)))
INSERT [dbo].[Utilisateur] ([IdUtilisateur], [Nom], [Prenom], [Matricule], [Password], [TypeCompte], [Statut], [IdSession], [Solde]) VALUES (2, N'MonNom', N'MonPrenom', N'147852', N'123456', 1, 1, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Utilisateur] OFF
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Commande_EtatCommande]') AND parent_object_id = OBJECT_ID(N'[dbo].[Commande]'))
ALTER TABLE [dbo].[Commande]  WITH CHECK ADD  CONSTRAINT [FK_Commande_EtatCommande] FOREIGN KEY([IdEtatCommande])
REFERENCES [dbo].[EtatCommande] ([IdEtatCommande])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Commande_EtatCommande]') AND parent_object_id = OBJECT_ID(N'[dbo].[Commande]'))
ALTER TABLE [dbo].[Commande] CHECK CONSTRAINT [FK_Commande_EtatCommande]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Commande_Restaurant]') AND parent_object_id = OBJECT_ID(N'[dbo].[Commande]'))
ALTER TABLE [dbo].[Commande]  WITH CHECK ADD  CONSTRAINT [FK_Commande_Restaurant] FOREIGN KEY([IdRestaurant])
REFERENCES [dbo].[Restaurant] ([IdRestaurant])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Commande_Restaurant]') AND parent_object_id = OBJECT_ID(N'[dbo].[Commande]'))
ALTER TABLE [dbo].[Commande] CHECK CONSTRAINT [FK_Commande_Restaurant]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Commande_Utilisateur]') AND parent_object_id = OBJECT_ID(N'[dbo].[Commande]'))
ALTER TABLE [dbo].[Commande]  WITH CHECK ADD  CONSTRAINT [FK_Commande_Utilisateur] FOREIGN KEY([IdUtilisateur])
REFERENCES [dbo].[Utilisateur] ([IdUtilisateur])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Commande_Utilisateur]') AND parent_object_id = OBJECT_ID(N'[dbo].[Commande]'))
ALTER TABLE [dbo].[Commande] CHECK CONSTRAINT [FK_Commande_Utilisateur]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CommandeProduit_Commande]') AND parent_object_id = OBJECT_ID(N'[dbo].[CommandeProduit]'))
ALTER TABLE [dbo].[CommandeProduit]  WITH CHECK ADD  CONSTRAINT [FK_CommandeProduit_Commande] FOREIGN KEY([IdCommande])
REFERENCES [dbo].[Commande] ([IdCommande])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CommandeProduit_Commande]') AND parent_object_id = OBJECT_ID(N'[dbo].[CommandeProduit]'))
ALTER TABLE [dbo].[CommandeProduit] CHECK CONSTRAINT [FK_CommandeProduit_Commande]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CommandeProduit_Produit]') AND parent_object_id = OBJECT_ID(N'[dbo].[CommandeProduit]'))
ALTER TABLE [dbo].[CommandeProduit]  WITH CHECK ADD  CONSTRAINT [FK_CommandeProduit_Produit] FOREIGN KEY([IdProduit])
REFERENCES [dbo].[Produit] ([IdProduit])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CommandeProduit_Produit]') AND parent_object_id = OBJECT_ID(N'[dbo].[CommandeProduit]'))
ALTER TABLE [dbo].[CommandeProduit] CHECK CONSTRAINT [FK_CommandeProduit_Produit]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CommandeProduitMenu_CommandeProduit]') AND parent_object_id = OBJECT_ID(N'[dbo].[CommandeProduitMenu]'))
ALTER TABLE [dbo].[CommandeProduitMenu]  WITH CHECK ADD  CONSTRAINT [FK_CommandeProduitMenu_CommandeProduit] FOREIGN KEY([IdCommandeProduit])
REFERENCES [dbo].[CommandeProduit] ([IdCommandeProduit])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CommandeProduitMenu_CommandeProduit]') AND parent_object_id = OBJECT_ID(N'[dbo].[CommandeProduitMenu]'))
ALTER TABLE [dbo].[CommandeProduitMenu] CHECK CONSTRAINT [FK_CommandeProduitMenu_CommandeProduit]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CommandeProduitMenu_Menu]') AND parent_object_id = OBJECT_ID(N'[dbo].[CommandeProduitMenu]'))
ALTER TABLE [dbo].[CommandeProduitMenu]  WITH CHECK ADD  CONSTRAINT [FK_CommandeProduitMenu_Menu] FOREIGN KEY([IdMenu])
REFERENCES [dbo].[Menu] ([IdMenu])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CommandeProduitMenu_Menu]') AND parent_object_id = OBJECT_ID(N'[dbo].[CommandeProduitMenu]'))
ALTER TABLE [dbo].[CommandeProduitMenu] CHECK CONSTRAINT [FK_CommandeProduitMenu_Menu]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Menu_Restaurant]') AND parent_object_id = OBJECT_ID(N'[dbo].[Menu]'))
ALTER TABLE [dbo].[Menu]  WITH CHECK ADD  CONSTRAINT [FK_Menu_Restaurant] FOREIGN KEY([IdRestaurant])
REFERENCES [dbo].[Restaurant] ([IdRestaurant])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Menu_Restaurant]') AND parent_object_id = OBJECT_ID(N'[dbo].[Menu]'))
ALTER TABLE [dbo].[Menu] CHECK CONSTRAINT [FK_Menu_Restaurant]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MenuCategorie_Categorie]') AND parent_object_id = OBJECT_ID(N'[dbo].[MenuCategorie]'))
ALTER TABLE [dbo].[MenuCategorie]  WITH CHECK ADD  CONSTRAINT [FK_MenuCategorie_Categorie] FOREIGN KEY([IdCategorie])
REFERENCES [dbo].[Categorie] ([IdCategorie])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MenuCategorie_Categorie]') AND parent_object_id = OBJECT_ID(N'[dbo].[MenuCategorie]'))
ALTER TABLE [dbo].[MenuCategorie] CHECK CONSTRAINT [FK_MenuCategorie_Categorie]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MenuProduit_Menu]') AND parent_object_id = OBJECT_ID(N'[dbo].[MenuCategorie]'))
ALTER TABLE [dbo].[MenuCategorie]  WITH CHECK ADD  CONSTRAINT [FK_MenuProduit_Menu] FOREIGN KEY([IdMenu])
REFERENCES [dbo].[Menu] ([IdMenu])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MenuProduit_Menu]') AND parent_object_id = OBJECT_ID(N'[dbo].[MenuCategorie]'))
ALTER TABLE [dbo].[MenuCategorie] CHECK CONSTRAINT [FK_MenuProduit_Menu]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Operation_TypeVersement]') AND parent_object_id = OBJECT_ID(N'[dbo].[Operation]'))
ALTER TABLE [dbo].[Operation]  WITH CHECK ADD  CONSTRAINT [FK_Operation_TypeVersement] FOREIGN KEY([IdTypeVersement])
REFERENCES [dbo].[TypeVersement] ([IdTypeVersement])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Operation_TypeVersement]') AND parent_object_id = OBJECT_ID(N'[dbo].[Operation]'))
ALTER TABLE [dbo].[Operation] CHECK CONSTRAINT [FK_Operation_TypeVersement]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Operation_Utilisateur]') AND parent_object_id = OBJECT_ID(N'[dbo].[Operation]'))
ALTER TABLE [dbo].[Operation]  WITH CHECK ADD  CONSTRAINT [FK_Operation_Utilisateur] FOREIGN KEY([IdUtilisateur])
REFERENCES [dbo].[Utilisateur] ([IdUtilisateur])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Operation_Utilisateur]') AND parent_object_id = OBJECT_ID(N'[dbo].[Operation]'))
ALTER TABLE [dbo].[Operation] CHECK CONSTRAINT [FK_Operation_Utilisateur]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Produit_Categorie]') AND parent_object_id = OBJECT_ID(N'[dbo].[Produit]'))
ALTER TABLE [dbo].[Produit]  WITH CHECK ADD  CONSTRAINT [FK_Produit_Categorie] FOREIGN KEY([IdCategorie])
REFERENCES [dbo].[Categorie] ([IdCategorie])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Produit_Categorie]') AND parent_object_id = OBJECT_ID(N'[dbo].[Produit]'))
ALTER TABLE [dbo].[Produit] CHECK CONSTRAINT [FK_Produit_Categorie]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Produit_Restaurant]') AND parent_object_id = OBJECT_ID(N'[dbo].[Produit]'))
ALTER TABLE [dbo].[Produit]  WITH CHECK ADD  CONSTRAINT [FK_Produit_Restaurant] FOREIGN KEY([IdRestaurant])
REFERENCES [dbo].[Restaurant] ([IdRestaurant])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Produit_Restaurant]') AND parent_object_id = OBJECT_ID(N'[dbo].[Produit]'))
ALTER TABLE [dbo].[Produit] CHECK CONSTRAINT [FK_Produit_Restaurant]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProduitAllergene_Allergene]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProduitAllergene]'))
ALTER TABLE [dbo].[ProduitAllergene]  WITH CHECK ADD  CONSTRAINT [FK_ProduitAllergene_Allergene] FOREIGN KEY([IdAllergene])
REFERENCES [dbo].[Allergene] ([IdAllergene])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProduitAllergene_Allergene]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProduitAllergene]'))
ALTER TABLE [dbo].[ProduitAllergene] CHECK CONSTRAINT [FK_ProduitAllergene_Allergene]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProduitAllergene_Produit]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProduitAllergene]'))
ALTER TABLE [dbo].[ProduitAllergene]  WITH CHECK ADD  CONSTRAINT [FK_ProduitAllergene_Produit] FOREIGN KEY([IdProduit])
REFERENCES [dbo].[Produit] ([IdProduit])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProduitAllergene_Produit]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProduitAllergene]'))
ALTER TABLE [dbo].[ProduitAllergene] CHECK CONSTRAINT [FK_ProduitAllergene_Produit]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProduitCompose_Produit]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProduitCompose]'))
ALTER TABLE [dbo].[ProduitCompose]  WITH CHECK ADD  CONSTRAINT [FK_ProduitCompose_Produit] FOREIGN KEY([IdProduit])
REFERENCES [dbo].[Produit] ([IdProduit])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProduitCompose_Produit]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProduitCompose]'))
ALTER TABLE [dbo].[ProduitCompose] CHECK CONSTRAINT [FK_ProduitCompose_Produit]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProduitCompose_Produit1]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProduitCompose]'))
ALTER TABLE [dbo].[ProduitCompose]  WITH CHECK ADD  CONSTRAINT [FK_ProduitCompose_Produit1] FOREIGN KEY([IdProduitPere])
REFERENCES [dbo].[Produit] ([IdProduit])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProduitCompose_Produit1]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProduitCompose]'))
ALTER TABLE [dbo].[ProduitCompose] CHECK CONSTRAINT [FK_ProduitCompose_Produit1]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProduitMenu_CommandeProduit]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProduitMenu]'))
ALTER TABLE [dbo].[ProduitMenu]  WITH CHECK ADD  CONSTRAINT [FK_ProduitMenu_CommandeProduit] FOREIGN KEY([IdCommandeProduit])
REFERENCES [dbo].[CommandeProduit] ([IdCommandeProduit])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProduitMenu_CommandeProduit]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProduitMenu]'))
ALTER TABLE [dbo].[ProduitMenu] CHECK CONSTRAINT [FK_ProduitMenu_CommandeProduit]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProduitMenu_Menu]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProduitMenu]'))
ALTER TABLE [dbo].[ProduitMenu]  WITH CHECK ADD  CONSTRAINT [FK_ProduitMenu_Menu] FOREIGN KEY([IdMenu])
REFERENCES [dbo].[Menu] ([IdMenu])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProduitMenu_Menu]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProduitMenu]'))
ALTER TABLE [dbo].[ProduitMenu] CHECK CONSTRAINT [FK_ProduitMenu_Menu]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProduitPhoto_Photo]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProduitPhoto]'))
ALTER TABLE [dbo].[ProduitPhoto]  WITH CHECK ADD  CONSTRAINT [FK_ProduitPhoto_Photo] FOREIGN KEY([IdPhoto])
REFERENCES [dbo].[Photo] ([IdPhoto])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProduitPhoto_Photo]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProduitPhoto]'))
ALTER TABLE [dbo].[ProduitPhoto] CHECK CONSTRAINT [FK_ProduitPhoto_Photo]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProduitPhoto_Produit]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProduitPhoto]'))
ALTER TABLE [dbo].[ProduitPhoto]  WITH CHECK ADD  CONSTRAINT [FK_ProduitPhoto_Produit] FOREIGN KEY([IdProduit])
REFERENCES [dbo].[Produit] ([IdProduit])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProduitPhoto_Produit]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProduitPhoto]'))
ALTER TABLE [dbo].[ProduitPhoto] CHECK CONSTRAINT [FK_ProduitPhoto_Produit]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Restaurant_TypeCuisine]') AND parent_object_id = OBJECT_ID(N'[dbo].[Restaurant]'))
ALTER TABLE [dbo].[Restaurant]  WITH CHECK ADD  CONSTRAINT [FK_Restaurant_TypeCuisine] FOREIGN KEY([IdTypeCuisine])
REFERENCES [dbo].[TypeCuisine] ([IdTypeCuisine])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Restaurant_TypeCuisine]') AND parent_object_id = OBJECT_ID(N'[dbo].[Restaurant]'))
ALTER TABLE [dbo].[Restaurant] CHECK CONSTRAINT [FK_Restaurant_TypeCuisine]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_RestaurantPhoto_Photo]') AND parent_object_id = OBJECT_ID(N'[dbo].[RestaurantPhoto]'))
ALTER TABLE [dbo].[RestaurantPhoto]  WITH CHECK ADD  CONSTRAINT [FK_RestaurantPhoto_Photo] FOREIGN KEY([IdPhoto])
REFERENCES [dbo].[Photo] ([IdPhoto])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_RestaurantPhoto_Photo]') AND parent_object_id = OBJECT_ID(N'[dbo].[RestaurantPhoto]'))
ALTER TABLE [dbo].[RestaurantPhoto] CHECK CONSTRAINT [FK_RestaurantPhoto_Photo]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_RestaurantPhoto_Restaurant]') AND parent_object_id = OBJECT_ID(N'[dbo].[RestaurantPhoto]'))
ALTER TABLE [dbo].[RestaurantPhoto]  WITH CHECK ADD  CONSTRAINT [FK_RestaurantPhoto_Restaurant] FOREIGN KEY([IdRestaurant])
REFERENCES [dbo].[Restaurant] ([IdRestaurant])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_RestaurantPhoto_Restaurant]') AND parent_object_id = OBJECT_ID(N'[dbo].[RestaurantPhoto]'))
ALTER TABLE [dbo].[RestaurantPhoto] CHECK CONSTRAINT [FK_RestaurantPhoto_Restaurant]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TypeCuisinePhoto_Photo]') AND parent_object_id = OBJECT_ID(N'[dbo].[TypeCuisinePhoto]'))
ALTER TABLE [dbo].[TypeCuisinePhoto]  WITH CHECK ADD  CONSTRAINT [FK_TypeCuisinePhoto_Photo] FOREIGN KEY([IdPhoto])
REFERENCES [dbo].[Photo] ([IdPhoto])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TypeCuisinePhoto_Photo]') AND parent_object_id = OBJECT_ID(N'[dbo].[TypeCuisinePhoto]'))
ALTER TABLE [dbo].[TypeCuisinePhoto] CHECK CONSTRAINT [FK_TypeCuisinePhoto_Photo]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TypeCuisinePhoto_TypeCuisine]') AND parent_object_id = OBJECT_ID(N'[dbo].[TypeCuisinePhoto]'))
ALTER TABLE [dbo].[TypeCuisinePhoto]  WITH CHECK ADD  CONSTRAINT [FK_TypeCuisinePhoto_TypeCuisine] FOREIGN KEY([IdTypeCuisine])
REFERENCES [dbo].[TypeCuisine] ([IdTypeCuisine])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TypeCuisinePhoto_TypeCuisine]') AND parent_object_id = OBJECT_ID(N'[dbo].[TypeCuisinePhoto]'))
ALTER TABLE [dbo].[TypeCuisinePhoto] CHECK CONSTRAINT [FK_TypeCuisinePhoto_TypeCuisine]
GO
USE [master]
GO
ALTER DATABASE [AfpEat] SET  READ_WRITE 
GO

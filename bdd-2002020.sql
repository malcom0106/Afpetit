USE [master]
GO
/****** Object:  Database [AfpEat]    Script Date: 21/02/2020 11:52:27 ******/
CREATE DATABASE [AfpEat]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'AfpEat', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\AfpEat.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'AfpEat_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\AfpEat_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
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
/****** Object:  Table [dbo].[Allergene]    Script Date: 21/02/2020 11:52:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Allergene](
	[IdAllergene] [int] IDENTITY(1,1) NOT NULL,
	[Nom] [varchar](50) NOT NULL,
	[statut] [bit] NOT NULL,
 CONSTRAINT [PK_Allergene] PRIMARY KEY CLUSTERED 
(
	[IdAllergene] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categorie]    Script Date: 21/02/2020 11:52:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categorie](
	[IdCategorie] [int] IDENTITY(1,1) NOT NULL,
	[Nom] [varchar](50) NOT NULL,
	[Statut] [bit] NOT NULL,
 CONSTRAINT [PK_Categorie] PRIMARY KEY CLUSTERED 
(
	[IdCategorie] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Commande]    Script Date: 21/02/2020 11:52:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
GO
/****** Object:  Table [dbo].[CommandeProduit]    Script Date: 21/02/2020 11:52:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
GO
/****** Object:  Table [dbo].[EtatCommande]    Script Date: 21/02/2020 11:52:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EtatCommande](
	[IdEtatCommande] [int] IDENTITY(1,1) NOT NULL,
	[Nom] [varchar](50) NOT NULL,
	[Statut] [bit] NOT NULL,
 CONSTRAINT [PK_EtatCommande] PRIMARY KEY CLUSTERED 
(
	[IdEtatCommande] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Menu]    Script Date: 21/02/2020 11:52:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
GO
/****** Object:  Table [dbo].[MenuCategorie]    Script Date: 21/02/2020 11:52:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MenuCategorie](
	[IdMenu] [int] NOT NULL,
	[IdCategorie] [int] NOT NULL,
 CONSTRAINT [PK_MenuProduit] PRIMARY KEY CLUSTERED 
(
	[IdMenu] ASC,
	[IdCategorie] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Operation]    Script Date: 21/02/2020 11:52:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
GO
/****** Object:  Table [dbo].[Photo]    Script Date: 21/02/2020 11:52:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
GO
/****** Object:  Table [dbo].[Produit]    Script Date: 21/02/2020 11:52:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
GO
/****** Object:  Table [dbo].[ProduitAllergene]    Script Date: 21/02/2020 11:52:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProduitAllergene](
	[IdProduit] [int] NOT NULL,
	[IdAllergene] [int] NOT NULL,
 CONSTRAINT [PK_ProduitAllergene] PRIMARY KEY CLUSTERED 
(
	[IdProduit] ASC,
	[IdAllergene] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProduitMenu]    Script Date: 21/02/2020 11:52:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProduitMenu](
	[IdCommandeProduit] [int] NOT NULL,
	[IdMenu] [int] NOT NULL,
 CONSTRAINT [PK_ProduitMenu] PRIMARY KEY CLUSTERED 
(
	[IdCommandeProduit] ASC,
	[IdMenu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProduitPhoto]    Script Date: 21/02/2020 11:52:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProduitPhoto](
	[IdProduit] [int] NOT NULL,
	[IdPhoto] [int] NOT NULL,
 CONSTRAINT [PK_ProduitPhoto] PRIMARY KEY CLUSTERED 
(
	[IdProduit] ASC,
	[IdPhoto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Restaurant]    Script Date: 21/02/2020 11:52:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
GO
/****** Object:  Table [dbo].[RestaurantPhoto]    Script Date: 21/02/2020 11:52:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RestaurantPhoto](
	[IdRestaurant] [int] NOT NULL,
	[IdPhoto] [int] NOT NULL,
 CONSTRAINT [PK_RestaurantPhoto] PRIMARY KEY CLUSTERED 
(
	[IdRestaurant] ASC,
	[IdPhoto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TypeCuisine]    Script Date: 21/02/2020 11:52:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TypeCuisine](
	[IdTypeCuisine] [int] IDENTITY(1,1) NOT NULL,
	[Nom] [varchar](50) NOT NULL,
	[Statut] [bit] NOT NULL,
 CONSTRAINT [PK_TypeCuisine] PRIMARY KEY CLUSTERED 
(
	[IdTypeCuisine] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TypeCuisinePhoto]    Script Date: 21/02/2020 11:52:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TypeCuisinePhoto](
	[IdTypeCuisine] [int] NOT NULL,
	[IdPhoto] [int] NOT NULL,
 CONSTRAINT [PK_TypeCuisinePhoto] PRIMARY KEY CLUSTERED 
(
	[IdTypeCuisine] ASC,
	[IdPhoto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TypeVersement]    Script Date: 21/02/2020 11:52:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TypeVersement](
	[IdTypeVersement] [int] IDENTITY(1,1) NOT NULL,
	[Nom] [varchar](50) NOT NULL,
	[Statut] [bit] NOT NULL,
 CONSTRAINT [PK_TypeVersement] PRIMARY KEY CLUSTERED 
(
	[IdTypeVersement] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Utilisateur]    Script Date: 21/02/2020 11:52:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Utilisateur](
	[IdUtilisateur] [int] IDENTITY(1,1) NOT NULL,
	[Nom] [varchar](50) NOT NULL,
	[Prenom] [varchar](50) NOT NULL,
	[Matricule] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[TypeCompte] [bit] NOT NULL,
	[Statut] [bit] NOT NULL,
 CONSTRAINT [PK_Utilisateur] PRIMARY KEY CLUSTERED 
(
	[IdUtilisateur] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Allergene] ON 
GO
INSERT [dbo].[Allergene] ([IdAllergene], [Nom], [statut]) VALUES (1, N'Anhydride sulfureux et sulfites', 1)
GO
INSERT [dbo].[Allergene] ([IdAllergene], [Nom], [statut]) VALUES (2, N'Arachides', 1)
GO
INSERT [dbo].[Allergene] ([IdAllergene], [Nom], [statut]) VALUES (3, N'Céleri', 1)
GO
INSERT [dbo].[Allergene] ([IdAllergene], [Nom], [statut]) VALUES (4, N'Crustacés', 1)
GO
INSERT [dbo].[Allergene] ([IdAllergene], [Nom], [statut]) VALUES (5, N'Fruits à coques', 1)
GO
INSERT [dbo].[Allergene] ([IdAllergene], [Nom], [statut]) VALUES (6, N'Gluten', 1)
GO
INSERT [dbo].[Allergene] ([IdAllergene], [Nom], [statut]) VALUES (7, N'Graine de sésame', 1)
GO
INSERT [dbo].[Allergene] ([IdAllergene], [Nom], [statut]) VALUES (8, N'Lait', 1)
GO
INSERT [dbo].[Allergene] ([IdAllergene], [Nom], [statut]) VALUES (9, N'Lupin', 1)
GO
INSERT [dbo].[Allergene] ([IdAllergene], [Nom], [statut]) VALUES (10, N'Mollusques', 1)
GO
INSERT [dbo].[Allergene] ([IdAllergene], [Nom], [statut]) VALUES (11, N'Moutarde', 1)
GO
INSERT [dbo].[Allergene] ([IdAllergene], [Nom], [statut]) VALUES (12, N'Oeufs', 1)
GO
INSERT [dbo].[Allergene] ([IdAllergene], [Nom], [statut]) VALUES (13, N'Poissons', 1)
GO
INSERT [dbo].[Allergene] ([IdAllergene], [Nom], [statut]) VALUES (14, N'Soja', 1)
GO
SET IDENTITY_INSERT [dbo].[Allergene] OFF
GO
SET IDENTITY_INSERT [dbo].[Categorie] ON 
GO
INSERT [dbo].[Categorie] ([IdCategorie], [Nom], [Statut]) VALUES (1, N'Entrée Froide', 1)
GO
INSERT [dbo].[Categorie] ([IdCategorie], [Nom], [Statut]) VALUES (2, N'Entrée Chaude', 1)
GO
INSERT [dbo].[Categorie] ([IdCategorie], [Nom], [Statut]) VALUES (3, N'Plat', 1)
GO
INSERT [dbo].[Categorie] ([IdCategorie], [Nom], [Statut]) VALUES (4, N'Dessert', 1)
GO
INSERT [dbo].[Categorie] ([IdCategorie], [Nom], [Statut]) VALUES (5, N'Boisson', 1)
GO
INSERT [dbo].[Categorie] ([IdCategorie], [Nom], [Statut]) VALUES (6, N'Salade', 1)
GO
INSERT [dbo].[Categorie] ([IdCategorie], [Nom], [Statut]) VALUES (7, N'Pâtes', 1)
GO
INSERT [dbo].[Categorie] ([IdCategorie], [Nom], [Statut]) VALUES (8, N'Panini', 1)
GO
SET IDENTITY_INSERT [dbo].[Categorie] OFF
GO
SET IDENTITY_INSERT [dbo].[EtatCommande] ON 
GO
INSERT [dbo].[EtatCommande] ([IdEtatCommande], [Nom], [Statut]) VALUES (1, N'En Attente', 1)
GO
INSERT [dbo].[EtatCommande] ([IdEtatCommande], [Nom], [Statut]) VALUES (2, N'En Cours', 1)
GO
INSERT [dbo].[EtatCommande] ([IdEtatCommande], [Nom], [Statut]) VALUES (3, N'Livré', 1)
GO
SET IDENTITY_INSERT [dbo].[EtatCommande] OFF
GO
SET IDENTITY_INSERT [dbo].[Photo] ON 
GO
INSERT [dbo].[Photo] ([IdPhoto], [Nom], [Statut], [Url]) VALUES (1, N'MonResto', 1, N'/Images/Upload/restaurant1.jpg')
GO
INSERT [dbo].[Photo] ([IdPhoto], [Nom], [Statut], [Url]) VALUES (2, N'korean-cabbage-in-chili-sauce-1120406_1920.jpg', 1, N'\Images\Upload\korean-cabbage-in-chili-sauce-1120406_1920.jpg')
GO
INSERT [dbo].[Photo] ([IdPhoto], [Nom], [Statut], [Url]) VALUES (3, N'Pizza.jpg', 1, N'\Images\Upload\Pizza.jpg')
GO
INSERT [dbo].[Photo] ([IdPhoto], [Nom], [Statut], [Url]) VALUES (4, N'Libannais.jpg', 1, N'\Images\Upload\Libannais.jpg')
GO
INSERT [dbo].[Photo] ([IdPhoto], [Nom], [Statut], [Url]) VALUES (5, N'Mexicain.jpg', 1, N'\Images\Upload\Mexicain.jpg')
GO
INSERT [dbo].[Photo] ([IdPhoto], [Nom], [Statut], [Url]) VALUES (6, N'Japonnais.jpg', 1, N'\Images\Upload\Japonnais.jpg')
GO
INSERT [dbo].[Photo] ([IdPhoto], [Nom], [Statut], [Url]) VALUES (7, N'Indien.jpg', 1, N'\Images\Upload\Indien.jpg')
GO
INSERT [dbo].[Photo] ([IdPhoto], [Nom], [Statut], [Url]) VALUES (8, N'Burger.jpg', 1, N'\Images\Upload\Burger.jpg')
GO
INSERT [dbo].[Photo] ([IdPhoto], [Nom], [Statut], [Url]) VALUES (9, N'Chinois.jpg', 1, N'\Images\Upload\Chinois.jpg')
GO
INSERT [dbo].[Photo] ([IdPhoto], [Nom], [Statut], [Url]) VALUES (10, N'Thai.jpg', 1, N'\Images\Upload\Thai.jpg')
GO
INSERT [dbo].[Photo] ([IdPhoto], [Nom], [Statut], [Url]) VALUES (11, N'kebab-2451112_1920.jpg', 1, N'\Images\Upload\kebab-2451112_1920.jpg')
GO
INSERT [dbo].[Photo] ([IdPhoto], [Nom], [Statut], [Url]) VALUES (12, N'animals-215872_1280.jpg', 1, N'/Images/Upload/animals-215872_1280.jpg')
GO
INSERT [dbo].[Photo] ([IdPhoto], [Nom], [Statut], [Url]) VALUES (13, N'brick-wall-1834784_1920.jpg', 1, N'/Images/Upload/brick-wall-1834784_1920.jpg')
GO
INSERT [dbo].[Photo] ([IdPhoto], [Nom], [Statut], [Url]) VALUES (14, N'panini.jpg', 1, N'/Images/Upload/panini.jpg')
GO
INSERT [dbo].[Photo] ([IdPhoto], [Nom], [Statut], [Url]) VALUES (15, N'religieuse.jpg', 1, N'/Images/Upload/religieuse.jpg')
GO
INSERT [dbo].[Photo] ([IdPhoto], [Nom], [Statut], [Url]) VALUES (16, N'salade.jpg', 1, N'/Images/Upload/salade.jpg')
GO
INSERT [dbo].[Photo] ([IdPhoto], [Nom], [Statut], [Url]) VALUES (17, N'carottes.jpg', 1, N'/Images/Upload/carottes.jpg')
GO
INSERT [dbo].[Photo] ([IdPhoto], [Nom], [Statut], [Url]) VALUES (18, N'pad-thai-674089_1920.jpg', 1, N'/Images/Upload/pad-thai-674089_1920.jpg')
GO
INSERT [dbo].[Photo] ([IdPhoto], [Nom], [Statut], [Url]) VALUES (19, N'ravioli-1949698_1920.jpg', 1, N'/Images/Upload/ravioli-1949698_1920.jpg')
GO
SET IDENTITY_INSERT [dbo].[Photo] OFF
GO
SET IDENTITY_INSERT [dbo].[Produit] ON 
GO
INSERT [dbo].[Produit] ([IdProduit], [IdRestaurant], [IdCategorie], [Nom], [Prix], [Description], [Quantite], [Statut]) VALUES (1, 1, 8, N'Panini Viande Hachée', CAST(5.00 AS Decimal(10, 2)), N'Panini Viande hachée', 20, 1)
GO
INSERT [dbo].[Produit] ([IdProduit], [IdRestaurant], [IdCategorie], [Nom], [Prix], [Description], [Quantite], [Statut]) VALUES (2, 1, 4, N'Religieuse Chocolat', CAST(2.00 AS Decimal(10, 2)), N'Religieuse Chocolat', 100, 1)
GO
INSERT [dbo].[Produit] ([IdProduit], [IdRestaurant], [IdCategorie], [Nom], [Prix], [Description], [Quantite], [Statut]) VALUES (3, 2, 1, N'Carottes rapées', CAST(1.00 AS Decimal(10, 2)), N'Carottes rapées sauce vinaigrette', 25, 1)
GO
INSERT [dbo].[Produit] ([IdProduit], [IdRestaurant], [IdCategorie], [Nom], [Prix], [Description], [Quantite], [Statut]) VALUES (4, 1, 6, N'Salade Niçoise', CAST(3.00 AS Decimal(10, 2)), N'Salade Niçoise', 15, 1)
GO
INSERT [dbo].[Produit] ([IdProduit], [IdRestaurant], [IdCategorie], [Nom], [Prix], [Description], [Quantite], [Statut]) VALUES (5, 1, 3, N'PadThai', CAST(5.00 AS Decimal(10, 2)), N'padthai', 10, 1)
GO
INSERT [dbo].[Produit] ([IdProduit], [IdRestaurant], [IdCategorie], [Nom], [Prix], [Description], [Quantite], [Statut]) VALUES (6, 2, 3, N'Ravioli', CAST(12.00 AS Decimal(10, 2)), N'ravioli', 10, 1)
GO
SET IDENTITY_INSERT [dbo].[Produit] OFF
GO
INSERT [dbo].[ProduitPhoto] ([IdProduit], [IdPhoto]) VALUES (1, 14)
GO
INSERT [dbo].[ProduitPhoto] ([IdProduit], [IdPhoto]) VALUES (2, 15)
GO
INSERT [dbo].[ProduitPhoto] ([IdProduit], [IdPhoto]) VALUES (3, 17)
GO
INSERT [dbo].[ProduitPhoto] ([IdProduit], [IdPhoto]) VALUES (4, 16)
GO
INSERT [dbo].[ProduitPhoto] ([IdProduit], [IdPhoto]) VALUES (5, 18)
GO
INSERT [dbo].[ProduitPhoto] ([IdProduit], [IdPhoto]) VALUES (6, 19)
GO
SET IDENTITY_INSERT [dbo].[Restaurant] ON 
GO
INSERT [dbo].[Restaurant] ([IdRestaurant], [Nom], [Responsable], [IdTypeCuisine], [Adresse], [CodePostal], [Ville], [Mobile], [Telephone], [Login], [Password], [Tag], [Budget], [Email], [Description]) VALUES (1, N'Boulang', N'Moi', 17, N'10 rue de labas', N'75011', N'Paris 11', N'0612131415', N'0145632145', N'boul', N'boul', N'1', N'1         ', N'toi@boul.fr', N'sqdsd')
GO
INSERT [dbo].[Restaurant] ([IdRestaurant], [Nom], [Responsable], [IdTypeCuisine], [Adresse], [CodePostal], [Ville], [Mobile], [Telephone], [Login], [Password], [Tag], [Budget], [Email], [Description]) VALUES (2, N'Kalys', N'Durand', 17, N'10 rue d''en face', N'75011', N'Paris 11', N'0612365478', N'0145236587', N'kalys', N'123456', N'aucune', N'1         ', N'kalys@kalys.fr', N'qsdqsdsqdq')
GO
INSERT [dbo].[Restaurant] ([IdRestaurant], [Nom], [Responsable], [IdTypeCuisine], [Adresse], [CodePostal], [Ville], [Mobile], [Telephone], [Login], [Password], [Tag], [Budget], [Email], [Description]) VALUES (3, N'Au Lion D''Or', N'ROGOGINE', 24, N'12 rue Montgallet', N'75012', N'Paris', N'0645457878', N'0145784512', N'ping', N'123456', N'123', N'1         ', N'rogogine.maxime@me.com', N'Buffet à volonté')
GO
SET IDENTITY_INSERT [dbo].[Restaurant] OFF
GO
INSERT [dbo].[RestaurantPhoto] ([IdRestaurant], [IdPhoto]) VALUES (1, 1)
GO
INSERT [dbo].[RestaurantPhoto] ([IdRestaurant], [IdPhoto]) VALUES (2, 13)
GO
INSERT [dbo].[RestaurantPhoto] ([IdRestaurant], [IdPhoto]) VALUES (3, 12)
GO
SET IDENTITY_INSERT [dbo].[TypeCuisine] ON 
GO
INSERT [dbo].[TypeCuisine] ([IdTypeCuisine], [Nom], [Statut]) VALUES (17, N'Coréen', 1)
GO
INSERT [dbo].[TypeCuisine] ([IdTypeCuisine], [Nom], [Statut]) VALUES (18, N'Pizza', 1)
GO
INSERT [dbo].[TypeCuisine] ([IdTypeCuisine], [Nom], [Statut]) VALUES (19, N'Libannais', 1)
GO
INSERT [dbo].[TypeCuisine] ([IdTypeCuisine], [Nom], [Statut]) VALUES (20, N'Mexicain', 1)
GO
INSERT [dbo].[TypeCuisine] ([IdTypeCuisine], [Nom], [Statut]) VALUES (21, N'Japonais', 1)
GO
INSERT [dbo].[TypeCuisine] ([IdTypeCuisine], [Nom], [Statut]) VALUES (22, N'Indien', 1)
GO
INSERT [dbo].[TypeCuisine] ([IdTypeCuisine], [Nom], [Statut]) VALUES (23, N'FastFood', 1)
GO
INSERT [dbo].[TypeCuisine] ([IdTypeCuisine], [Nom], [Statut]) VALUES (24, N'Chinois', 1)
GO
INSERT [dbo].[TypeCuisine] ([IdTypeCuisine], [Nom], [Statut]) VALUES (25, N'Thaï', 1)
GO
INSERT [dbo].[TypeCuisine] ([IdTypeCuisine], [Nom], [Statut]) VALUES (26, N'Kebab', 1)
GO
SET IDENTITY_INSERT [dbo].[TypeCuisine] OFF
GO
INSERT [dbo].[TypeCuisinePhoto] ([IdTypeCuisine], [IdPhoto]) VALUES (17, 2)
GO
INSERT [dbo].[TypeCuisinePhoto] ([IdTypeCuisine], [IdPhoto]) VALUES (18, 3)
GO
INSERT [dbo].[TypeCuisinePhoto] ([IdTypeCuisine], [IdPhoto]) VALUES (19, 4)
GO
INSERT [dbo].[TypeCuisinePhoto] ([IdTypeCuisine], [IdPhoto]) VALUES (20, 5)
GO
INSERT [dbo].[TypeCuisinePhoto] ([IdTypeCuisine], [IdPhoto]) VALUES (21, 6)
GO
INSERT [dbo].[TypeCuisinePhoto] ([IdTypeCuisine], [IdPhoto]) VALUES (22, 7)
GO
INSERT [dbo].[TypeCuisinePhoto] ([IdTypeCuisine], [IdPhoto]) VALUES (23, 8)
GO
INSERT [dbo].[TypeCuisinePhoto] ([IdTypeCuisine], [IdPhoto]) VALUES (24, 9)
GO
INSERT [dbo].[TypeCuisinePhoto] ([IdTypeCuisine], [IdPhoto]) VALUES (25, 10)
GO
INSERT [dbo].[TypeCuisinePhoto] ([IdTypeCuisine], [IdPhoto]) VALUES (26, 11)
GO
SET IDENTITY_INSERT [dbo].[TypeVersement] ON 
GO
INSERT [dbo].[TypeVersement] ([IdTypeVersement], [Nom], [Statut]) VALUES (1, N'Chéque', 1)
GO
INSERT [dbo].[TypeVersement] ([IdTypeVersement], [Nom], [Statut]) VALUES (2, N'Espèce', 1)
GO
INSERT [dbo].[TypeVersement] ([IdTypeVersement], [Nom], [Statut]) VALUES (3, N'Paypal', 1)
GO
INSERT [dbo].[TypeVersement] ([IdTypeVersement], [Nom], [Statut]) VALUES (4, N'Virement', 1)
GO
INSERT [dbo].[TypeVersement] ([IdTypeVersement], [Nom], [Statut]) VALUES (5, N'Ticket Resto', 1)
GO
SET IDENTITY_INSERT [dbo].[TypeVersement] OFF
GO
SET IDENTITY_INSERT [dbo].[Utilisateur] ON 
GO
INSERT [dbo].[Utilisateur] ([IdUtilisateur], [Nom], [Prenom], [Matricule], [Password], [TypeCompte], [Statut]) VALUES (1, N'Rogogine', N'Maxime', N'123456', N'azerty', 1, 1)
GO
INSERT [dbo].[Utilisateur] ([IdUtilisateur], [Nom], [Prenom], [Matricule], [Password], [TypeCompte], [Statut]) VALUES (2, N'MonNom', N'MonPrenom', N'147852', N'123456', 1, 1)
GO
SET IDENTITY_INSERT [dbo].[Utilisateur] OFF
GO
ALTER TABLE [dbo].[Commande]  WITH CHECK ADD  CONSTRAINT [FK_Commande_EtatCommande] FOREIGN KEY([IdEtatCommande])
REFERENCES [dbo].[EtatCommande] ([IdEtatCommande])
GO
ALTER TABLE [dbo].[Commande] CHECK CONSTRAINT [FK_Commande_EtatCommande]
GO
ALTER TABLE [dbo].[Commande]  WITH CHECK ADD  CONSTRAINT [FK_Commande_Restaurant] FOREIGN KEY([IdRestaurant])
REFERENCES [dbo].[Restaurant] ([IdRestaurant])
GO
ALTER TABLE [dbo].[Commande] CHECK CONSTRAINT [FK_Commande_Restaurant]
GO
ALTER TABLE [dbo].[Commande]  WITH CHECK ADD  CONSTRAINT [FK_Commande_Utilisateur] FOREIGN KEY([IdUtilisateur])
REFERENCES [dbo].[Utilisateur] ([IdUtilisateur])
GO
ALTER TABLE [dbo].[Commande] CHECK CONSTRAINT [FK_Commande_Utilisateur]
GO
ALTER TABLE [dbo].[CommandeProduit]  WITH CHECK ADD  CONSTRAINT [FK_CommandeProduit_Commande] FOREIGN KEY([IdCommande])
REFERENCES [dbo].[Commande] ([IdCommande])
GO
ALTER TABLE [dbo].[CommandeProduit] CHECK CONSTRAINT [FK_CommandeProduit_Commande]
GO
ALTER TABLE [dbo].[CommandeProduit]  WITH CHECK ADD  CONSTRAINT [FK_CommandeProduit_Produit] FOREIGN KEY([IdProduit])
REFERENCES [dbo].[Produit] ([IdProduit])
GO
ALTER TABLE [dbo].[CommandeProduit] CHECK CONSTRAINT [FK_CommandeProduit_Produit]
GO
ALTER TABLE [dbo].[Menu]  WITH CHECK ADD  CONSTRAINT [FK_Menu_Restaurant] FOREIGN KEY([IdRestaurant])
REFERENCES [dbo].[Restaurant] ([IdRestaurant])
GO
ALTER TABLE [dbo].[Menu] CHECK CONSTRAINT [FK_Menu_Restaurant]
GO
ALTER TABLE [dbo].[MenuCategorie]  WITH CHECK ADD  CONSTRAINT [FK_MenuCategorie_Categorie] FOREIGN KEY([IdCategorie])
REFERENCES [dbo].[Categorie] ([IdCategorie])
GO
ALTER TABLE [dbo].[MenuCategorie] CHECK CONSTRAINT [FK_MenuCategorie_Categorie]
GO
ALTER TABLE [dbo].[MenuCategorie]  WITH CHECK ADD  CONSTRAINT [FK_MenuProduit_Menu] FOREIGN KEY([IdMenu])
REFERENCES [dbo].[Menu] ([IdMenu])
GO
ALTER TABLE [dbo].[MenuCategorie] CHECK CONSTRAINT [FK_MenuProduit_Menu]
GO
ALTER TABLE [dbo].[Operation]  WITH CHECK ADD  CONSTRAINT [FK_Operation_TypeVersement] FOREIGN KEY([IdTypeVersement])
REFERENCES [dbo].[TypeVersement] ([IdTypeVersement])
GO
ALTER TABLE [dbo].[Operation] CHECK CONSTRAINT [FK_Operation_TypeVersement]
GO
ALTER TABLE [dbo].[Operation]  WITH CHECK ADD  CONSTRAINT [FK_Operation_Utilisateur] FOREIGN KEY([IdUtilisateur])
REFERENCES [dbo].[Utilisateur] ([IdUtilisateur])
GO
ALTER TABLE [dbo].[Operation] CHECK CONSTRAINT [FK_Operation_Utilisateur]
GO
ALTER TABLE [dbo].[Produit]  WITH CHECK ADD  CONSTRAINT [FK_Produit_Categorie] FOREIGN KEY([IdCategorie])
REFERENCES [dbo].[Categorie] ([IdCategorie])
GO
ALTER TABLE [dbo].[Produit] CHECK CONSTRAINT [FK_Produit_Categorie]
GO
ALTER TABLE [dbo].[Produit]  WITH CHECK ADD  CONSTRAINT [FK_Produit_Restaurant] FOREIGN KEY([IdRestaurant])
REFERENCES [dbo].[Restaurant] ([IdRestaurant])
GO
ALTER TABLE [dbo].[Produit] CHECK CONSTRAINT [FK_Produit_Restaurant]
GO
ALTER TABLE [dbo].[ProduitAllergene]  WITH CHECK ADD  CONSTRAINT [FK_ProduitAllergene_Allergene] FOREIGN KEY([IdAllergene])
REFERENCES [dbo].[Allergene] ([IdAllergene])
GO
ALTER TABLE [dbo].[ProduitAllergene] CHECK CONSTRAINT [FK_ProduitAllergene_Allergene]
GO
ALTER TABLE [dbo].[ProduitAllergene]  WITH CHECK ADD  CONSTRAINT [FK_ProduitAllergene_Produit] FOREIGN KEY([IdProduit])
REFERENCES [dbo].[Produit] ([IdProduit])
GO
ALTER TABLE [dbo].[ProduitAllergene] CHECK CONSTRAINT [FK_ProduitAllergene_Produit]
GO
ALTER TABLE [dbo].[ProduitMenu]  WITH CHECK ADD  CONSTRAINT [FK_ProduitMenu_CommandeProduit] FOREIGN KEY([IdCommandeProduit])
REFERENCES [dbo].[CommandeProduit] ([IdCommandeProduit])
GO
ALTER TABLE [dbo].[ProduitMenu] CHECK CONSTRAINT [FK_ProduitMenu_CommandeProduit]
GO
ALTER TABLE [dbo].[ProduitMenu]  WITH CHECK ADD  CONSTRAINT [FK_ProduitMenu_Menu] FOREIGN KEY([IdMenu])
REFERENCES [dbo].[Menu] ([IdMenu])
GO
ALTER TABLE [dbo].[ProduitMenu] CHECK CONSTRAINT [FK_ProduitMenu_Menu]
GO
ALTER TABLE [dbo].[ProduitPhoto]  WITH CHECK ADD  CONSTRAINT [FK_ProduitPhoto_Photo] FOREIGN KEY([IdPhoto])
REFERENCES [dbo].[Photo] ([IdPhoto])
GO
ALTER TABLE [dbo].[ProduitPhoto] CHECK CONSTRAINT [FK_ProduitPhoto_Photo]
GO
ALTER TABLE [dbo].[ProduitPhoto]  WITH CHECK ADD  CONSTRAINT [FK_ProduitPhoto_Produit] FOREIGN KEY([IdProduit])
REFERENCES [dbo].[Produit] ([IdProduit])
GO
ALTER TABLE [dbo].[ProduitPhoto] CHECK CONSTRAINT [FK_ProduitPhoto_Produit]
GO
ALTER TABLE [dbo].[Restaurant]  WITH CHECK ADD  CONSTRAINT [FK_Restaurant_TypeCuisine] FOREIGN KEY([IdTypeCuisine])
REFERENCES [dbo].[TypeCuisine] ([IdTypeCuisine])
GO
ALTER TABLE [dbo].[Restaurant] CHECK CONSTRAINT [FK_Restaurant_TypeCuisine]
GO
ALTER TABLE [dbo].[RestaurantPhoto]  WITH CHECK ADD  CONSTRAINT [FK_RestaurantPhoto_Photo] FOREIGN KEY([IdPhoto])
REFERENCES [dbo].[Photo] ([IdPhoto])
GO
ALTER TABLE [dbo].[RestaurantPhoto] CHECK CONSTRAINT [FK_RestaurantPhoto_Photo]
GO
ALTER TABLE [dbo].[RestaurantPhoto]  WITH CHECK ADD  CONSTRAINT [FK_RestaurantPhoto_Restaurant] FOREIGN KEY([IdRestaurant])
REFERENCES [dbo].[Restaurant] ([IdRestaurant])
GO
ALTER TABLE [dbo].[RestaurantPhoto] CHECK CONSTRAINT [FK_RestaurantPhoto_Restaurant]
GO
ALTER TABLE [dbo].[TypeCuisinePhoto]  WITH CHECK ADD  CONSTRAINT [FK_TypeCuisinePhoto_Photo] FOREIGN KEY([IdPhoto])
REFERENCES [dbo].[Photo] ([IdPhoto])
GO
ALTER TABLE [dbo].[TypeCuisinePhoto] CHECK CONSTRAINT [FK_TypeCuisinePhoto_Photo]
GO
ALTER TABLE [dbo].[TypeCuisinePhoto]  WITH CHECK ADD  CONSTRAINT [FK_TypeCuisinePhoto_TypeCuisine] FOREIGN KEY([IdTypeCuisine])
REFERENCES [dbo].[TypeCuisine] ([IdTypeCuisine])
GO
ALTER TABLE [dbo].[TypeCuisinePhoto] CHECK CONSTRAINT [FK_TypeCuisinePhoto_TypeCuisine]
GO
USE [master]
GO
ALTER DATABASE [AfpEat] SET  READ_WRITE 
GO

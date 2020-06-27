-- Projekt bazy danych Banku Krwi.
-- Zakłada możliwość dodawania nowych dawców, magazynowania ich danych i donacji.
-- Przechowuje i modyfikuje informacje o stanie magazynowym poszczególnych grup krwi.


IF EXISTS (SELECT name FROM master.sys.databases WHERE name = N'BankKrwi')
BEGIN
	PRINT 'Baza danych Bank krwi ju¿ istnieje.'
END
ELSE
BEGIN
	CREATE DATABASE BankKrwi
	PRINT 'Stworzono bazê danych Bank krwi.'
END
GO

USE BankKrwi
GO


IF EXISTS (SELECT * FROM sys.tables where name = N'Dawca')
BEGIN
	PRINT 'Tabela Dawca ju¿ istnieje.'
END
ELSE
BEGIN
	CREATE TABLE Dawca(
			[DawcaID] [int] IDENTITY(1,1) NOT NULL,
			[idAdres] [int] NOT NULL,
			[idGrupaKrwi] [int] NOT NULL,
			[NumerPesel] [nvarchar](30) NOT NULL UNIQUE,
			[Imie] [nvarchar](30) NOT NULL,
			[DrugieImie] [nvarchar](30),
			[Nazwisko] [nvarchar](30) NOT NULL,
			[NumerTelefonu] [nvarchar](20) NOT NULL,
		CONSTRAINT [PK_Dawca] PRIMARY KEY CLUSTERED 
		(
			[DawcaID] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
		) ON [PRIMARY]

	PRINT 'Tabela Dawca zosta³a utworzona.'
END
GO


IF OBJECT_ID('Donacje')  IS NULL 
BEGIN
	CREATE TABLE Donacje(
		[idDawca] [int] NOT NULL,
		[Ilosc] [numeric](3,2) NOT NULL,
		[DataDonacji] [smalldatetime])
	PRINT 'Tabela Donacje zosta³a utworzona.'
END
ELSE
BEGIN
	PRINT 'Tabela Donacje ju¿ istnieje.'
END
GO


IF OBJECT_ID('StanDawcy')  IS NULL 
BEGIN
	CREATE TABLE StanDawcy(
		[idDawcaStan] [int] NOT NULL,
		[idChoroba] [int] NOT NULL)
	PRINT 'Tabela StanDawcy zosta³a utworzona.'
END
ELSE
BEGIN
	PRINT 'Tabela StanDawcy ju¿ istnieje.'
END
GO


IF OBJECT_ID('Choroby')  IS NULL 
BEGIN
	CREATE TABLE Choroby(
		[ChorobaID] [int] IDENTITY(1,1) NOT NULL,
		[NazwaChoroby] [nvarchar](50) NOT NULL,
		[Wykluczenie] [nvarchar](20),
	CONSTRAINT [PK_Choroby] PRIMARY KEY CLUSTERED 
	(
		[ChorobaID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]

	PRINT 'Tabela Choroby zosta³a utworzona.'
END
ELSE
BEGIN
	PRINT 'Tabela Choroby ju¿ istnieje.'
END
GO


IF OBJECT_ID('LekiDawcy')  IS NULL 
BEGIN
	CREATE TABLE LekiDawcy(
		[idDawcaLek] [int] NOT NULL,
		[idLek] [int] NOT NULL)
	PRINT 'Tabela LekiDawcy zosta³a utworzona.'
END
ELSE
BEGIN
	PRINT 'Tabela LekiDawcy ju¿ istnieje.'
END
GO


IF OBJECT_ID('Leki')  IS NULL 
BEGIN
	CREATE TABLE Leki(
		[LekID] [int] IDENTITY(1,1) NOT NULL,
		[NazwaLeku] [nvarchar](30),
		[Wykluczenie] [nvarchar](20),
	CONSTRAINT [PK_Leki] PRIMARY KEY CLUSTERED 
	(
		[LekID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]

	PRINT 'Tabela Leki zosta³a utworzona.'
END
ELSE
BEGIN
	PRINT 'Tabela Leki ju¿ istnieje.'
END
GO


IF OBJECT_ID('GrupaKrwi')  IS NULL 
BEGIN
	CREATE TABLE GrupaKrwi(
		[GrupaKrwiID] [int] IDENTITY(1,1) NOT NULL,
		[AB0] [nvarchar](5),
		[Rh] [nvarchar](5),
	CONSTRAINT [PK_GrupaKrwi] PRIMARY KEY CLUSTERED 
	(
		[GrupaKrwiID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]

	PRINT 'Tabela GrupaKrwi zosta³a utworzona.'
END
ELSE
BEGIN
	PRINT 'Tabela GrupaKrwi ju¿ istnieje.'
END
GO


IF OBJECT_ID('StanMagazynowy')  IS NULL 
BEGIN
	CREATE TABLE StanMagazynowy(
		[idGrupaKrwi] [int] NOT NULL,
		[IloscLitry] [numeric](5,2) NOT NULL)
	PRINT 'Tabela StanMagazynowy zosta³a utworzona.'
END
ELSE
BEGIN
	PRINT 'Tabela StanMagazynowy ju¿ istnieje.'
END
GO


IF OBJECT_ID('Adres')  IS NULL 
BEGIN
	CREATE TABLE Adres(
		[AdresID] [int] IDENTITY(1,1) NOT NULL,
		[Ulica] [nvarchar](60) NOT NULL,
		[NumerMieszkania] [int] NOT NULL,
		[Miasto] [nvarchar](60) NOT NULL,
		[KodPocztowy] [nvarchar](10) NOT NULL,
		[Kraj] [nvarchar](60) NOT NULL,
	CONSTRAINT [PK_Adres] PRIMARY KEY CLUSTERED 
	(
		[AdresID] ASC
	)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
	CREATE UNIQUE INDEX
		UX_Adres
	ON Adres(Ulica, NumerMieszkania, Miasto, KodPocztowy, Kraj)

	PRINT 'Tabela Adres zosta³a utworzona.'
END
ELSE
BEGIN
	PRINT 'Tabela Adres ju¿ istnieje.'
END
GO


IF OBJECT_ID('Pracownik')  IS NULL
BEGIN
	CREATE TABLE Pracownik(
			[PracownikID] [int] IDENTITY(1,1) NOT NULL,
			[idAdres] [int] NOT NULL,
			[NumerPesel] [nvarchar](30) NOT NULL,
			[Imie] [nvarchar](30) NOT NULL,
			[DrugieImie] [nvarchar](30),
			[Nazwisko] [nvarchar](30) NOT NULL,
			[NumerTelefonu] [nvarchar](20) NOT NULL,
			[idStanowisko] [int] NOT NULL,
	CONSTRAINT [PK_Pracownik] PRIMARY KEY CLUSTERED 
	(
		[PracownikID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]

	PRINT 'Tabela Pracownik zosta³a utworzona.'
END
GO


IF OBJECT_ID('Stanowisko')  IS NULL 
BEGIN
	CREATE TABLE Stanowisko(
		[StanowiskoID] [int] IDENTITY(1,1) NOT NULL,
		[NazwaStanowiska] [nvarchar](30) NOT NULL,
	CONSTRAINT [PK_Stanowisko] PRIMARY KEY CLUSTERED 
	(
		[StanowiskoID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]

	PRINT 'Tabela Stanowisko zosta³a utworzona.'
END
ELSE
BEGIN
	PRINT 'Tabela Stanowisko ju¿ istnieje.'
END
GO

SET NOCOUNT ON 
GO

SET IDENTITY_INSERT Adres ON 

GO
-- dane testowe wygenerowane automatycznie z uzyciem strony 
-- https://www.mockaroo.com/

INSERT Adres ([AdresID], [Ulica], [NumerMieszkania], [Miasto], [KodPocztowy], [Kraj]) VALUES (1, 'Golf View', '7666', 'Obryte', '07-215', 'Poland');
GO
INSERT Adres ([AdresID], [Ulica], [NumerMieszkania], [Miasto], [KodPocztowy], [Kraj]) VALUES (2, 'Moulton', '899', 'Dobrzeñ Wielki', '46-081', 'Poland');
GO
INSERT Adres ([AdresID], [Ulica], [NumerMieszkania], [Miasto], [KodPocztowy], [Kraj]) VALUES (3, 'Goodland', '32', 'Micha³ów-Reginów', '61-731', 'Poland');
GO
INSERT Adres ([AdresID], [Ulica], [NumerMieszkania], [Miasto], [KodPocztowy], [Kraj]) VALUES (4, 'Canary', '3', '£¹cko', '33-390', 'Poland');
GO
INSERT Adres ([AdresID], [Ulica], [NumerMieszkania], [Miasto], [KodPocztowy], [Kraj]) VALUES (5, 'Troy', '91443', 'Soœno', '89-412', 'Poland');
GO
INSERT Adres ([AdresID], [Ulica], [NumerMieszkania], [Miasto], [KodPocztowy], [Kraj]) VALUES (6, 'Talmadge', '8584', 'K³omnice', '42-270', 'Poland');
GO
INSERT Adres ([AdresID], [Ulica], [NumerMieszkania], [Miasto], [KodPocztowy], [Kraj]) VALUES (7, 'Evergreen', '21', 'Kobylanka', '73-108', 'Poland');
GO
INSERT Adres ([AdresID], [Ulica], [NumerMieszkania], [Miasto], [KodPocztowy], [Kraj]) VALUES (8, 'Clemons', '744', 'Bia³a Piska', '12-230', 'Poland');
GO
INSERT Adres ([AdresID], [Ulica], [NumerMieszkania], [Miasto], [KodPocztowy], [Kraj]) VALUES (9, 'Milwaukee', '7247', 'Bojszowy Nowe', '43-220', 'Poland');
GO
INSERT Adres ([AdresID], [Ulica], [NumerMieszkania], [Miasto], [KodPocztowy], [Kraj]) VALUES (10, 'Eagle Crest', '4', 'BrzeŸnica', '68-113', 'Poland');
GO
INSERT Adres ([AdresID], [Ulica], [NumerMieszkania], [Miasto], [KodPocztowy], [Kraj]) VALUES (11, 'Rutledge', '6906', 'Mazañcowice', '43-391', 'Poland');
GO
INSERT Adres ([AdresID], [Ulica], [NumerMieszkania], [Miasto], [KodPocztowy], [Kraj]) VALUES (12, 'Boyd', '765', 'Borek', '32-765', 'Poland');
GO
INSERT Adres ([AdresID], [Ulica], [NumerMieszkania], [Miasto], [KodPocztowy], [Kraj]) VALUES (13, 'Duke', '81485', 'Ksiê¿pol', '23-415', 'Poland');
GO
INSERT Adres ([AdresID], [Ulica], [NumerMieszkania], [Miasto], [KodPocztowy], [Kraj]) VALUES (14, 'Moulton', '5212', 'Chwaszczyno', '80-209', 'Poland');
GO
INSERT Adres ([AdresID], [Ulica], [NumerMieszkania], [Miasto], [KodPocztowy], [Kraj]) VALUES (15, 'Kennedy', '6231', 'Kalwaria Zebrzydowska', '34-130', 'Poland');
GO
INSERT Adres ([AdresID], [Ulica], [NumerMieszkania], [Miasto], [KodPocztowy], [Kraj]) VALUES (16, 'Burning Wood', '310', 'Zebrzydowice', '43-410', 'Poland');
GO
INSERT Adres ([AdresID], [Ulica], [NumerMieszkania], [Miasto], [KodPocztowy], [Kraj]) VALUES (17, 'International', '510', 'Dziemiany', '83-425', 'Poland');
GO

SET IDENTITY_INSERT Adres OFF
GO

SET IDENTITY_INSERT Choroby ON 

GO
INSERT Choroby ([ChorobaID], [NazwaChoroby], [Wykluczenie]) VALUES (1, 'Cukrzyca', 'Tak')
GO
INSERT Choroby ([ChorobaID], [NazwaChoroby], [Wykluczenie]) VALUES (2, 'Wady Serca', 'Tak')
GO
INSERT Choroby ([ChorobaID], [NazwaChoroby], [Wykluczenie]) VALUES (3, 'Miad¿d¿yca', 'Tak')
GO
INSERT Choroby ([ChorobaID], [NazwaChoroby], [Wykluczenie]) VALUES (4, 'Nowotwór', 'Tak')
GO
INSERT Choroby ([ChorobaID], [NazwaChoroby], [Wykluczenie]) VALUES (5, '¯ó³taczka', 'Tak')
GO
INSERT Choroby ([ChorobaID], [NazwaChoroby], [Wykluczenie]) VALUES (6, 'AIDS', 'Tak')
GO
INSERT Choroby ([ChorobaID], [NazwaChoroby], [Wykluczenie]) VALUES (7, 'Malaria', 'Tak')
GO
INSERT Choroby ([ChorobaID], [NazwaChoroby], [Wykluczenie]) VALUES (8, 'Grypa', '2 tygodnie')
GO
INSERT Choroby ([ChorobaID], [NazwaChoroby], [Wykluczenie]) VALUES (9, 'GruŸlica', '2 lata')
GO
INSERT Choroby ([ChorobaID], [NazwaChoroby], [Wykluczenie]) VALUES (10, 'Toksoplazmoza', '6 miesiêcy')
GO


SET IDENTITY_INSERT Choroby OFF
GO

SET IDENTITY_INSERT Dawca ON 

GO
INSERT Dawca ([DawcaID], [idAdres], [idGrupaKrwi], [NumerPesel], [Imie], [DrugieImie], [Nazwisko], [NumerTelefonu]) VALUES (1, 1, 1, '82033062754', 'Tomasz', 'Jerzy', 'Marciniak', '665-123-553')
GO
INSERT Dawca ([DawcaID], [idAdres], [idGrupaKrwi], [NumerPesel], [Imie], [DrugieImie], [Nazwisko], [NumerTelefonu]) VALUES (2, 2, 4, '97030951323', 'Marzena', NULL, 'Nowak', '782-231-532')
GO
INSERT Dawca ([DawcaID], [idAdres], [idGrupaKrwi], [NumerPesel], [Imie], [DrugieImie], [Nazwisko], [NumerTelefonu]) VALUES (3, 3, 3, '76100197450', 'Andrzej', 'Tadeusz', 'Szulc', '785-124-895')
GO
INSERT Dawca ([DawcaID], [idAdres], [idGrupaKrwi], [NumerPesel], [Imie], [DrugieImie], [Nazwisko], [NumerTelefonu]) VALUES (4, 3, 7, '78071634789', 'Monika', 'Krystyna', 'Szulc', '691-346-325')
GO
INSERT Dawca ([DawcaID], [idAdres], [idGrupaKrwi], [NumerPesel], [Imie], [DrugieImie], [Nazwisko], [NumerTelefonu]) VALUES (5, 4, 5, '87070532387', 'Weronika', NULL, 'Jakubowska', '667-584-234')
GO
INSERT Dawca ([DawcaID], [idAdres], [idGrupaKrwi], [NumerPesel], [Imie], [DrugieImie], [Nazwisko], [NumerTelefonu]) VALUES (6, 5, 8, '91030499845', 'Paulina', 'Agata', 'Kowalczyk', '793-124-967')
GO
INSERT Dawca ([DawcaID], [idAdres], [idGrupaKrwi], [NumerPesel], [Imie], [DrugieImie], [Nazwisko], [NumerTelefonu]) VALUES (7, 6, 1, '70112873722', 'Klaudia', 'Patrycja', 'Baranowska', '705-659-235')
GO
INSERT Dawca ([DawcaID], [idAdres], [idGrupaKrwi], [NumerPesel], [Imie], [DrugieImie], [Nazwisko], [NumerTelefonu]) VALUES (8, 7, 3, '92102793883', 'Edyta', NULL, 'Adamska', '512-324-087')
GO
INSERT Dawca ([DawcaID], [idAdres], [idGrupaKrwi], [NumerPesel], [Imie], [DrugieImie], [Nazwisko], [NumerTelefonu]) VALUES (9, 8, 6, '91101996976', 'Szymon', 'Stefan', 'Michalak', '510-956-346')
GO
INSERT Dawca ([DawcaID], [idAdres], [idGrupaKrwi], [NumerPesel], [Imie], [DrugieImie], [Nazwisko], [NumerTelefonu]) VALUES (10, 9, 2, '87010133254', 'Zbigniew', NULL, 'Andrzejewski', '795-325-697')
GO

SET IDENTITY_INSERT Dawca OFF
GO


INSERT Donacje ([idDawca], [Ilosc], [DataDonacji]) VALUES (2, 0.45, '2020-06-11 13:17:00')
GO
INSERT Donacje ([idDawca], [Ilosc], [DataDonacji]) VALUES (6, 0.45, '2020-05-11 13:17:00')
GO
INSERT Donacje ([idDawca], [Ilosc], [DataDonacji]) VALUES (4, 0.45, '2020-04-11 13:17:00')
GO
INSERT Donacje ([idDawca], [Ilosc], [DataDonacji]) VALUES (8, 0.45, '2020-03-11 13:17:00')
GO
INSERT Donacje ([idDawca], [Ilosc], [DataDonacji]) VALUES (4, 0.45, '2020-02-11 13:17:00')
GO
INSERT Donacje ([idDawca], [Ilosc], [DataDonacji]) VALUES (2, 0.45, '2020-01-11 13:17:00')
GO
INSERT Donacje ([idDawca], [Ilosc], [DataDonacji]) VALUES (10, 0.45, '2019-06-11 13:17:00')
GO
INSERT Donacje ([idDawca], [Ilosc], [DataDonacji]) VALUES (4, 0.45, '2019-08-11 13:17:00')
GO
INSERT Donacje ([idDawca], [Ilosc], [DataDonacji]) VALUES (8, 0.45, '2019-03-11 13:17:00')
GO
INSERT Donacje ([idDawca], [Ilosc], [DataDonacji]) VALUES (5, 0.45, '2019-12-11 13:17:00')
GO
INSERT Donacje ([idDawca], [Ilosc], [DataDonacji]) VALUES (4, 0.45, '2019-12-11 13:17:00')
GO
INSERT Donacje ([idDawca], [Ilosc], [DataDonacji]) VALUES (2, 0.45, '2019-11-11 13:17:00')
GO
INSERT Donacje ([idDawca], [Ilosc], [DataDonacji]) VALUES (6, 0.45, '2019-11-11 13:17:00')
GO
INSERT Donacje ([idDawca], [Ilosc], [DataDonacji]) VALUES (5, 0.45, '2019-10-11 13:17:00')
GO
INSERT Donacje ([idDawca], [Ilosc], [DataDonacji]) VALUES (8, 0.45, '2019-10-11 13:17:00')
GO
INSERT Donacje ([idDawca], [Ilosc], [DataDonacji]) VALUES (4, 0.45, '2019-09-11 13:17:00')
GO
INSERT Donacje ([idDawca], [Ilosc], [DataDonacji]) VALUES (2, 0.45, '2019-09-11 13:17:00')
GO
INSERT Donacje ([idDawca], [Ilosc], [DataDonacji]) VALUES (10, 0.45, '2019-08-11 13:17:00')
GO
INSERT Donacje ([idDawca], [Ilosc], [DataDonacji]) VALUES (5, 0.45, '2019-08-11 13:17:00')
GO
INSERT Donacje ([idDawca], [Ilosc], [DataDonacji]) VALUES (8, 0.45, '2019-07-11 13:17:00')
GO



SET IDENTITY_INSERT GrupaKrwi ON 

GO
INSERT GrupaKrwi ([GrupaKrwiID], [AB0], [Rh]) VALUES (1, 'A', '-')
GO
INSERT GrupaKrwi ([GrupaKrwiID], [AB0], [Rh]) VALUES (2, 'A', '+')
GO
INSERT GrupaKrwi ([GrupaKrwiID], [AB0], [Rh]) VALUES (3, 'B', '-')
GO
INSERT GrupaKrwi ([GrupaKrwiID], [AB0], [Rh]) VALUES (4, 'B', '+')
GO
INSERT GrupaKrwi ([GrupaKrwiID], [AB0], [Rh]) VALUES (5, 'AB', '-')
GO
INSERT GrupaKrwi ([GrupaKrwiID], [AB0], [Rh]) VALUES (6, 'AB', '+')
GO
INSERT GrupaKrwi ([GrupaKrwiID], [AB0], [Rh]) VALUES (7, '0', '-')
GO
INSERT GrupaKrwi ([GrupaKrwiID], [AB0], [Rh]) VALUES (8, '0', '+')
GO

SET IDENTITY_INSERT GrupaKrwi OFF
GO

SET IDENTITY_INSERT Leki ON 

GO
INSERT Leki ([LekID], [NazwaLeku], [Wykluczenie]) VALUES (1, 'Leki hormonalne', 'Nie')
GO
INSERT Leki ([LekID], [NazwaLeku], [Wykluczenie]) VALUES (2, 'Leki na astmê', 'Tak')
GO
INSERT Leki ([LekID], [NazwaLeku], [Wykluczenie]) VALUES (3, 'Leki przeciwcukrzycowe', 'Tak')
GO
INSERT Leki ([LekID], [NazwaLeku], [Wykluczenie]) VALUES (4, 'Witaminy', 'Nie')
GO
INSERT Leki ([LekID], [NazwaLeku], [Wykluczenie]) VALUES (5, 'Zelixia', 'Tak')
GO
INSERT Leki ([LekID], [NazwaLeku], [Wykluczenie]) VALUES (6, 'Meridia', 'Tak')
GO
INSERT Leki ([LekID], [NazwaLeku], [Wykluczenie]) VALUES (7, 'Ibuorofen', '2 dni')
GO
INSERT Leki ([LekID], [NazwaLeku], [Wykluczenie]) VALUES (8, 'Ketoprofen', '2 dni')
GO
INSERT Leki ([LekID], [NazwaLeku], [Wykluczenie]) VALUES (9, 'Aspiryna', '2 dni')
GO

SET IDENTITY_INSERT Leki OFF
GO


INSERT LekiDawcy ([idDawcaLek], [idLek]) VALUES (1, 3)
GO
INSERT LekiDawcy ([idDawcaLek], [idLek]) VALUES (1, 7)
GO
INSERT LekiDawcy ([idDawcaLek], [idLek]) VALUES (3, 8)
GO
INSERT LekiDawcy ([idDawcaLek], [idLek]) VALUES (3, 1)
GO
INSERT LekiDawcy ([idDawcaLek], [idLek]) VALUES (7, 2)
GO
INSERT LekiDawcy ([idDawcaLek], [idLek]) VALUES (7, 9)
GO
INSERT LekiDawcy ([idDawcaLek], [idLek]) VALUES (7, 5)
GO
INSERT LekiDawcy ([idDawcaLek], [idLek]) VALUES (9, 3)
GO
INSERT LekiDawcy ([idDawcaLek], [idLek]) VALUES (9, 4)
GO


SET IDENTITY_INSERT Pracownik ON 

GO
INSERT Pracownik ([PracownikID], [idAdres], [NumerPesel], [Imie], [DrugieImie], [Nazwisko], [NumerTelefonu], [idStanowisko]) VALUES (1, 10, '92040550900', 'Iga', NULL, 'Lewandowska', '725-366-845', 3)
GO
INSERT Pracownik ([PracownikID], [idAdres], [NumerPesel], [Imie], [DrugieImie], [Nazwisko], [NumerTelefonu], [idStanowisko]) VALUES (2, 11, '91031194718', 'Bartosz', 'Gustaw', 'Sawicki', '731-324-523', 4)
GO
INSERT Pracownik ([PracownikID], [idAdres], [NumerPesel], [Imie], [DrugieImie], [Nazwisko], [NumerTelefonu], [idStanowisko]) VALUES (3, 12, '84012949393', 'Alfred', NULL, 'Sobczak', '786-266-956', 4)
GO
INSERT Pracownik ([PracownikID], [idAdres], [NumerPesel], [Imie], [DrugieImie], [Nazwisko], [NumerTelefonu], [idStanowisko]) VALUES (4, 13, '71031220767', 'Maria', 'Agata', 'Majewska', '765-123-123', 1)
GO
INSERT Pracownik ([PracownikID], [idAdres], [NumerPesel], [Imie], [DrugieImie], [Nazwisko], [NumerTelefonu], [idStanowisko]) VALUES (5, 14, '94060652707', 'Aneta', NULL, 'WoŸniak', '798-474-553', 5)
GO
INSERT Pracownik ([PracownikID], [idAdres], [NumerPesel], [Imie], [DrugieImie], [Nazwisko], [NumerTelefonu], [idStanowisko]) VALUES (6, 15, '91090211029', 'Agnieszka', 'Beata', 'Makowska', '714-325-325', 3)
GO
INSERT Pracownik ([PracownikID], [idAdres], [NumerPesel], [Imie], [DrugieImie], [Nazwisko], [NumerTelefonu], [idStanowisko]) VALUES (7, 15, '89011793509', 'Adrianna', 'Cecylia', 'Piotrowska', '754-235-553', 6)
GO
INSERT Pracownik ([PracownikID], [idAdres], [NumerPesel], [Imie], [DrugieImie], [Nazwisko], [NumerTelefonu], [idStanowisko]) VALUES (8, 16, '89122444590', 'Krystian', 'Ryszard', 'Michalak', '651-858-626', 7)
GO
INSERT Pracownik ([PracownikID], [idAdres], [NumerPesel], [Imie], [DrugieImie], [Nazwisko], [NumerTelefonu], [idStanowisko]) VALUES (9, 17, '79082422275', 'Rafa³', NULL, 'Soko³owski', '665-955-553', 2)
GO
INSERT Pracownik ([PracownikID], [idAdres], [NumerPesel], [Imie], [DrugieImie], [Nazwisko], [NumerTelefonu], [idStanowisko]) VALUES (10, 12, '70031862827', 'Julita', 'Maja', 'Mazurek', '789-525-523', 3)
GO

SET IDENTITY_INSERT Pracownik OFF
GO


INSERT StanDawcy ([idDawcaStan], [idChoroba]) VALUES (1, 3)
GO
INSERT StanDawcy ([idDawcaStan], [idChoroba]) VALUES (1, 2)
GO
INSERT StanDawcy ([idDawcaStan], [idChoroba]) VALUES (3, 7)
GO
INSERT StanDawcy ([idDawcaStan], [idChoroba]) VALUES (3, 1)
GO
INSERT StanDawcy ([idDawcaStan], [idChoroba]) VALUES (7, 4)
GO
INSERT StanDawcy ([idDawcaStan], [idChoroba]) VALUES (7, 8)
GO
INSERT StanDawcy ([idDawcaStan], [idChoroba]) VALUES (3, 9)
GO
INSERT StanDawcy ([idDawcaStan], [idChoroba]) VALUES (7, 6)
GO
INSERT StanDawcy ([idDawcaStan], [idChoroba]) VALUES (9, 3)
GO
INSERT StanDawcy ([idDawcaStan], [idChoroba]) VALUES (9, 7)
GO


INSERT StanMagazynowy ([idGrupaKrwi], [IloscLitry]) VALUES (1, 20)
GO
INSERT StanMagazynowy ([idGrupaKrwi], [IloscLitry]) VALUES (2, 20)
GO
INSERT StanMagazynowy ([idGrupaKrwi], [IloscLitry]) VALUES (3, 20)
GO
INSERT StanMagazynowy ([idGrupaKrwi], [IloscLitry]) VALUES (4, 20)
GO
INSERT StanMagazynowy ([idGrupaKrwi], [IloscLitry]) VALUES (5, 20)
GO
INSERT StanMagazynowy ([idGrupaKrwi], [IloscLitry]) VALUES (6, 20)
GO
INSERT StanMagazynowy ([idGrupaKrwi], [IloscLitry]) VALUES (7, 20)
GO
INSERT StanMagazynowy ([idGrupaKrwi], [IloscLitry]) VALUES (8, 20)
GO


SET IDENTITY_INSERT Stanowisko ON 

GO
INSERT Stanowisko ([StanowiskoID], [NazwaStanowiska]) VALUES (1, N'Dyrektor') 
GO
INSERT Stanowisko ([StanowiskoID], [NazwaStanowiska]) VALUES (2, N'Kierownik Laboratorium') 
GO
INSERT Stanowisko ([StanowiskoID], [NazwaStanowiska]) VALUES (3, N'Pielêgniarka') 
GO
INSERT Stanowisko ([StanowiskoID], [NazwaStanowiska]) VALUES (4, N'Laborant') 
GO
INSERT Stanowisko ([StanowiskoID], [NazwaStanowiska]) VALUES (5, N'Recepcjonistka') 
GO
INSERT Stanowisko ([StanowiskoID], [NazwaStanowiska]) VALUES (6, N'Sprz¹taczka') 
GO
INSERT Stanowisko ([StanowiskoID], [NazwaStanowiska]) VALUES (7, N'Szatniarz') 
GO

SET IDENTITY_INSERT Stanowisko OFF
GO


ALTER TABLE Dawca WITH CHECK ADD CONSTRAINT [FK_Dawca_GrupaKrwi] FOREIGN KEY([idGrupaKrwi])
REFERENCES GrupaKrwi ([GrupaKrwiID])
GO

ALTER TABLE Donacje WITH CHECK ADD CONSTRAINT [FK_Donacje_Dawca] FOREIGN KEY([idDawca])
REFERENCES Dawca ([DawcaID])
GO

ALTER TABLE Dawca WITH CHECK ADD CONSTRAINT [FK_Dawca_Adres] FOREIGN KEY([idAdres])
REFERENCES Adres ([AdresID])
GO

ALTER TABLE StanDawcy WITH CHECK ADD CONSTRAINT [FK_StanDawcy_Dawca] FOREIGN KEY([idDawcaStan])
REFERENCES Dawca ([DawcaID])
GO

ALTER TABLE StanDawcy WITH CHECK ADD CONSTRAINT [FK_StanDawcy_Choroba] FOREIGN KEY([idChoroba])
REFERENCES Choroby ([ChorobaID])
GO

ALTER TABLE LekiDawcy WITH CHECK ADD CONSTRAINT [FK_LekiDawcy_Dawca] FOREIGN KEY([idDawcaLek])
REFERENCES Dawca ([DawcaID])
GO

ALTER TABLE LekiDawcy WITH CHECK ADD CONSTRAINT [FK_LekiDawcy_Lek] FOREIGN KEY([idLek])
REFERENCES Leki ([LekID])
GO

ALTER TABLE StanMagazynowy WITH CHECK ADD CONSTRAINT [FK_StanMagazynowy_GrupaKrwi] FOREIGN KEY([idGrupaKrwi])
REFERENCES GrupaKrwi ([GrupaKrwiID])
GO

ALTER TABLE Pracownik WITH CHECK ADD CONSTRAINT [FK_Pracownik_Adres] FOREIGN KEY([idAdres])
REFERENCES Adres ([AdresID])
GO

ALTER TABLE Pracownik WITH CHECK ADD CONSTRAINT [FK_Pracownik_Stanowisko] FOREIGN KEY([idStanowisko])
REFERENCES Stanowisko ([StanowiskoID])
GO

--Procedura dodawania nowego dawcy do bazy danych

USE BankKrwi


CREATE PROCEDURE NowyDawca
@idGrupaKrwi int,
@NumerPesel nvarchar(15),
@Imie nvarchar(25),
@DrugieImie nvarchar(25),
@Nazwisko nvarchar(25),
@NumerTelefonu nvarchar(25),
@Ulica nvarchar(25),
@NumerMieszkania int,
@Miasto nvarchar(25),
@KodPocztowy nvarchar(25),
@Kraj nvarchar(25)
AS
	SET NOCOUNT ON
	DECLARE @id INT;
	INSERT INTO Adres (Ulica, NumerMieszkania, Miasto, KodPocztowy, Kraj) VALUES (@Ulica, @NumerMieszkania, @Miasto, @KodPocztowy, @Kraj) 
	SET @id = SCOPE_IDENTITY()
	INSERT INTO Dawca (idAdres, idGrupaKrwi, NumerPesel, Imie, DrugieImie, Nazwisko, NumerTelefonu) VALUES (@id, @idGrupaKrwi, @NumerPesel, @Imie, @DrugieImie, @Nazwisko, @NumerTelefonu)
	PRINT 'Przyjêto nowego dawcê.'
GO 


EXEC NowyDawca @Ulica = 'Hallera', @NumerMieszkania = 14, @Miasto = 'Wroc³aw', @KodPocztowy = '53-310', @Kraj = 'Polska', @idGrupaKrwi = 4, @NumerPesel = '75101022404', @Imie = 'Marian', @DrugieImie = NULL, @Nazwisko = 'Andrzejak', @NumerTelefonu = '781-921-424'

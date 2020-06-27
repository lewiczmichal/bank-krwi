--Procedura dodawania nowej donacji

USE BankKrwi


CREATE PROCEDURE NowaDonacja 
@DawcaID int,
@Ilosc [numeric](3,2)
AS
	SET NOCOUNT ON
	DECLARE @GrupaKrwiDawcy INT;
	SET @GrupaKrwiDawcy = (SELECT d.idGrupaKrwi 
							FROM Dawca AS d
							WHERE d.DawcaID = @DawcaID)
	INSERT INTO Donacje (idDawca, Ilosc, DataDonacji) VALUES (@DawcaID, @Ilosc, GETDATE())
	UPDATE StanMagazynowy SET IloscLitry = (IloscLitry + @Ilosc) WHERE idGrupaKrwi = @GrupaKrwiDawcy
	PRINT 'Zaakceptowano donacjê'
GO 

EXEC NowaDonacja @DawcaID = 2, @Ilosc = 0.45


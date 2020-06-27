--Trigger wywołujący informację o dodaniu krwi konkretnego dawcy do magazynu

CREATE TRIGGER TR_Info_O_Donacji
ON StanMagazynowy
AFTER UPDATE 
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @idGK INT
	SELECT
		@idGK = inserted.idGrupaKrwi
	FROM
		inserted
	 
	DECLARE @nazwa VARCHAR(5)
	SET @nazwa = (SELECT gr.AB0
					FROM
						 GrupaKrwi AS gr
					WHERE gr.GrupaKrwiID = @idGK)
	DECLARE @nazwa2 VARCHAR(5)
	SET @nazwa2 = (SELECT gr.Rh
					FROM
						 GrupaKrwi AS gr
					WHERE gr.GrupaKrwiID = @idGK)
	
	PRINT 'Dodano do magazynu krew '+@nazwa+@nazwa2
END
GO

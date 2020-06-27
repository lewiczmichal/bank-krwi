--Funkcja sprawdzająca czy dawca o konkretnym numerze PESEL może oddać krew

USE BankKrwi

CREATE FUNCTION CzyWykluczony (@Pesel VARCHAR(12))
RETURNS TABLE AS
RETURN (SELECT
			dw.Imie
			,dw.Nazwisko
			,l.NazwaLeku AS Przyczyna
			,l.Wykluczenie
		FROM
			LekiDawcy AS ld
		FULL OUTER JOIN Dawca AS dw ON dw.DawcaID = ld.idDawcaLek
		FULL OUTER JOIN Leki AS l ON l.LekID = ld.idLek
		WHERE dw.NumerPesel = @Pesel)

		UNION

		(SELECT
			dw.Imie
			,dw.Nazwisko
			,ch.NazwaChoroby
			,ch.Wykluczenie
		FROM
			StanDawcy AS sd
		FULL OUTER JOIN Dawca AS dw ON dw.DawcaID = sd.idDawcaStan
		FULL OUTER JOIN Choroby as ch ON ch.ChorobaID = sd.idChoroba
		WHERE dw.NumerPesel = @Pesel)
GO


SELECT * FROM CzyWykluczony('70112873722')

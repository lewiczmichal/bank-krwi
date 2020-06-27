--Widok dla zebranych danych wszystkich dawców

USE BankKrwi

CREATE VIEW vDaneDawcow AS 
SELECT
	dw.DawcaID
	,dw.Imie
	,dw.DrugieImie
	,dw.Nazwisko
	,dw.NumerPesel
	,dw.NumerTelefonu
	,a.Ulica
	,a.NumerMieszkania
	,a.Miasto
	,a.KodPocztowy
	,a.Kraj
	,gr.AB0 AS GrupaKrwi
	,gr.Rh
FROM
	Dawca AS dw 
LEFT JOIN Adres AS a ON dw.idAdres = a.AdresID
LEFT JOIN GrupaKrwi AS gr ON dw.idGrupaKrwi = gr.GrupaKrwiID

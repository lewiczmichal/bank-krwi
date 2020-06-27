--Widok informujący o stanie magazynowym poszczególnych grup krwi

USE BankKrwi

CREATE VIEW vStanMagazynu AS 
SELECT
	gr.AB0
	,gr.Rh
	,st.IloscLitry
FROM
	GrupaKrwi AS gr 
JOIN StanMagazynowy AS st ON st.idGrupaKrwi = gr.GrupaKrwiID

--Manipulação de dados
--INSERT todos os campos da tabela

INSERT INTO Person
VALUES (1, 'Sidney', 'Moreira', 'mono@gmail.com', '16999999999', '234213432-12', 'QA');

--com alguns campos
INSERT INTO Person (PersonID, LastName, Phone, documentCPF)
VALUES (2, 'Moreira', '16999999999', '234213432-12');

--Utilizando o Select todos os registros
SELECT  * FROM Person;

--Selec com Where
SELECT * FROM Person
WHERE PersonID = 1;

--SELECT dados especificos
SELECT PersonID, FirstName, Phone
FROM Person;

--SELECT dados especificos com Where
SELECT PersonID, FirstName, Phone
FROM Person
Where PersonID = 1
AND State = 'QA';

-- UPDATE de registros
UPDATE Person 
SET FirstName = 'Antonio',
Mail = 'teste@tesc.com',
State = 'ME'
WHERE PersonID = 2;

--Deletano registros
DELETE Person 
WHERE PersonID = 2
AND FirstName = 'Antonio'

-- Principais comando utilizados com o SELECT
--2 primeiros registros
SELECT TOP 2 * FROM Person;

SELECT TOP 2 * 
FROM Person
WHERE State = 'QA';

-- 2 ultimos registros
SELECT TOP 2 * FROM Person ORDER BY 1 DESC;

SELECT TOP 2 * FROM Person ORDER BY 1 ASC;

SELECT TOP 2 * FROM Person ORDER BY PersonID ASC;

--SELECT por porcentagem
SELECT TOP 50 PERCENT * FROM Person;

SELECT TOP 50 PERCENT LastName FROM Person;

-- Select com sub-query 

SELECT * FROM Person WHERE PersonID = 1;
SELECT * FROM Phone WHERE PersonID = 1;

SELECT *
FROM Phone 
WHERE PersonID = (SELECT PersonID FROM Person WHERE PersonID = 1);

--select com MIN
CREATE TABLE Price(
    PriceID int IDENTITY(1,1) PRIMARY KEY,
    PersonID int NOT NULL,
    PriceValue FLOAT NOT NULL,
    Descriptions varchar(255),
    Status varchar(10),
    FOREIGN KEY(PersonID) REFERENCES Person(PersonID)
);

INSERT Price 
VALUES (1, 25.32, 'Testes testese testesets', 'Pago');
INSERT Price 
VALUES (1, 13.32, 'Vai que é sua', 'Pago');
INSERT Price 
VALUES (1, 5.5, 'Qualquer coisa', 'Pendente');
INSERT Price 
VALUES (1, 105.5, 'Não vai ver a cor do money', 'Pendente');

SELECT MIN(PriceValue) AS 'Valor do Produto'
FROM Price;

--valor maximo
SELECT MAX(PriceValue) AS 'Valor do Produto'
FROM Price;

--Soma do valor
SELECT SUM(PriceValue) AS 'Valor do Produto'
FROM Price;

--valor maximo COM CONDIÇÃO
SELECT MAX(PriceValue) AS 'Valor do Produto'
FROM Price
WHERE Status = 'Pago';

--select com count
SELECT COUNT(PersonID)
FROM Price 
WHERE PersonID = 1;

-- Select com INNER-JOIN e Left-JOIN
SELECT * FROM Person;
SELECT * FROM Price;

--INNER JOIN (EXIBE REGISTRO CORRESPONDENTE NAS DUAS TABELAS)
SELECT per.PersonID, per.FirstName, pri.PriceValue, pri.Descriptions, pri.Status 
FROM Person per
INNER JOIN Price 
ON per.PersonID = pri.PersonID
WHERE pri.PersonID = 1

--LEFT Join (EXIBA TODOS OS REGISTRO DA ESQUERDA INDEPENDENTE QUE NAO TENHA NA DIREITA)
SELECT per.PersonID, per.FirstName, pri.PriceValue, pri.Descriptions, pri.Status 
FROM Person per
LEFT JOIN Price 
ON per.PersonID = pri.PersonID

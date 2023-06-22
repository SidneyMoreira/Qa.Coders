-- *Comando importantes para Administração
--select * from sys.schemas;
--select * from sys.all_objects;
--select * from sys.databases;
--select * from sys.column_type_usages;

--Criando Database
CREATE DATABASE jobCampSQL;

--Deletando Database
DROP DATABASE jobCampSQL;

--Criando Backup e Backup with Differencial
--1ª Forma
BACKUP DATABASE jobCampSQL
TO DISK = '/Users/kadarpegasus/backupSQL/jobCampSQL.bak';

-- 2ª Forma
BACKUP DATABASE jobCampSQL
TO DISK = '/Users/kadarpegasus/backupSQL/jobCampSQL.bak'
WITH DIFERENTIAL;

--Acessando o Database:
USE jobCampSQL;

-- Criando tabelas:
CREATE TABLE Person(
	PersonID int Primary Key,
  FirstName varchar(255),
  LastName varchar(255),
  Mail varchar(255),
  Phone varchar(255)
);

CREATE TABLE Adrress (
	AddressID int Primary Key,
  PersonID int,
  City varchar(255),
  Logradouro varchar(255),
  Number varchar(255),
  Complement varchar(255),
  ZipCode varchar (255),
  
  FOREIGN KEY(PersonID) REFERENCES Person(PersonID)
);

--Deletando Tabelas:
CREATE TABLE TabelaTeste (
	TesteID int Primary Key,
  Nome varchar(255),
  SobreNome varchar(255)  
);

DROP TABLE TabelaTeste;

--Deletando Regristro da Tabela
TRUNCATE TABLE TabelaTeste;

--Listar as caracteristicas de uma tabela:
EXEC sp_help 'Person';

--Alterando as caracteristica de uma tabela:
ALTER TABLE Person
--ADD Cod int,
ADD State varchar(14);

--remover uma coluna da tabela:
ALTER TABLE Person
DROP COLUMN cod;

--Alterar o tipo da coluna de uma tabela
ALTER TABLE Person
ALTER COLUMN State char(2);

O script abaixo é usado para?
EXEC sp_helo
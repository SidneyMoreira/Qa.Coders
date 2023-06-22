-- Tabela com campos com regras NOT Null (Struturação de Tabelas)
CREATE TABLE Vehicle(
  VehicleID int NOT NULL,
  Model varchar(20) NOT NULL,
  YearVeicle Date NOT NULL,
  FOREIGN KEY(VehicleID) REFERENCES Person(PersonID)
);


EXEC sp_help 'vehicle'

--Tabelas com campos unicos (UNIQUE)
CREATE TABLE Mail(
  MailID int NOT NULL,
  PersonID int NOT NULL,
  Mail varchar(255),
  UNIQUE(MailID),
  FOREIGN KEY(PersonID) REFERENCES Person(PersonID)
);

CREATE TABLE Phone(
  PhoneID int NOT NULL,
  PersonID int NOT NULL,
  Phone varchar(16),
  UNIQUE(PhoneID, PersonID),
--  FOREIGN KEY(PersonID) REFERENCES Person(PersonID)
);

--Tabelas com chaves primarias (PRIMARY KEY) - RELACIONAMENTOS
CREATE TABLE Pet(
  PetID int NOT NULL PRIMARY KEY,
  NamePet varchar(30) NOT NULL,
  NamePerson varchar(150) NOT NULL,
  Age int
);

--TABEL COM IDENTIFICAÇÃO - IDENTIFY
CREATE TABLE Orders(
  OrderID int IDENTITY(1, 1) PRIMARY KEY,
  PersonID int NOT NULL,
  DescriptionOrder varchar(255),
  ValueOrder float
--  FOREIGN KEY(PersonID) REFERENCES Person(PersonID)
);

CREATE TABLE Payment(
  PaymentID int IDENTITY(1, 5) PRIMARY KEY,
  OrderID int NOT NULL,
  PersonID int NOT NULL,
  DescriptionOrder varchar(255),
  ValueOrder float
);
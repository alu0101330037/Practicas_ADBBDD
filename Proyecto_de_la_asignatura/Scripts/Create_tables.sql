--Borrado de todas las tablas
DROP TABLE IF EXISTS Seguridad;
DROP TABLE IF EXISTS Mantenimiento;
DROP TABLE IF EXISTS Marketing;
DROP TABLE IF EXISTS Empleados;
DROP TABLE IF EXISTS Empresa;
DROP TABLE IF EXISTS Participantes;
DROP TABLE IF EXISTS Entrada;
DROP TABLE IF EXISTS Carreras;
DROP TABLE IF EXISTS Personas;

--Tabla Personas
CREATE TABLE IF NOT EXISTS Personas (
  DNI int NOT NULL,
  Edad int NOT NULL,
  CHECK(Edad >= 18),
  Sexo varchar(255) NOT NULL,
  PRIMARY KEY (DNI)
);

--Tabla Carreras
CREATE TABLE IF NOT EXISTS Carreras (
  C_Carrera int NOT NULL,
  Ciudad_Carrera varchar(255) NOT NULL,
  Distancia int NOT NULL,
  Fecha DATE NOT NULL,
  CHECK(Fecha < NOW()),
  PRIMARY KEY (C_Carrera)
);

--Tabla Entrada
CREATE TABLE IF NOT EXISTS Entrada (
  N_Entrada int NOT NULL,
  Precio int NOT NULL,
  C_Carrera int NOT NULL,
  PRIMARY KEY (N_Entrada),
  FOREIGN KEY (C_Carrera) REFERENCES Carreras(C_Carrera)
);

--Tabla Participantes
CREATE TABLE IF NOT EXISTS Participantes (
  DNI int NOT NULL,
  N_Entrada int NOT NULL,
  C_Carrera int NOT NULL,
  Tiempo TIME,
  PRIMARY KEY (DNI,N_Entrada,C_Carrera),
  FOREIGN KEY (DNI) REFERENCES Personas(DNI),
  FOREIGN KEY (C_Carrera) REFERENCES Carreras(C_Carrera),
  FOREIGN KEY (N_Entrada) REFERENCES Entrada(N_Entrada)
);

--Tabla Empresa
CREATE TABLE IF NOT EXISTS Empresa (
  NIF int NOT NULL,
  Sector varchar(255) NOT NULL,
  Ingresos int NOT NULL,
  C_Carrera int NOT NULL,
  PRIMARY KEY (NIF),
  FOREIGN KEY (C_Carrera) REFERENCES Carreras(C_Carrera)
);

--Tabla Empleados
CREATE TABLE IF NOT EXISTS Empleados (
  DNI int NOT NULL UNIQUE,
  Nombre_y_apellidos varchar(255) NOT NULL,
  Salario int NOT NULL,
  Tipo varchar(255) NOT NULL,
  CHECK(Tipo IN ('Marketing','Mantenimiento','Seguridad')),
  NIF int NOT NULL,
  PRIMARY KEY (DNI,NIF),
  FOREIGN KEY (DNI) REFERENCES Personas(DNI),
  FOREIGN KEY (NIF) REFERENCES Empresa(NIF)
);

--Tabla Marketing
CREATE TABLE IF NOT EXISTS Marketing (
  DNI int NOT NULL,
  Tipo_de_publicidad varchar(255) NOT NULL,
  PRIMARY KEY (DNI),
  FOREIGN KEY (DNI) REFERENCES Empleados(DNI)
);

--Tabla Mantenimiento
CREATE TABLE IF NOT EXISTS Mantenimiento (
  DNI int NOT NULL,
  Km_revisados int NOT NULL,
  PRIMARY KEY (DNI),
  FOREIGN KEY (DNI) REFERENCES Empleados(DNI)
);

--Tabla Seguridad
CREATE TABLE IF NOT EXISTS Seguridad (
  DNI int NOT NULL,
  Carreras_Supervisadas int NOT NULL,
  PRIMARY KEY (DNI),
  FOREIGN KEY (DNI) REFERENCES Empleados(DNI)
);

--Trigger para un empleado no pueda ser participante en una carrera en la que trabaje
CREATE TRIGGER participantes_carrera_trigger BEFORE INSERT ON Participantes FOR EACH ROW EXECUTE FUNCTION participantes_carrera_function();

CREATE OR REPLACE FUNCTION participantes_carrera_function() RETURNS trigger AS $$
BEGIN
  IF EXISTS (SELECT * FROM Empleados WHERE DNI = NEW.DNI AND NIF IN (SELECT NIF FROM Empresa WHERE C_Carrera = NEW.C_Carrera)) THEN
    RAISE EXCEPTION 'No se puede añadir un empleado como participante en una carrera en la que trabaje';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--Trigger para que un participante no pueda ser un empleado
CREATE TRIGGER participantes_empleado_trigger BEFORE INSERT ON Empleados FOR EACH ROW EXECUTE FUNCTION participantes_empleado_function();

CREATE OR REPLACE FUNCTION participantes_empleado_function() RETURNS trigger AS $$
BEGIN
  IF EXISTS (SELECT * FROM Participantes WHERE DNI = NEW.DNI) THEN
    RAISE EXCEPTION 'No se puede añadir un participante como empleado en una carrera en la que participe';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--Trigger para que cuando la empresa contrate a un empleado se inserte en la tabla correspondiente
CREATE TRIGGER autoinsercion_trigger AFTER INSERT ON Empleados FOR EACH ROW EXECUTE FUNCTION autoinsercion();

CREATE OR REPLACE FUNCTION autoinsercion() RETURNS trigger AS $$
BEGIN
  CASE
    WHEN NEW.Tipo = 'Seguridad' THEN
      INSERT INTO Seguridad VALUES (NEW.DNI,0);
    WHEN NEW.Tipo = 'Mantenimiento' THEN
      INSERT INTO Mantenimiento VALUES (NEW.DNI,0);
    WHEN NEW.Tipo = 'Marketing' THEN
      INSERT INTO Marketing VALUES (NEW.DNI,'Online');
  END CASE;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--Trigger para que cuando se elimine un empleado se elimine de la tabla correspondiente
CREATE TRIGGER autoremoval_trigger AFTER DELETE ON Empleados FOR EACH ROW EXECUTE FUNCTION autoremoval();

CREATE OR REPLACE FUNCTION autoremoval() RETURNS trigger AS $$
BEGIN
  CASE
    WHEN OLD.Tipo = 'Seguridad' THEN
      DELETE FROM Seguridad WHERE DNI = OLD.DNI;
    WHEN OLD.Tipo = 'Mantenimiento' THEN
      DELETE FROM Mantenimiento WHERE DNI = OLD.DNI;
    WHEN OLD.Tipo = 'Marketing' THEN
      DELETE FROM Marketing WHERE DNI = OLD.DNI;
  END CASE;
  RETURN OLD;
END;
$$ LANGUAGE plpgsql;

--Trigger para que cuando se elimine una carrera se eliminen todos los participantes
CREATE TRIGGER autoremoval_carrera_trigger AFTER DELETE ON Carreras FOR EACH ROW EXECUTE FUNCTION autoremoval_carrera();

CREATE OR REPLACE FUNCTION autoremoval_carrera() RETURNS trigger AS $$
BEGIN
  DELETE FROM Participantes WHERE C_Carrera = OLD.C_Carrera;
  RETURN OLD;
END;
$$ LANGUAGE plpgsql;

--Trigger para que cuando se elimine una empresa se eliminen todos los empleados
CREATE TRIGGER autoremoval_empresa_trigger AFTER DELETE ON Empresa FOR EACH ROW EXECUTE FUNCTION autoremoval_empresa();

CREATE OR REPLACE FUNCTION autoremoval_empresa() RETURNS trigger AS $$
BEGIN
  DELETE FROM Empleados WHERE NIF = OLD.NIF;
  RETURN OLD;
END;
$$ LANGUAGE plpgsql;

--Constraint para que el sexo de una persona solo pueda ser hombre o mujer
ALTER TABLE Personas ADD CONSTRAINT Sexo CHECK (Sexo IN ('Hombre','Mujer'));
--Constraint para que el tipo de publicidad solo pueda ser online o offline
ALTER TABLE Marketing ADD CONSTRAINT Tipo_de_publicidad CHECK (Tipo_de_publicidad IN ('Online','Offline'));
--Constraint para que el sector de la empresa solo pueda ser privado o publico
ALTER TABLE Empresa ADD CONSTRAINT Sector CHECK (Sector IN ('Privado','Publico'));
--Constraint para que el salario de un empleado no pueda ser negativo
ALTER TABLE Empleados ADD CONSTRAINT Salario CHECK (Salario >= 0);
--Constraint para que el ingreso de una empresa no pueda ser negativo
ALTER TABLE Empresa ADD CONSTRAINT Ingresos CHECK (Ingresos >= 0);
--Constraint para que el km revisado de un empleado de mantenimiento no pueda ser negativo
ALTER TABLE Mantenimiento ADD CONSTRAINT Km_revisados CHECK (Km_revisados >= 0);
--Constraint para que el numero de carreras supervisadas de un empleado de seguridad no pueda ser negativo
ALTER TABLE Seguridad ADD CONSTRAINT Carreras_Supervisadas CHECK (Carreras_Supervisadas >= 0);
--Constraint para que el precio de una entrada no pueda ser negativo
ALTER TABLE Entrada ADD CONSTRAINT Precio CHECK (Precio >= 0);
--Constraint para que la distancia de una carrera no pueda ser negativa
ALTER TABLE Carreras ADD CONSTRAINT Distancia CHECK (Distancia >= 0);

--Tabla Personas
CREATE TABLE IF NOT EXISTS `Personas` (
  `DNI` int(9) NOT NULL,
  CHECK(`DNI` > 10000000),
  `Edad` int(2) NOT NULL,
  CHECK(`Edad` >= 18),
  `Sexo` varchar(255) NOT NULL,
  PRIMARY KEY (`DNI`)
);

--Tabla Carreras
CREATE TABLE IF NOT EXISTS `Carreras` (
  `C_Carrera` int(11) NOT NULL,
  `Ciudad_Carrera` varchar(255) NOT NULL,
  `Distancia` int(3) NOT NULL,
  `Fecha` DATE NOT NULL,
  CHECK(`Fecha` > CURRENT_DATE),
  PRIMARY KEY (`C_Carrera`)
);

--Tabla Entrada
CREATE TABLE IF NOT EXISTS `Entrada` (
  `N_Entrada` int(11) NOT NULL,
  `Precio` int(3) NOT NULL,
  `C_Carrera` int(11) NOT NULL,
  PRIMARY KEY (`N_Entrada`),
  FOREIGN KEY (`C_Carrera`) REFERENCES Carreras(`C_Carrera`)
);

--Tabla Participantes
CREATE TABLE IF NOT EXISTS `Participantes` (
  `DNI` int(9) NOT NULL,
  `N_Entrada` int(11) NOT NULL,
  `C_Carrera` int(11) NOT NULL,
  `Tiempo` int(4) NOT NULL,
  PRIMARY KEY (`DNI`,`N_Entrada`,`C_Carrera`),
  FOREIGN KEY (`DNI`) REFERENCES Personas(`DNI`),
  FOREIGN KEY (`C_Carrera`) REFERENCES Carreras(`C_Carrera`),
  FOREIGN KEY (`N_Entrada`) REFERENCES Entrada(`N_Entrada`)
);

--Tabla Empresa
CREATE TABLE IF NOT EXISTS `Empresa` (
  `NIF` int(9) NOT NULL,
  `Sector` varchar(255) NOT NULL,
  `Ingresos` int(6) NOT NULL,
  `C_Carrera` int(11) NOT NULL,
  PRIMARY KEY (`NIF`,`C_Carrera`),
  FOREIGN KEY (`C_Carrera`) REFERENCES Carreras(`C_Carrera`)
);

--Tabla Empleados
CREATE TABLE IF NOT EXISTS `Empleados` (
  `DNI` int(9) NOT NULL,
  CHECK (`DNI` NOT IN  (SELECT DNI FROM Participantes)),
  `Nombre y apellidos` varchar(255) NOT NULL,
  `Salario` int(6) NOT NULL,
  `NIF` int(9) NOT NULL,
  PRIMARY KEY (`DNI`,`NIF`),
  FOREIGN KEY (`DNI`) REFERENCES Personas(`DNI`),
  FOREIGN KEY (`NIF`) REFERENCES Empresa(`NIF`)
);

--Tabla Marketing
CREATE TABLE IF NOT EXISTS `Marketing` (
  `DNI` int(9) NOT NULL,
  CHECK(`DNI` IN (SELECT DNI FROM Empleados)),
  `Horas_semanales` int(2) NOT NULL,
  CHECK(`Horas_semanales` >= 40),
  PRIMARY KEY (`DNI`),
  FOREIGN KEY (`DNI`) REFERENCES Empleados(`DNI`),
);

--Tabla Mantenimiento
CREATE TABLE IF NOT EXISTS `Mantenimiento` (
  `DNI` int(9) NOT NULL,
  CHECK(`DNI` IN (SELECT DNI FROM Empleados)),
  `Horas_semanales` int(2) NOT NULL,
  CHECK(`Horas_semanales` >= 40),
  PRIMARY KEY (`DNI`),
  FOREIGN KEY (`DNI`) REFERENCES Empleados(`DNI`),
);

--Tabla Seguridad
CREATE TABLE IF NOT EXISTS `Seguridad` (
  `DNI` int(9) NOT NULL,
  CHECK(`DNI` IN (SELECT DNI FROM Empleados)),
  `Horas_semanales` int(2) NOT NULL,
  PRIMARY KEY (`DNI`),
  FOREIGN KEY (`DNI`) REFERENCES Empleados(`DNI`),
);

--Trigger para insertar en una tabla llamada cambios la fecha actual cada vez que se añade un registro a la tabla Carreras

--Tabla auxiliar
CREATE TABLE IF NOT EXISTS `Cambios` (
  `Fecha_` DATE NOT NULL,
  PRIMARY KEY (`Fecha_`)
);

--Trigger
CREATE TRIGGER `curr_date_trigger` AFTER INSERT ON `Carreras` FOR EACH ROW EXECUTE FUNCTION curr_date_function();

--Funcion
CREATE OR REPLACE FUNCTION curr_date_function() RETURNS trigger AS $$
BEGIN
  INSERT INTO Cambios VALUES (CURRENT_DATE);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--Aserto para que no hayan dos carreras el mismo día
CREATE ASSERTION unique_date_assertion CHECK (SELECT COUNT(*) FROM Carreras GROUP BY Fecha HAVING COUNT(*) > 1) IS FALSE;
--Aserto para que cada DNI sea diferente
CREATE ASSERTION unique_DNI_assertion CHECK (SELECT COUNT(*) FROM Personas GROUP BY DNI HAVING COUNT(*) > 1) IS FALSE;
--Aserto para que cada NIF sea diferente
CREATE ASSERTION unique_NIF_assertion CHECK (SELECT COUNT(*) FROM Empresa GROUP BY NIF HAVING COUNT(*) > 1) IS FALSE;
--Aserto para que cada N_Entrada sea diferente
CREATE ASSERTION unique_N_Entrada_assertion CHECK (SELECT COUNT(*) FROM Entrada GROUP BY N_Entrada HAVING COUNT(*) > 1) IS FALSE;
--Aserto para que cada C_Carrera sea diferente
CREATE ASSERTION unique_C_Carrera_assertion CHECK (SELECT COUNT(*) FROM Carreras GROUP BY C_Carrera HAVING COUNT(*) > 1) IS FALSE;

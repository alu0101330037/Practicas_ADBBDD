--Inserciones en la tabla Personass
INSERT INTO Personas (DNI, Edad, Sexo) VALUES (12345678, 20, 'Hombre');
INSERT INTO Personas (DNI, Edad, Sexo) VALUES (87654321, 18, 'Mujer');
INSERT INTO Personas (DNI, Edad, Sexo) VALUES (11111111, 22, 'Hombre');
INSERT INTO Personas (DNI, Edad, Sexo) VALUES (22222222, 21, 'Mujer');
INSERT INTO Personas (DNI, Edad, Sexo) VALUES (33333333, 30, 'Hombre');
INSERT INTO Personas (DNI, Edad, Sexo) VALUES (44444444, 35, 'Mujer');
INSERT INTO Personas (DNI, Edad, Sexo) VALUES (55555555, 34, 'Hombre');
INSERT INTO Personas (DNI, Edad, Sexo) VALUES (66666666, 24, 'Mujer');
INSERT INTO Personas (DNI, Edad, Sexo) VALUES (77777777, 28, 'Hombre');
INSERT INTO Personas (DNI, Edad, Sexo) VALUES (88888888, 23, 'Mujer');
INSERT INTO Personas (DNI, Edad, Sexo) VALUES (99999999, 25, 'Hombre');
INSERT INTO Personas (DNI, Edad, Sexo) VALUES (12121212, 26, 'Mujer');
INSERT INTO Personas (DNI, Edad, Sexo) VALUES (13131313, 27, 'Hombre');
INSERT INTO Personas (DNI, Edad, Sexo) VALUES (14141414, 29, 'Mujer');

--Inserciones en la tabla Carreras
INSERT INTO Carreras (C_Carrera, Ciudad_Carrera, Distancia, Fecha) VALUES (1, 'Madrid', 10, '2019-01-01');
INSERT INTO Carreras (C_Carrera, Ciudad_Carrera, Distancia, Fecha) VALUES (2, 'Barcelona', 20, '2019-01-02');
INSERT INTO Carreras (C_Carrera, Ciudad_Carrera, Distancia, Fecha) VALUES (3, 'Valencia', 30, '2019-01-03');
INSERT INTO Carreras (C_Carrera, Ciudad_Carrera, Distancia, Fecha) VALUES (4, 'Sevilla', 40, '2019-01-04');
INSERT INTO Carreras (C_Carrera, Ciudad_Carrera, Distancia, Fecha) VALUES (5, 'Zaragoza', 50, '2019-01-05');
INSERT INTO Carreras (C_Carrera, Ciudad_Carrera, Distancia, Fecha) VALUES (6, 'Malaga', 60, '2019-01-06');
INSERT INTO Carreras (C_Carrera, Ciudad_Carrera, Distancia, Fecha) VALUES (7, 'Murcia', 70, '2019-01-07');
INSERT INTO Carreras (C_Carrera, Ciudad_Carrera, Distancia, Fecha) VALUES (8, 'Palma', 80, '2019-01-08');
INSERT INTO Carreras (C_Carrera, Ciudad_Carrera, Distancia, Fecha) VALUES (9, 'Bilbao', 90, '2019-01-09');

--Inserciones en la tabla Entradas
INSERT INTO Entrada (N_Entrada, Precio, C_Carrera) VALUES (1, 10, 1);
INSERT INTO Entrada (N_Entrada, Precio, C_Carrera) VALUES (2, 20, 2);
INSERT INTO Entrada (N_Entrada, Precio, C_Carrera) VALUES (3, 30, 3);
INSERT INTO Entrada (N_Entrada, Precio, C_Carrera) VALUES (4, 40, 1);
INSERT INTO Entrada (N_Entrada, Precio, C_Carrera) VALUES (5, 50, 1);

--Inserciones en la tabla Participantes
INSERT INTO Participantes (DNI, C_Carrera, N_Entrada, Tiempo) VALUES (12345678, 1, 1, '01:28:59');
INSERT INTO Participantes (DNI, C_Carrera, N_Entrada, Tiempo) VALUES (87654321, 2, 2, NULL);
INSERT INTO Participantes (DNI, C_Carrera, N_Entrada, Tiempo) VALUES (11111111, 3, 3, '1:00:00');
INSERT INTO Participantes (DNI, C_Carrera, N_Entrada, Tiempo) VALUES (22222222, 4, 4, '0:40:22');

--Inserciones en la tabla Empresa
INSERT INTO Empresa (NIF, Sector, Ingresos, C_Carrera) VALUES (12345678, 'Publico', 1000, 1);
INSERT INTO Empresa (NIF, Sector, Ingresos, C_Carrera) VALUES (87654321, 'Privado', 2000, 2);
INSERT INTO Empresa (NIF, Sector, Ingresos, C_Carrera) VALUES (11111111, 'Publico', 3000, 3);
INSERT INTO Empresa (NIF, Sector, Ingresos, C_Carrera) VALUES (22222222, 'Privado', 4000, 4);

--Inserciones en la tabla Empleados
INSERT INTO Empleados (DNI, Nombre_y_apellidos, Salario, Tipo, NIF) VALUES (12345678, 'Juan Perez', 1000, 'Marketing', 12345678);
INSERT INTO Empleados (DNI, Nombre_y_apellidos, Salario, Tipo, NIF) VALUES (87654321, 'Maria Lopez', 2000, 'Mantenimiento', 87654321);
INSERT INTO Empleados (DNI, Nombre_y_apellidos, Salario, Tipo, NIF) VALUES (11111111, 'Pedro Sanchez', 3000, 'Seguridad', 11111111);
INSERT INTO Empleados (DNI, Nombre_y_apellidos, Salario, Tipo, NIF) VALUES (22222222, 'Ana Garcia', 4000, 'Marketing', 22222222);
INSERT INTO Empleados (DNI, Nombre_y_apellidos, Salario, Tipo, NIF) VALUES (33333333, 'Jose Martinez', 5000, 'Mantenimiento', 12345678);
INSERT INTO Empleados (DNI, Nombre_y_apellidos, Salario, Tipo, NIF) VALUES (44444444, 'Luisa Fernandez', 6000, 'Seguridad', 87654321);
INSERT INTO Empleados (DNI, Nombre_y_apellidos, Salario, Tipo, NIF) VALUES (55555555, 'Antonio Rodriguez', 7000, 'Marketing', 11111111);
INSERT INTO Empleados (DNI, Nombre_y_apellidos, Salario, Tipo, NIF) VALUES (66666666, 'Maria Jimenez', 8000, 'Mantenimiento', 22222222);

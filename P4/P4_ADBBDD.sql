/* Creación de la tabla Vivero */
CREATE TABLE viveros(
    vivero VARCHAR(30),
    PRIMARY KEY(vivero)
);

/* Creación de la tabla Zonas */
CREATE TABLE zonas(
    productividad INT NOT NULL,
    zona VARCHAR(30),
    vivero VARCHAR(30),
    PRIMARY KEY(zona),
    FOREIGN KEY(vivero) REFERENCES viveros ON DELETE CASCADE
);

/* Creación de la tabla Empleados */
CREATE TABLE empleados(
    empleado VARCHAR(30),
    historico_puestos VARCHAR(30),
    zona VARCHAR(30) REFERENCES zonas ON DELETE SET NULL,
    PRIMARY KEY(empleado)
);

/* Creación de la tabla Productos */
CREATE TABLE productos(
    producto VARCHAR(30),
    disponibilidad INT,
    zona VARCHAR(30) REFERENCES zonas ON DELETE SET NULL,
    PRIMARY KEY(producto)
);



/* Creación de la tabla Cliente: no plus y plus */
CREATE TABLE clientes(
    dni VARCHAR(30),
    vip INT,
    beneficios INT,
    volumen_compras INT,
    PRIMARY KEY(dni)
    
);

/* Creación de la tabla Pedidos */
CREATE TABLE pedidos(
    dni VARCHAR(30),
    pedido INT,
    empleado VARCHAR(30),
    PRIMARY KEY(pedido),
    FOREIGN KEY(empleado) REFERENCES empleados,
    FOREIGN KEY(dni) REFERENCES clientes ON DELETE SET NULL

);



insert into viveros (vivero) values ('Vivero1');
insert into viveros (vivero) values ('Vivero2');
insert into viveros (vivero) values ('Vivero3');
insert into viveros (vivero) values ('Vivero4');
insert into viveros (vivero) values ('Vivero5');

insert into zonas (productividad, zona, vivero) values (20,'Norte', 'Vivero1');
insert into zonas (productividad, zona, vivero) values (70,'Sur', 'Vivero2');
insert into zonas (productividad, zona, vivero) values (30,'Este', 'Vivero3');
insert into zonas (productividad, zona, vivero) values (40,'Oeste', 'Vivero4');
insert into zonas (productividad, zona, vivero) values (80,'Nor-Oeste', 'Vivero5');

insert into empleados (empleado, historico_puestos, zona) values ('Isa','Puesto1', 'Norte');
insert into empleados (empleado, historico_puestos, zona) values ('Maria','Puesto2', 'Sur');
insert into empleados (empleado, historico_puestos, zona) values ('Pablo','Puesto1', 'Este');
insert into empleados (empleado, historico_puestos, zona) values ('Juan','Puesto2', 'Oeste');
insert into empleados (empleado, historico_puestos, zona) values ('Luis','Puesto3', 'Nor-Oeste');

insert into productos (producto, disponibilidad, zona) values ('blanco', 20, 'Norte');
insert into productos (producto, disponibilidad, zona) values ('afrutado', 70, 'Sur');
insert into productos (producto, disponibilidad, zona) values ('rojo', 30, 'Este');
insert into productos (producto, disponibilidad, zona) values ('amarillo', 40, 'Oeste');
insert into productos (producto, disponibilidad, zona) values ('Oscuro', 80, 'Nor-Oeste');

insert into clientes (dni, vip, beneficios, volumen_compras) values ('4321124T', 0, 0, 10);
insert into clientes (dni, vip, beneficios, volumen_compras) values ('4732274X', 1, 1, 5);
insert into clientes (dni, vip, beneficios, volumen_compras) values ('7530357D',1, 2, 7);
insert into clientes (dni, vip, beneficios, volumen_compras) values ('5739473R',1, 1, 4);
insert into clientes (dni, vip, beneficios, volumen_compras) values ('2344248S',1,2,10);

insert into pedidos (dni, pedido, empleado) values ('4321124T', 1, 'Isa');
insert into pedidos (dni, pedido, empleado) values ('4732274X', 2, 'Maria');
insert into pedidos (dni, pedido, empleado) values ('7530357D', 3, 'Pablo');
insert into pedidos (dni, pedido, empleado) values ('5739473R', 4, 'Juan');
insert into pedidos (dni, pedido, empleado) values ('2344248S', 5, 'Luis');





SELECT *
FROM VIVEROS;

SELECT *
FROM PRODUCTOS;

SELECT *
FROM EMPLEADOS;

SELECT *
FROM ZONAS;

SELECT *
FROM PEDIDOS;

SELECT *
FROM CLIENTES;









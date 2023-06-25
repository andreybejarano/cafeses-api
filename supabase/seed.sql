-- Roles
insert into
public.roles (name, slug)
values
('Administrator', 'admin'),
('User', 'user'),
('Originator', 'originator');

-- Countries
insert into 
public.countries 
values
(1, 'Brazil', 'BRA'),
(2, 'Colombia', 'COL'),
(3, 'Vietnam', 'VNM');

-- Regions
insert into 
public.regions (id, name, countries_id)
values
(1, 'Antioquia', 1),
(2, 'Boyacá', 1),
(3, 'Caldas', 1),
(4, 'Caquetá', 1),
(5, 'Casanare', 1),
(6, 'Cauca', 1),
(7, 'Cesar', 1),
(8, 'Cundinamarca', 1),
(9, 'Huila', 1),
(10, 'La Guajira', 1),
(11, 'Magdalena', 1),
(12, 'Meta', 1),
(13, 'Nariño', 1),
(14, 'Norte de Santander', 1),
(15, 'Quindío', 1),
(16, 'Risaralda', 1),
(17, 'Santander', 1),
(18, 'Tolima', 1),
(19, 'Valle del Cauca', 1),
(20, 'Sul de Minas', 2),
(21, 'Cerrado de Minas', 2),
(22, 'Chapada de Minas', 2),
(23, 'Matas de Minas', 2),
(24, 'Mogiana', 2),
(25, 'Centro-Oeste de São Paulo', 2),
(26, 'Montanhas do Espírito Santo', 2),
(27, 'Conilon Capixaba', 2),
(28, 'Cerrado y Planalto da Bahía', 2),
(29, 'Atlantico Baiano', 2),
(30, 'Paraná', 2),
(31, 'Rondonia', 2),
(32, 'Dak Lak', 3),
(33, 'Lam Dong', 3),
(34, 'Gia Lai', 3),
(35, 'Kon Tum', 3),
(36, 'Ho Chi Minh', 3),
(37, 'Son La', 3),
(38, 'Thanh Hoa', 3),
(39, 'Quang Tri', 3);

-- Seeds
insert into 
public.seeds(name)
values
('Arabica'),
('Canephora'),
('Liberica'),
('Dewevrei(Excelsa)');
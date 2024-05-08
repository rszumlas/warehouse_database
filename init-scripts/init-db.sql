CREATE TABLE IF NOT EXISTS Person_types
(
    person_type_id BIGSERIAL PRIMARY KEY,
    type           VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS Persons
(
    person_id       BIGSERIAL PRIMARY KEY,
    person_type_id  BIGINT       NOT NULL,
    first_name      VARCHAR(50)  NOT NULL,
    last_name       VARCHAR(50)  NOT NULL,
    city            VARCHAR(100) NOT NULL,
    state           VARCHAR(100) NOT NULL,
    postal_code     VARCHAR(10)  NOT NULL,
    street          VARCHAR(255) NOT NULL,
    building_number VARCHAR(10)  NOT NULL,
    flat_number     VARCHAR(10),
    country         VARCHAR(100) NOT NULL,
    phone_number    VARCHAR(30),
    email           VARCHAR(255),
    FOREIGN KEY (person_type_id) REFERENCES Person_types (person_type_id)
);

CREATE TABLE IF NOT EXISTS Order_statuses
(
    order_status_id BIGSERIAL PRIMARY KEY,
    status          VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS Shipment_types
(
    shipment_type_id BIGSERIAL PRIMARY KEY,
    type             VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS Products
(
    product_id      BIGSERIAL PRIMARY KEY,
    name            VARCHAR(255) NOT NULL,
    manufacturer    VARCHAR(255),
    expiration_date DATE,
    production_date DATE,
    origin_country  VARCHAR(255),
    price           MONEY
);

CREATE TABLE IF NOT EXISTS Orders
(
    order_id         BIGSERIAL PRIMARY KEY,
    person_id        BIGINT    NOT NULL,
    shipment_type_id BIGINT    NOT NULL,
    product_id       BIGINT    NOT NULL,
    depart_date      DATE      NOT NULL,
    created_at       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (person_id) REFERENCES Persons (person_id),
    FOREIGN KEY (shipment_type_id) REFERENCES Shipment_types (shipment_type_id),
    FOREIGN KEY (product_id) REFERENCES Products (product_id)
);

CREATE TABLE IF NOT EXISTS Orders_order_statuses
(
    order_id        BIGINT    NOT NULL,
    order_status_id BIGINT    NOT NULL,
    created_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (order_id, order_status_id),
    FOREIGN KEY (order_id) REFERENCES Orders (order_id),
    FOREIGN KEY (order_status_id) REFERENCES Order_statuses (order_status_id)
);

-- DANE TESTOWE

INSERT INTO Person_types (type) VALUES ('KLIENT'), ('PRACOWNIK');

INSERT INTO Order_statuses (status) VALUES ('Nowe zamówienie'),('W realizacji'),('Wysłane'),('Dostarczone'),('Zwrot'),('Anulowane');

INSERT INTO Shipment_types (type) VALUES ('Standard'), ('Ekspres'), ('Odbiór osobisty'), ('Międzynarodowy');

INSERT INTO Persons (person_type_id, first_name, last_name, city, state, postal_code, street, building_number, country, phone_number, email) VALUES
(1, 'Marek', 'Zieliński', 'Gdańsk', 'Pomorskie', '80-001', 'Długa', '15', 'Polska', '111222333', 'marek.zielinski@example.com'),
(1, 'Monika', 'Borowik', 'Poznań', 'Wielkopolskie', '61-001', 'Półwiejska', '20', 'Polska', '222333444', 'monika.borowik@example.com'),
(2, 'Tomasz', 'Nowak', 'Wrocław', 'Dolnośląskie', '50-001', 'Oławska', '25', 'Polska', '333444555', 'tomasz.nowak@example.com'),
(2, 'Julia', 'Kowalczyk', 'Szczecin', 'Zachodniopomorskie', '70-001', 'Kwiatowa', '30', 'Polska', '444555666', 'julia.kowalczyk@example.com'),
(1, 'Łukasz', 'Wójcik', 'Lublin', 'Lubelskie', '20-001', 'Krakowskie Przedmieście', '40', 'Polska', '555666777', 'lukasz.wojcik@example.com'),
(1, 'Katarzyna', 'Kaczmarek', 'Katowice', 'Śląskie', '40-001', '3 Maja', '50', 'Polska', '666777888', 'katarzyna.kaczmarek@example.com'),
(2, 'Piotr', 'Kwiatkowski', 'Rzeszów', 'Podkarpackie', '35-001', 'Graniczna', '60', 'Polska', '777888999', 'piotr.kwiatkowski@example.com'),
(2, 'Agnieszka', 'Mazur', 'Kielce', 'Świętokrzyskie', '25-001', 'Sienkiewicza', '70', 'Polska', '888999111', 'agnieszka.mazur@example.com'),
(1, 'Michał', 'Czerwiński', 'Olsztyn', 'Warmińsko-Mazurskie', '10-001', 'Prosta', '80', 'Polska', '999111222', 'michal.czerwinski@example.com'),
(1, 'Barbara', 'Sikorska', 'Białystok', 'Podlaskie', '15-001', 'Zwycięstwa', '90', 'Polska', '111222333', 'barbara.sikorska@example.com');

INSERT INTO Products (name, manufacturer, expiration_date, production_date, origin_country, price) VALUES
('Jogurt naturalny', 'Mlekowita', '2024-12-01', '2023-12-01', 'Polska', '$0.60'),
('Ser biały', 'Polmlek', '2024-12-15', '2023-11-15', 'Polska', '$1.20'),
('Masło ekstra', 'Łaciate', '2024-11-01', '2023-10-01', 'Polska', '$1.50'),
('Kawa mielona', 'Jacobs', '2026-01-01', '2023-01-01', 'Niemcy', '$4.99'),
('Herbata czarna', 'Lipton', '2027-01-01', '2023-02-01', 'Wielka Brytania', '$3.50'),
('Sok pomarańczowy', 'Tymbark', '2024-05-01', '2023-04-01', 'Polska', '$2.00'),
('Czekolada mleczna', 'Wedel', '2025-03-01', '2023-03-01', 'Polska', '$1.30'),
('Pasta do zębów', 'Colgate', '2028-04-01', '2023-04-01', 'USA', '$2.50'),
('Szynka wędzona', 'Sokołów', '2024-02-01', '2023-01-01', 'Polska', '$5.00'),
('Płatki owsiane', 'Nestle', '2024-10-01', '2023-09-01', 'USA', '$3.00');

INSERT INTO Orders (person_id, shipment_type_id, product_id, depart_date, created_at) VALUES
(3, 1, 3, '2023-12-10', '2023-12-01 08:15:00'),
(4, 2, 4, '2023-12-11', '2023-12-01 08:30:00'),
(5, 3, 5, '2023-12-12', '2023-12-01 08:45:00'),
(6, 1, 6, '2023-12-13', '2023-12-01 09:00:00'),
(6, 1, 6, '2023-12-13', '2023-12-01 09:00:00'),
(7, 2, 7, '2023-12-14', '2023-12-01 09:15:00'),
(8, 3, 8, '2023-12-15', '2023-12-01 09:30:00'),
(9, 1, 9, '2023-12-16', '2023-12-01 09:45:00'),
(7, 2, 7, '2023-12-14', '2023-12-01 09:15:00'),
(8, 3, 8, '2023-12-15', '2023-12-01 09:30:00'),
(9, 1, 9, '2023-12-16', '2023-12-01 09:45:00'),
(10, 2, 10, '2023-12-17', '2023-12-01 10:00:00'),
(3, 3, 1, '2023-12-18', '2023-12-01 10:15:00'),
(9, 1, 9, '2023-12-16', '2023-12-01 09:45:00'),
(3, 3, 1, '2023-12-18', '2023-12-01 10:15:00'),
(9, 1, 9, '2023-12-16', '2023-12-01 09:45:00'),
(10, 2, 10, '2023-12-17', '2023-12-01 10:00:00'),
(3, 3, 1, '2023-12-18', '2023-12-01 10:15:00'),
(10, 2, 10, '2023-12-17', '2023-12-01 10:00:00'),
(3, 3, 1, '2023-12-18', '2023-12-01 10:15:00'),
(6, 1, 2, '2023-12-19', '2023-12-01 10:30:00'),
(7, 2, 7, '2023-12-14', '2023-12-01 09:15:00'),
(7, 2, 7, '2023-12-14', '2023-12-01 09:15:00'),
(8, 3, 8, '2023-12-15', '2023-12-01 09:30:00'),
(9, 1, 9, '2023-12-16', '2023-12-01 09:45:00'),
(10, 2, 10, '2023-12-17', '2023-12-01 10:00:00'),
(8, 3, 8, '2023-12-15', '2023-12-01 09:30:00'),
(9, 1, 9, '2023-12-16', '2023-12-01 09:45:00'),
(10, 2, 10, '2023-12-17', '2023-12-01 10:00:00'),
(3, 3, 1, '2023-12-18', '2023-12-01 10:15:00'),
(6, 1, 2, '2023-12-19', '2023-12-01 10:30:00'),
(10, 2, 10, '2023-12-17', '2023-12-01 10:00:00'),
(3, 3, 1, '2023-12-18', '2023-12-01 10:15:00'),
(6, 1, 2, '2023-12-19', '2023-12-01 10:30:00');

INSERT INTO Orders_order_statuses (order_id, order_status_id, created_at) VALUES
(6, 5, '2023-12-13 09:15:00'),
(6, 6, '2023-12-13 09:15:00'),
(7, 5, '2023-12-14 09:30:00'),
(7, 6, '2023-12-14 09:30:00'),
(8, 5, '2023-12-15 09:45:00'),
(8, 6, '2023-12-15 09:45:00'),
(9, 5, '2023-12-16 10:00:00'),
(9, 6, '2023-12-16 10:00:00'),
(10, 5, '2023-12-17 10:15:00'),
(10, 6, '2023-12-17 10:15:00'),
(1, 2, '2023-12-02 08:30:00'),
(2, 3, '2023-12-03 09:00:00'),
(4, 4, '2023-12-04 10:15:00'),
(5, 2, '2023-12-05 11:00:00'),
(11, 3, '2023-12-06 12:45:00'),
(12, 4, '2023-12-07 13:30:00'),
(13, 2, '2023-12-08 14:15:00'),
(14, 3, '2023-12-09 15:00:00'),
(15, 4, '2023-12-10 15:45:00'),
(16, 2, '2023-12-11 16:30:00');

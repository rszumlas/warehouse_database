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

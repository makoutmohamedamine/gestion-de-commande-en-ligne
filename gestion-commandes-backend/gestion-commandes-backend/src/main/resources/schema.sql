-- Script de création du schéma de la base de données faouziaexpress
-- Ce script crée la base de données et toutes les tables nécessaires

-- Créer la base de données si elle n'existe pas
CREATE DATABASE IF NOT EXISTS faouziaexpress;
USE faouziaexpress;

-- Créer la table users
CREATE TABLE users (
    user_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone_number VARCHAR(20),
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL
);

-- Créer la table addresses
CREATE TABLE addresses (
    address_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT,
    street VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    country VARCHAR(50) NOT NULL,
    latitude DECIMAL(10, 7) NOT NULL,
    longitude DECIMAL(10, 7) NOT NULL,
    details TEXT,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE SET NULL
);

-- Créer la table partners
CREATE TABLE partners (
    partner_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    partner_type VARCHAR(50) NOT NULL,
    address_id BIGINT NOT NULL,
    admin_user_id BIGINT NOT NULL,
    average_rating DECIMAL(2, 1),
    is_active BOOLEAN,
    FOREIGN KEY (address_id) REFERENCES addresses(address_id) ON DELETE CASCADE,
    FOREIGN KEY (admin_user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Créer la table products
CREATE TABLE products (
    product_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    partner_id BIGINT NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    category VARCHAR(100),
    is_available BOOLEAN,
    FOREIGN KEY (partner_id) REFERENCES partners(partner_id) ON DELETE CASCADE
);

-- Créer la table couriers
CREATE TABLE couriers (
    courier_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    transport_type VARCHAR(50) NOT NULL,
    availability_status VARCHAR(50) NOT NULL,
    current_latitude DECIMAL(10, 7),
    current_longitude DECIMAL(10, 7),
    average_rating DECIMAL(2, 1),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Créer la table orders
CREATE TABLE orders (
    order_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    client_id BIGINT NOT NULL,
    partner_id BIGINT NOT NULL,
    courier_id BIGINT,
    delivery_address_id BIGINT NOT NULL,
    order_date DATETIME NOT NULL,
    status VARCHAR(50) NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    delivery_fee DECIMAL(10, 2) NOT NULL,
    estimated_delivery_time DATETIME,
    FOREIGN KEY (client_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (partner_id) REFERENCES partners(partner_id) ON DELETE CASCADE,
    FOREIGN KEY (courier_id) REFERENCES couriers(courier_id) ON DELETE SET NULL,
    FOREIGN KEY (delivery_address_id) REFERENCES addresses(address_id) ON DELETE CASCADE
);

-- Créer la table order_items
CREATE TABLE order_items (
    order_item_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    notes TEXT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);

-- Index pour optimiser les requêtes
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_orders_client_id ON orders(client_id);
CREATE INDEX idx_orders_partner_id ON orders(partner_id);
CREATE INDEX idx_orders_status ON orders(status);
CREATE INDEX idx_products_partner_id ON products(partner_id);
CREATE INDEX idx_products_category ON products(category);
CREATE INDEX idx_order_items_order_id ON order_items(order_id);
CREATE INDEX idx_order_items_product_id ON order_items(product_id);

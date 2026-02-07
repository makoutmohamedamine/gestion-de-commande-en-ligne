-- Script SQL pour initialiser la base de données faouziaexpress
-- Ce script crée toutes les tables nécessaires pour le système de gestion de commandes

-- Supprimer les tables si elles existent (pour tests)
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS couriers;
DROP TABLE IF EXISTS addresses;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS partners;
DROP TABLE IF EXISTS users;

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

-- Insertion de données de test

-- Utilisateurs
INSERT INTO users (first_name, last_name, email, phone_number, password_hash, role, created_at, updated_at) VALUES
('Admin', 'User', 'admin@faouziaexpress.com', '+212600000000', 'admin123', 'admin', NOW(), NOW()),
('Client', 'One', 'client1@faouziaexpress.com', '+212600000001', 'client123', 'client', NOW(), NOW()),
('Partner', 'Admin', 'partner@faouziaexpress.com', '+212600000002', 'partner123', 'partner_admin', NOW(), NOW()),
('Courier', 'One', 'courier1@faouziaexpress.com', '+212600000003', 'courier123', 'courier', NOW(), NOW());

-- Adresses
INSERT INTO addresses (user_id, street, city, postal_code, country, latitude, longitude, details) VALUES
(1, 'Rue Mohammed V', 'Casablanca', '20000', 'Maroc', 33.5731, -7.5898, 'Bureau principal'),
(2, 'Avenue Hassan II', 'Casablanca', '20000', 'Maroc', 33.5947, -7.6212, 'Domicile'),
(3, 'Boulevard Zerktouni', 'Casablanca', '20000', 'Maroc', 33.5879, -7.6045, 'Bureau partenaire');

-- Partenaires
INSERT INTO partners (name, description, partner_type, address_id, admin_user_id, average_rating, is_active) VALUES
('Restaurant La Médina', 'Restaurant traditionnel marocain', 'restaurant', 3, 3, 4.5, TRUE);

-- Produits
INSERT INTO products (partner_id, name, description, price, category, is_available) VALUES
(1, 'Couscous Royal', 'Couscous aux sept légumes et viande', 80.00, 'Plat principal', TRUE),
(1, 'Tajine poulet', 'Tajine aux olives et citron confit', 75.00, 'Plat principal', TRUE),
(1, 'Salade marocaine', 'Salade de tomates, concombres et poivrons', 25.00, 'Entrée', TRUE),
(1, 'Thé à la menthe', 'Thé traditionnel marocain', 15.00, 'Boisson', TRUE);

-- Couriers
INSERT INTO couriers (user_id, transport_type, availability_status, current_latitude, current_longitude, average_rating) VALUES
(4, 'scooter', 'available', 33.5731, -7.5898, 4.7);

-- Commandes
INSERT INTO orders (client_id, partner_id, courier_id, delivery_address_id, order_date, status, total_amount, delivery_fee, estimated_delivery_time) VALUES
(2, 1, 1, 2, NOW(), 'delivered', 180.00, 20.00, DATE_ADD(NOW(), INTERVAL 30 MINUTE));

-- Items de commande
INSERT INTO order_items (order_id, product_id, quantity, unit_price, notes) VALUES
(1, 1, 1, 80.00, 'Sans oignons'),
(1, 2, 1, 75.00, 'Bien épicé'),
(1, 3, 1, 25.00, '');

-- Vérifier les données insérées
SELECT 'Users count:', COUNT(*) FROM users;
SELECT 'Addresses count:', COUNT(*) FROM addresses;
SELECT 'Partners count:', COUNT(*) FROM partners;
SELECT 'Products count:', COUNT(*) FROM products;
SELECT 'Couriers count:', COUNT(*) FROM couriers;
SELECT 'Orders count:', COUNT(*) FROM orders;
SELECT 'Order items count:', COUNT(*) FROM order_items;

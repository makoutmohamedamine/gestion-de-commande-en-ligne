CREATE DATABASE IF NOT EXISTS ecommerce_poo;
USE ecommerce_poo;

-- Table des utilisateurs
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin', 'vendeur', 'client') DEFAULT 'client',
    telephone VARCHAR(20),
    adresse TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table des articles
CREATE TABLE articles (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(255) NOT NULL,
    description TEXT,
    prix DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    type ENUM('physique', 'numerique') NOT NULL,
    url_telechargement VARCHAR(500),
    vendeur_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (vendeur_id) REFERENCES users(id)
);

-- Table du panier
CREATE TABLE panier (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    article_id INT NOT NULL,
    quantite INT NOT NULL DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (article_id) REFERENCES articles(id),
    UNIQUE KEY unique_panier (user_id, article_id)
);

-- Table des commandes
CREATE TABLE commandes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    statut ENUM('en_attente', 'confirmee', 'expediee', 'livree', 'annulee') DEFAULT 'en_attente',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Table des articles de commande
CREATE TABLE commande_articles (
    id INT PRIMARY KEY AUTO_INCREMENT,
    commande_id INT NOT NULL,
    article_id INT NOT NULL,
    quantite INT NOT NULL,
    prix DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (commande_id) REFERENCES commandes(id),
    FOREIGN KEY (article_id) REFERENCES articles(id)
);

-- Codes de réduction
CREATE TABLE codes_reduction (
    id INT PRIMARY KEY AUTO_INCREMENT,
    code VARCHAR(50) UNIQUE NOT NULL,
    reduction DECIMAL(5,2) NOT NULL,
    utilisations_max INT DEFAULT 1,
    utilisations_actuelles INT DEFAULT 0,
    expire_at DATETIME,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insertion d'un admin par défaut
INSERT INTO users (nom, email, password, role) VALUES 
('Admin', 'admin@ecommerce.com', '$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin');
# Projet de Gestion de Commandes Backend

Ce projet est un backend Spring Boot pour une application de gestion de commandes. Il fournit des API REST pour gérer les utilisateurs, les produits, les commandes, les partenaires et les coursiers.

## Fonctionnalités

- **Gestion des utilisateurs** : Inscription et connexion des utilisateurs.
- **Gestion des produits** : CRUD pour les produits.
- **Gestion des commandes** : Création, consultation et mise à jour du statut des commandes.
- **Gestion des partenaires** : CRUD pour les partenaires.
- **Gestion des coursiers** : CRUD pour les coursiers.

## Technologies

- **Java 17**
- **Spring Boot 3**
- **Spring Data JPA**
- **Hibernate**
- **MySQL**
- **Maven**

## Configuration

1.  **Base de données** : Le projet est configuré pour utiliser une base de données MySQL. Vous pouvez modifier les informations de connexion dans le fichier `src/main/resources/application.properties`.

    ```properties
    spring.datasource.url=jdbc:mysql://localhost:3306/faouziaexpress?useSSL=false&serverTimezone=UTC
    spring.datasource.username=root
    spring.datasource.password=
    ```

2.  **Initialisation de la base de données** : Les scripts `schema.sql` et `data.sql` dans `src/main/resources` sont exécutés au démarrage de l'application pour créer le schéma de la base de données et insérer des données de test.

## Lancement

Pour lancer le projet, exécutez la commande suivante à la racine du projet :

```bash
./mvnw spring-boot:run
```

Le serveur sera accessible à l'adresse `http://localhost:8081`.

## API Endpoints

- `POST /api/auth/register` : Inscription d'un nouvel utilisateur.
- `POST /api/auth/login` : Connexion d'un utilisateur.
- `GET /api/products` : Lister tous les produits.
- `GET /api/products/{id}` : Obtenir un produit par son ID.
- `POST /api/products` : Créer un nouveau produit.
- `PUT /api/products/{id}` : Mettre à jour un produit.
- `DELETE /api/products/{id}` : Supprimer un produit.
- `GET /api/orders` : Lister toutes les commandes.
- `GET /api/orders/{id}` : Obtenir une commande par son ID.
- `POST /api/orders` : Créer une nouvelle commande.
- `PUT /api/orders/{id}/status` : Mettre à jour le statut d'une commande.

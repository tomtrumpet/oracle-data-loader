# Oracle Data Loader

Exploring loading data into Oracle using SQL*Loader and Exteral Tables.

### Dockerised Components

1. ~~`Product API` returning a large array of JSON objects, including base64 encoded images.~~
2. `Scheduled Job` to load product data from `Product API` into `Oracle Database` using SQL*Loader.
3. `Oracle Database` 12c.

### Setup Steps

1. Login in to Docker Hub using: `docker login`. This is needed to pull `https://hub.docker.com/_/oracle-database-enterprise-edition`

### Running

1. `docker-compose build`
2. `docker-compose up`

### Scheduled Job method 1 (SQL*Loader)

1. ~~The triggered `Scheduled Job` will fetch all products from the `Product API`.~~
2. ~~The returned result will be persisted to a JSON file.~~
3. Use SQL*Loader to load data file into staging table.
4. Use INSERT INTO SELECT FROM with /*+ APPEND */ query hint to load staging data into live table.

First attempt using static CSV file with SQL*Loader

#### Useful commands

`docker exec -it <oracle_container> sqlplus SYSTEM/Oradoc_db1@db:1521/ORCLCDB.localdomain`

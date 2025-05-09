# Design Database Schema (DDL)

## Objective

Write SQL queries to define the database schema (create tables, set constraints).

## Instructions

1. Based on the provided database specification, create SQL CREATE TABLE statements for each entity.

2. Ensure proper data types, primary keys, foreign keys, and constraints.

3. Create necessary indexes on columns for optimal performance.

## How to test schema using docker container

1. Pull the latest postgres image:

   ```bash
   docker pull postgres
   ```

2. Run a new container with the postgres image:

   ```bash
   docker run --name pst -e POSTGRES_PASSWORD=test -d postgres
    ```

3. Copy the SQL file to the container:

   ```bash
   docker cp <path_to_your_sql_file> pst:my_schema.sql
   ```

4. Connect to the container and run the SQL file:

   ```bash
   docker exec -i pst psql -U postgres -f ./my_schema.sql
   ```

5. Connect to the database:

   ```bash
    docker exec -it pst psql -U postgres
    ```

6. To see the list of tables

    ```sql
    \dt
    ```

7. To see the list of columns in a table

    ```sql
    \d <table_name>
    ```

8. To see the list of indexes in a table

    ```sql
    \di <table_name>
    ```

9. To see the list of constraints in a table

    ```sql
    \d <table_name>
    ```

10. Exit the container

    ```sql
    \q
    ```

11. Stop the container and remove it

    ```bash
    docker stop pst
    docker rm pst
    ```

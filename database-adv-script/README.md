# Write Complex Queries with Joins

## Objective

Master SQL joins by writing complex queries using different types of joins.

## Instructions

1. Write a query using an INNER JOIN to retrieve all bookings and the respective users who made those bookings.

2. Write a query using a LEFT JOIN to retrieve all properties and their reviews, including properties that have no reviews.

3. Write a query using a FULL OUTER JOIN to retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.

## How to test script using docker container

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
    docker cp ./database-script-0x01/my_schema.sql pst:my_schema.sql
    docker cp ./dabase-script-0x02/seed.sql pst:my_seed.sql
    docker cp ./database-adv-script/joins_queries.sql pst:joins_queries.sql
   ```

4. Connect to the container and run the SQL file:

   ```bash
    docker exec -i pst psql -U postgres -f ./my_schema.sql
    docker exec -i pst psql -U postgres -f ./my_seed.sql
    docker exec -i pst psql -U postgres -f ./joins_queries.sql
   ```

5. close and delete the container

   ```bash
    docker stop pst
    docker rm pst
   ```

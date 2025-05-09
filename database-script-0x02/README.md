# Seed the Database with Sample Data

## Objective

 Create SQL scripts to populate the database with sample data.

## Instructions

    1. Write SQL INSERT statements to add sample data for User, Property, Booking, etc.

    2. Ensure the sample data reflects real-world usage (e.g., multiple users, bookings, payments).

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
   docker cp <path_to_your_sql_file> pst:my_schema.sql
   ```

4. Connect to the container and run the SQL file:

   ```bash
   docker exec -i pst psql -U postgres -f ./my_schema.sql
   ```

5. close and delete the container

   ```bash
   docker stop pst
   docker rm pst
   ```

# Unleashing Advanced Querying Power

## write Complex Queries with Joins

### Objective

Master SQL joins by writing complex queries using different types of joins.

### Instructions

1. Write a query using an INNER JOIN to retrieve all bookings and the respective users who made those bookings.

2. Write a query using a LEFT JOIN to retrieve all properties and their reviews, including properties that have no reviews.

3. Write a query using a FULL OUTER JOIN to retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.

## Practice Subqueries

### Objective

Write both correlated and non-correlated subqueries.

### Instructions

1. Write a query to find all properties where the average rating is greater than 4.0 using a subquery.

2. Write a correlated subquery to find users who have made more than 3 bookings.

## Apply Aggregations and Window Functions

### Objective

Use SQL aggregation and window functions to analyze data.

### Instructions

1. Write a query to find the total number of bookings made by each user, using the COUNT function and GROUP BY clause.

2. Use a window function (ROW_NUMBER, RANK) to rank properties based on the total number of bookings they have received.

## Implement Indexes for Optimization

### Objective

Identify and create indexes to improve query performance.

### Instructions

1. Identify high-usage columns in your User, Booking, and Property tables (e.g., columns used in WHERE, JOIN, ORDER BY clauses).

2. Write SQL CREATE INDEX commands to create appropriate indexes for those columns and save them on database_index.sql

3. Measure the query performance before and after adding indexes using EXPLAIN or ANALYZE

## Optimize Complex Queries

### Objective

Refactor complex queries to improve performance.

### Instructions

1. Write an initial query that retrieves all bookings along with the user details, property details, and payment details and save it on perfomance.sql

2. Analyze the query’s performance using EXPLAIN and identify any inefficiencies.

3. Refactor the query to reduce execution time, such as reducing unnecessary joins or using indexing.

## Partitioning Large Tables

### Objective

Implement table partitioning to optimize queries on large datasets.

### Instructions

1. Assume the Booking table is large and query performance is slow. Implement partitioning on the Booking table based on the start_date column. Save the query in a file partitioning.sql

2. Test the performance of queries on the partitioned table (e.g., fetching bookings by date range).

3. Write a brief report on the improvements you observed.

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
    docker cp ./database-adv-script/<script you want test> pst:script.sql
   ```

4. Connect to the container and run the SQL file:

   ```bash
    docker exec -i pst psql -U postgres -f ./my_schema.sql
    docker exec -i pst psql -U postgres -f ./my_seed.sql
    docker exec -i pst psql -U postgres -f ./script.sql
   ```

5. close and delete the container

   ```bash
    docker stop pst
    docker rm pst
   ```

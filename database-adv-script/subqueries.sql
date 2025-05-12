-- a query to find all properties where the average rating is greater than 4.0 using a subquery.
SELECT p.id, p.name
FROM properties p
WHERE p.id IN (
    SELECT r.property_id
    FROM reviews r
    GROUP BY r.property_id
    HAVING AVG(r.rating) > 4.0
);

-- a correlated subquery to find users who have made more than 3 bookings.
SELECT u.id, u.first_name, u.last_name
FROM users u 
WHERE (
    SELECT COUNT(*)
    FROM bookings b
    WHERE b.user_id = u.id
) > 3; 
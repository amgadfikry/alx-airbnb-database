-- a query to find the total number of bookings made by each user, using the COUNT function and GROUP BY clause.
SELECT u.id, u.first_name, u.last_name, COUNT(b.id) AS total_bookings
FROM users u
LEFT JOIN bookings b
ON u.id = b.user_id
GROUP BY u.id, u.first_name, u.last_name;

-- a window function (ROW_NUMBER, RANK) to rank properties based on the total number of bookings they have received.
SELECT p.id, p.name, COUNT(b.id) AS total_bookings, RANK() OVER (ORDER BY COUNT(b.id) DESC) AS rank
FROM properties p
LEFT JOIN bookings b
ON p.id = b.property_id
GROUP BY p.id, p.name
ORDER BY rank;

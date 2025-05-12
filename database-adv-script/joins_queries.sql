-- Enable extension of analyze performance
CREATE EXTENSION IF NOT EXISTS "pg_stat_statements";

-- query using an INNER JOIN to retrieve all bookings and the respective users who made those bookings.

SELECT b.id, b.date_in, b.date_out, b.total_price, u.first_name, u.last_name, u.email
FROM bookings b
INNER JOIN users u
ON b.user_id = u.id;

-- query using aLEFT JOIN to retrieve all properties and their reviews, including properties that have no reviews.
SELECT p.id, p.name, r.rating, r.comment
FROM properties p
LEFT JOIN reviews r
ON p.id = r.property_id
ORDER BY p.id;

-- query using a FULL OUTER JOIN to retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.
SELECT u.id, u.first_name, u.last_name, b.id, b.date_in, b.date_out, b.total_price
FROM users u
FULL JOIN bookings b
ON u.id = b.user_id;

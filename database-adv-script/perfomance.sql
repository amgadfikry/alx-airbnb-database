-- Query that retrieves all bookings along with the user details, property details, and payment details

EXPLAIN ANALYZE
SELECT b.id, u.first_name, u.last_name, p.name, p.type, py.payment_method, py.status
FROM bookings b
INNER JOIN users u ON b.user_id = u.id
INNER JOIN properties p ON b.property_id = p.id
INNER JOIN payments py ON b.id = py.booking_id
WHERE b.status = 'confirmed'
    AND py.status = 'completed'
ORDER BY b.id;
S
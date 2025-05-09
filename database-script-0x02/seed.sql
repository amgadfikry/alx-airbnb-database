DO $$
DECLARE
    guest_id UUID;
    host_id UUID;
    admin_id UUID;
    property1_id UUID;
    property2_id UUID;
    booking1_id UUID;
    booking2_id UUID;
    payment1_id UUID;
    payment2_id UUID;
BEGIN
    -- Insert users with different roles
    INSERT INTO users (first_name, last_name, email, password_hash, role)
    VALUES
    ('John', 'Doe', 'guest1@example.com', 'hash1', 'guest'),
    ('Jane', 'Smith', 'host1@example.com', 'hash2', 'host'),
    ('Alice', 'Adams', 'admin1@example.com', 'hash3', 'admin');
    
    -- GET the IDs of the inserted users
    SELECT user_id INTO guest_id FROM users WHERE email = 'guest1@example.com';
    SELECT user_id INTO host_id FROM users WHERE email = 'host1@example.com';
    SELECT user_id INTO admin_id FROM users WHERE email = 'admin1@example.com';

    -- Insert properties for the host
    INSERT INTO properties (host_id, name, description, location, pricepernight)
    VALUES
    (host_id, 'Lovely Cottage', 'A lovely cottage in the countryside', 'Countryside', 120.00),
    (host_id, 'Modern Apartment', 'A modern apartment in the city center', 'City Center', 200.00);
    
    -- GET the IDs of the inserted properties
    SELECT property_id INTO property1_id FROM properties WHERE name = 'Lovely Cottage';
    SELECT property_id INTO property2_id FROM properties WHERE name = 'Modern Apartment';

    -- Insert bookings for the guest
    INSERT INTO bookings (property_id, user_id, start_date, end_date, total_price, status)
    VALUES
    (property1_id, guest_id, '2025-05-10', '2025-05-15', 600.00, 'confirmed'),
    (property2_id, guest_id, '2025-06-01', '2025-06-05', 800.00, 'pending');
    
    -- GET the IDs of the inserted bookings
    SELECT booking_id INTO booking1_id FROM bookings WHERE property_id = property1_id AND user_id = guest_id;
    SELECT booking_id INTO booking2_id FROM bookings WHERE property_id = property2_id AND user_id = guest_id;

    -- Insert payments for the bookings
    INSERT INTO payments (booking_id, amount, payment_method)
    VALUES
    (booking1_id, 600.00, 'credit_card'),
    (booking2_id, 800.00, 'paypal');
    
    -- GET the IDs of the inserted payments
    SELECT payment_id INTO payment1_id FROM payments WHERE booking_id = booking1_id;
    SELECT payment_id INTO payment2_id FROM payments WHERE booking_id = booking2_id;

    -- Insert reviews for the properties
    INSERT INTO reviews (property_id, user_id, rating, comment)
    VALUES
    (property1_id, guest_id, 5, 'Amazing stay! Highly recommend.'),
    (property2_id, guest_id, 4, 'Very comfortable and clean.');

    -- Insert messages between users
    INSERT INTO messages (sender_id, recipient_id, message_body)
    VALUES
    (guest_id, host_id, 'Hello, I am interested in booking your property.'),
    (host_id, guest_id, 'Thank you for your interest in our property.');
END;
$$ LANGUAGE plpgsql;

-- Test users with roles
SELECT u.user_id, u.first_name, u.role
FROM users u;

-- Test properties linked to the host
SELECT p.property_id, p.name, p.host_id
FROM properties p;

-- Test bookings
SELECT b.booking_id, b.property_id, b.user_id, b.status
FROM bookings b;

-- Test payments
SELECT pm.payment_id, pm.amount, pm.booking_id
FROM payments pm;

-- Test reviews
SELECT r.review_id, r.rating, r.comment
FROM reviews r;

-- Test messages
SELECT m.message_id, m.message_body
FROM messages m;

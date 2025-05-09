-- queries to insert multiple data into the database schema


DO $$
DECLARE
    guest_role_id INT;
    host_role_id INT;
    guest1_id INT;
    guest2_id INT;
    host_id INT;
    property1_id INT;
    property2_id INT;
    amenity1_id INT;
    amenity2_id INT;
    booking1_id INT;
    booking2_id INT;
BEGIN
    -- add host and guest roles to roles table
    INSERT INTO roles (role_name, description)
    VALUES
    ('guest', 'A user who can book a property'),
    ('host', 'A user who can list a property');

    -- create 2 users as guests and 1 as host
    INSERT INTO users (email, first_name, last_name, password, phone_number)
    VALUES
    ('guest1@email.com', 'guest1', 'Doe2', 'password123', '1234567890'),
    ('guest2@email.com', 'guest1', 'Doe2', 'password123', '1234567890'),
    ('host@email.com', 'host1', 'Doe2', 'password123', '1234567890');

    -- Get the IDs of the roles
    SELECT id INTO guest_role_id FROM roles WHERE role_name = 'guest';
    SELECT id INTO host_role_id FROM roles WHERE role_name = 'host';
    SELECT id INTO guest1_id FROM users WHERE email = 'guest1@email.com';
    SELECT id INTO guest2_id FROM users WHERE email = 'guest2@email.com';
    SELECT id INTO host_id FROM users WHERE email = 'host@email.com';

    -- Assign roles to users
    INSERT INTO user_roles (user_id, role_id)
    VALUES
        (guest1_id, guest_role_id),
        (guest2_id, guest_role_id),
        (host_id, host_role_id);

    -- add users address to them with dummy data
    INSERT INTO user_addresses (user_id, street, city, state, postal_code, country)
    VALUES
        (guest1_id, '123 Main St', 'New York', 'NY', '10001', 'USA'),
        (guest2_id, '456 Elm St', 'Los Angeles', 'CA', '90001', 'USA'),
        (host_id, '789 Oak St', 'Chicago', 'IL', '60601', 'USA');

    -- add payment method to them with dummy data
    INSERT INTO payment_methods (user_id, card_number, card_type, card_name, expiration_date)
    VALUES
        (guest1_id, '4111111111111111', 'Visa', 'John Doe', '2025-12-31'),
        (guest2_id, '5500000000000004', 'MasterCard', 'Jane Doe', '2026-11-30'),
        (host_id, '340000000000009', 'American Express', 'Host User', '2024-10-31');

    -- Create messages between users guest1 and host
    INSERT INTO messages (sender_id, receiver_id, message)
    VALUES
        (guest1_id, host_id, 'Hello, I am interested in your property.'),
        (host_id, guest1_id, 'Hi! Thank you for your interest.'),
        (guest2_id, host_id, 'Can you provide more details about the property?'),
        (host_id, guest2_id, 'Sure! I will send you the details shortly.');

    -- Create properties for the host with dummy data
    INSERT INTO properties (owner_id, name, price, description, type, bathrooms, bedrooms, max_guests)
    VALUES
        (host_id, 'Cozy Apartment', 150.00, 'A cozy apartment in the city center.', 'apartment', 1, 2, 4),
        (host_id, 'Luxury Villa', 300.00, 'A luxury villa with a pool.', 'villa', 3, 5, 10);

    -- Get the IDs of the properties
    SELECT id INTO property1_id FROM properties WHERE name = 'Cozy Apartment';
    SELECT id INTO property2_id FROM properties WHERE name = 'Luxury Villa';

    -- Add property rules for the properties
    INSERT INTO property_rules (property_id, smooking, pets, parties, children, check_in_time, check_out_time, cancelation_policy)
    VALUES
        (property1_id, TRUE, FALSE, FALSE, TRUE, '14:00', '11:00', 'flexible'),
        (property2_id, FALSE, TRUE, TRUE, FALSE, '15:00', '10:00', 'strict');

    -- add property addresses to them with dummy data
    INSERT INTO property_addresses (property_id, street, city, state, postal_code, country, latitude, longitude)
    VALUES
        (property1_id, '123 Main St', 'New York', 'NY', '10001', 'USA', 40.7128, -74.0060),
        (property2_id, '456 Elm St', 'Los Angeles', 'CA', '90001', 'USA', 34.0522, -118.2437);

    -- add property images to them with dummy data
    INSERT INTO property_photos (property_id, photo_url, type)
    VALUES
        (property1_id, 'http://example.com/photo1.jpg', 'main'),
        (property1_id, 'http://example.com/photo2.jpg', 'gallery'),
        (property2_id, 'http://example.com/photo3.jpg', 'main'),
        (property2_id, 'http://example.com/photo4.jpg', 'gallery');

    -- add amenties to the properties with dummy data
    INSERT INTO amenities (name, icon)
    VALUES
        ('WiFi', 'http://example.com/icon1.png'),
        ('Pool', 'http://example.com/icon2.png');

    -- Get the IDs of the amenities
    SELECT id INTO amenity1_id FROM amenities WHERE name = 'WiFi';
    SELECT id INTO amenity2_id FROM amenities WHERE name = 'Pool';

    -- add property amenities to them with dummy data
    INSERT INTO property_amenities (property_id, amenity_id)
    VALUES
        (property1_id, amenity1_id),
        (property1_id, amenity2_id),
        (property2_id, amenity1_id),
        (property2_id, amenity2_id);

    -- add property claender for 14 days with dummy data
    FOR i IN 1..14 LOOP
        INSERT INTO property_calendar (property_id, date, price)
        VALUES
            (property1_id, CURRENT_DATE + i, 150.00),
            (property2_id, CURRENT_DATE + i, 300.00);
    END LOOP;

    -- add reviews for the properties with dummy data
    INSERT INTO reviews (property_id, user_id, rating, comment)
    VALUES
        (property1_id, guest1_id, 4.5, 'Great place!'),
        (property1_id, guest2_id, 5.0, 'Loved it!'),
        (property2_id, guest1_id, 3.5, 'It was okay.'),
        (property2_id, guest2_id, 4.0, 'Nice experience.');

    -- add bookings for the properties with dummy data
    INSERT INTO bookings (property_id, user_id, date_in, date_out, total_price)
    VALUES
        (property1_id, guest1_id, CURRENT_DATE + 1, CURRENT_DATE + 5, 600.00),
        (property2_id, guest2_id, CURRENT_DATE + 2, CURRENT_DATE + 6, 1200.00);

    -- Get the IDs of the bookings
    SELECT id INTO booking1_id FROM bookings WHERE property_id = property1_id AND user_id = guest1_id;
    SELECT id INTO booking2_id FROM bookings WHERE property_id = property2_id AND user_id = guest2_id;

    -- add payment to payments table successfully then update the booking status
    INSERT INTO payments (booking_id, amount, payment_method, status, transaction_id)
    VALUES
        (booking1_id, 600.00, (SELECT id FROM payment_methods WHERE user_id = guest1_id), 'completed', 'txn_123456');
    UPDATE bookings SET status = 'confirmed' WHERE id = booking1_id;

    -- add payment to payments table failed then update the booking status
    INSERT INTO payments (booking_id, amount, payment_method, status, transaction_id)
    VALUES
        (booking2_id, 1200.00, (SELECT id FROM payment_methods WHERE user_id = guest2_id), 'failed', 'txn_654321');
    UPDATE bookings SET status = 'cancelled' WHERE id = booking2_id;
END;
$$ LANGUAGE plpgsql;

-- test the data inserted
-- select all user
SELECT * FROM users;
-- select all roles
SELECT
    u.id AS user_id,
    u.first_name,
    u.last_name,
    u.email,
    r.role_name
FROM
    users u
JOIN
    user_roles ur ON u.id = ur.user_id
JOIN
    roles r ON ur.role_id = r.id;

-- select user with their addresses`
SELECT u.email, ua.street, ua.city, ua.state, ua.postal_code, ua.country
FROM users u
JOIN user_addresses ua ON u.id = ua.user_id;

-- select all messages with their sender and receiver
SELECT m.*, u1.first_name AS sender_first_name, u2.first_name AS receiver_first_name
FROM messages m
JOIN users u1 ON m.sender_id = u1.id
JOIN users u2 ON m.receiver_id = u2.id;

-- select all payment methods with their users
SELECT pm.*, u.first_name, u.last_name
FROM payment_methods pm
JOIN users u ON pm.user_id = u.id;

-- select all properties
SELECT * FROM properties;

-- select all property photos with their properties
SELECT pp.*, p.name AS property_name
FROM property_photos pp
JOIN properties p ON pp.property_id = p.id;

-- select all property calendars with their properties
SELECT pc.*, p.name AS property_name
FROM property_calendar pc
JOIN properties p ON pc.property_id = p.id;

-- select all property rules with their properties
SELECT pr.*, p.name AS property_name
FROM property_rules pr
JOIN properties p ON pr.property_id = p.id;

-- select all property amenities with their properties
SELECT pa.*, p.name AS property_name, a.name AS amenity_name
FROM property_amenities pa
JOIN properties p ON pa.property_id = p.id
JOIN amenities a ON pa.amenity_id = a.id;

-- select all property addresses with their properties
SELECT pa.*, p.name AS property_name
FROM property_addresses pa
JOIN properties p ON pa.property_id = p.id;

-- select all bookings with payments and their status
SELECT b.*, p.*
FROM bookings b
JOIN payments p ON b.id = p.booking_id;

-- select all reviews with their properties and users
SELECT * FROM reviews;
    
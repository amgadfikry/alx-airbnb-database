-- PostgreSQL script to create a database schema
-- create users table
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    profile_image VARCHAR(255),
    is_verified BOOLEAN DEFAULT FALSE,
    verified_at TIMESTAMP DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- create user_addresses table
CREATE TABLE IF NOT EXISTS user_addresses (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    street VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    country VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- create index IF NOT EXISTS of user_addresses user_id
CREATE INDEX IF NOT EXISTS idx_user_addresses_user_id ON user_addresses(user_id);

-- create payment_methods table
CREATE TABLE IF NOT EXISTS payment_methods (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    card_number VARCHAR(20) NOT NULL,
    card_type VARCHAR(50) NOT NULL,
    card_name VARCHAR(100) NOT NULL,
    expiration_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- create index IF NOT EXISTS of payment_methods user_id
CREATE INDEX IF NOT EXISTS idx_payment_methods_user_id ON payment_methods(user_id);

-- create messages table
CREATE TABLE IF NOT EXISTS messages (
    id SERIAL PRIMARY KEY,
    sender_id INT NOT NULL,
    receiver_id INT NOT NULL,
    message TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (receiver_id) REFERENCES users(id) ON DELETE CASCADE
);

-- create index IF NOT EXISTS of messages sender_id and receiver_id
CREATE INDEX IF NOT EXISTS idx_messages_sender_id ON messages(sender_id);
CREATE INDEX IF NOT EXISTS idx_messages_receiver_id ON messages(receiver_id);

-- create roles table IF NOT EXISTS
CREATE TABLE IF NOT EXISTS roles (
    id SERIAL PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT
);

-- create user_roles table IF NOT EXISTS
CREATE TABLE IF NOT EXISTS user_roles (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    role_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (role_id) REFERENCES roles(id)
);

-- create index IF NOT EXISTS of user_roles user_id with unique constraint
CREATE UNIQUE INDEX IF NOT EXISTS idx_user_roles_unique ON user_roles(user_id, role_id);

-- create properties table IF NOT EXISTS
CREATE TABLE IF NOT EXISTS properties (
    id SERIAL PRIMARY KEY,
    owner_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    description TEXT NOT NULL,
    discount DECIMAL(5, 2) DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    type VARCHAR(50) NOT NULL CHECK (type IN ('apartment', 'house', 'villa', 'cabin', 'condo')),
    bathrooms INT NOT NULL,
    bedrooms INT NOT NULL,
    max_guests INT NOT NULL,
    total_rating DECIMAL(3, 2) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (owner_id) REFERENCES users(id) ON DELETE CASCADE
);

-- create index IF NOT EXISTS of properties is_active with price and total_rating
CREATE INDEX IF NOT EXISTS idx_properties_price ON properties(is_active, price);
CREATE INDEX IF NOT EXISTS idx_properties_total_rating ON properties(total_rating);

-- create property_rules table IF NOT EXISTS
CREATE TABLE IF NOT EXISTS property_rules (
    id SERIAL PRIMARY KEY,
    property_id INT NOT NULL,
    smooking BOOLEAN DEFAULT FALSE,
    pets BOOLEAN DEFAULT FALSE,
    parties BOOLEAN DEFAULT FALSE,
    children BOOLEAN DEFAULT FALSE,
    check_in_time TIME NOT NULL,
    check_out_time TIME NOT NULL,
    cancelation_policy VARCHAR(50) NOT NULL CHECK (cancelation_policy IN ('flexible', 'moderate', 'strict')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES properties(id) ON DELETE CASCADE
);

-- create index IF NOT EXISTS of property_rules property_id
CREATE INDEX IF NOT EXISTS idx_property_rules_property_id ON property_rules(property_id);

-- create property_addresses table IF NOT EXISTS
CREATE TABLE IF NOT EXISTS property_addresses (
    id SERIAL PRIMARY KEY,
    property_id INT NOT NULL,
    street VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    country VARCHAR(100) NOT NULL,
    latitude DECIMAL(9, 6) NOT NULL,
    longitude DECIMAL(9, 6) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES properties(id) ON DELETE CASCADE
);

-- create index IF NOT EXISTS of property_addresses property_id, city, state, country, latitude, longitude
CREATE INDEX IF NOT EXISTS idx_property_addresses_property_id ON property_addresses(property_id);
CREATE INDEX IF NOT EXISTS idx_property_addresses_city ON property_addresses(city, state, country);
CREATE INDEX IF NOT EXISTS idx_property_addresses_latitude_longitude ON property_addresses(latitude, longitude);

-- create property_photos table IF NOT EXISTS
CREATE TABLE IF NOT EXISTS property_photos (
    id SERIAL PRIMARY KEY,
    property_id INT NOT NULL,
    photo_url VARCHAR(255) NOT NULL,
    type VARCHAR(50) NOT NULL CHECK (type IN ('main', 'gallery')) DEFAULT 'gallery',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES properties(id) ON DELETE CASCADE
);

-- create index IF NOT EXISTS of property_photos property_id
CREATE INDEX IF NOT EXISTS idx_property_photos_property_id ON property_photos(property_id);

-- create propert_calendar table IF NOT EXISTS    
CREATE TABLE IF NOT EXISTS property_calendar (
    id SERIAL PRIMARY KEY,
    property_id INT NOT NULL,
    date DATE NOT NULL,
    state VARCHAR(50) NOT NULL CHECK (state IN ('available', 'booked', 'blocked', 'pending')) DEFAULT 'available',
    price DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES properties(id) ON DELETE CASCADE
);

-- create index IF NOT EXISTS of property_calendar property_id, state, date
CREATE INDEX IF NOT EXISTS idx_property_calendar_property_id ON property_calendar(property_id);
CREATE INDEX IF NOT EXISTS idx_property_calendar_state ON property_calendar(state, date);

-- create amenities table IF NOT EXISTS
CREATE TABLE IF NOT EXISTS amenities (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    icon VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- create property_amenities table IF NOT EXISTS
CREATE TABLE IF NOT EXISTS property_amenities (
    id SERIAL PRIMARY KEY,
    property_id INT NOT NULL,
    amenity_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES properties(id) ON DELETE CASCADE,
    FOREIGN KEY (amenity_id) REFERENCES amenities(id) ON DELETE CASCADE
);

-- create index IF NOT EXISTS of property_amenities property_id with unique constraint
CREATE UNIQUE INDEX IF NOT EXISTS idx_property_amenities_unique ON property_amenities(property_id, amenity_id);

-- create reviews table IF NOT EXISTS
CREATE TABLE IF NOT EXISTS reviews (
    id SERIAL PRIMARY KEY,
    property_id INT NOT NULL,
    user_id INT NOT NULL,
    rating DECIMAL(2, 1) NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES properties(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- create index IF NOT EXISTS of reviews property_id
CREATE INDEX IF NOT EXISTS idx_reviews_property_id ON reviews(property_id);

-- create bookings table IF NOT EXISTS
CREATE TABLE IF NOT EXISTS bookings (
    id SERIAL PRIMARY KEY,
    property_id INT NOT NULL,
    user_id INT NOT NULL,
    date_in DATE NOT NULL,
    date_out DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status VARCHAR(50) NOT NULL CHECK (status IN ('pending', 'confirmed', 'cancelled')) DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES properties(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- create index IF NOT EXISTS of bookings property_id, user_id
CREATE INDEX IF NOT EXISTS idx_bookings_property_id ON bookings(property_id);
CREATE INDEX IF NOT EXISTS idx_bookings_user_id ON bookings(user_id);

-- create payments table IF NOT EXISTS
CREATE TABLE IF NOT EXISTS payments (
    id SERIAL PRIMARY KEY,
    booking_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_method INT NOT NULL,
    status VARCHAR(50) NOT NULL CHECK (status IN ('pending', 'completed', 'failed')) DEFAULT 'pending',
    transaction_id VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES bookings(id),
    FOREIGN KEY (payment_method) REFERENCES payment_methods(id)
);

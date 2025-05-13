-- SQL CREATE INDEX commands to create appropriate indexes

-- create index IF NOT EXISTS of user_addresses user_id
CREATE INDEX IF NOT EXISTS idx_user_addresses_user_id ON user_addresses(user_id);

-- create index IF NOT EXISTS of payment_methods user_id
CREATE INDEX IF NOT EXISTS idx_payment_methods_user_id ON payment_methods(user_id);

-- create index IF NOT EXISTS of messages sender_id and receiver_id
CREATE INDEX IF NOT EXISTS idx_messages_sender_id ON messages(sender_id);
CREATE INDEX IF NOT EXISTS idx_messages_receiver_id ON messages(receiver_id);

-- create index IF NOT EXISTS of user_roles user_id with unique constraint
CREATE UNIQUE INDEX IF NOT EXISTS idx_user_roles_unique ON user_roles(user_id, role_id);

-- create index IF NOT EXISTS of properties is_active with price and total_rating
CREATE INDEX IF NOT EXISTS idx_properties_price ON properties(is_active, price);
CREATE INDEX IF NOT EXISTS idx_properties_total_rating ON properties(total_rating);

-- create index IF NOT EXISTS of property_rules property_id
CREATE INDEX IF NOT EXISTS idx_property_rules_property_id ON property_rules(property_id);

CREATE INDEX IF NOT EXISTS idx_property_addresses_property_id ON property_addresses(property_id);
CREATE INDEX IF NOT EXISTS idx_property_addresses_city ON property_addresses(city, state, country);
CREATE INDEX IF NOT EXISTS idx_property_addresses_latitude_longitude ON property_addresses(latitude, longitude);

-- create index IF NOT EXISTS of property_photos property_id
CREATE INDEX IF NOT EXISTS idx_property_photos_property_id ON property_photos(property_id);

-- create index IF NOT EXISTS of property_calendar property_id, state, date
CREATE INDEX IF NOT EXISTS idx_property_calendar_property_id ON property_calendar(property_id);
CREATE INDEX IF NOT EXISTS idx_property_calendar_state ON property_calendar(state, date);

-- create index IF NOT EXISTS of property_amenities property_id with unique constraint
CREATE UNIQUE INDEX IF NOT EXISTS idx_property_amenities_unique ON property_amenities(property_id, amenity_id);

-- create index IF NOT EXISTS of reviews property_id
CREATE INDEX IF NOT EXISTS idx_reviews_property_id ON reviews(property_id);

-- create index IF NOT EXISTS of bookings property_id, user_id
CREATE INDEX IF NOT EXISTS idx_bookings_property_id ON bookings(property_id);
CREATE INDEX IF NOT EXISTS idx_bookings_user_id ON bookings(user_id);

-- Step 1: Create partitioned table for bookings
CREATE TABLE bookings_partitioned (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    property_id INTEGER NOT NULL,
    date_in DATE NOT NULL,
    date_out DATE NOT NULL,
    total_price DECIMAL(10,2),
    status VARCHAR(50) NOT NULL CHECK (status IN ('pending', 'confirmed', 'cancelled')) DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES properties(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
) PARTITION BY RANGE (date_in);

-- Step 2: Create partitions for different date ranges
-- Partitioning by quarter for the current year
CREATE TABLE bookings_q1_2025 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2025-01-01') TO ('2025-04-01');

CREATE TABLE bookings_q2_2025 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2025-04-01') TO ('2025-07-01');

CREATE TABLE bookings_q3_2025 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2025-07-01') TO ('2025-10-01');

CREATE TABLE bookings_q4_2025 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2025-10-01') TO ('2025-01-01');

-- For future data
CREATE TABLE bookings_future PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2026-01-01') TO (MAXVALUE);

-- For past data
CREATE TABLE bookings_past PARTITION OF bookings_partitioned
    FOR VALUES FROM (MINVALUE) TO ('2025-01-01');

-- Step 3: Create indexes on partitions
CREATE INDEX idx_bookings_part_user_id ON bookings_partitioned(user_id);
CREATE INDEX idx_bookings_part_property_id ON bookings_partitioned(property_id);
CREATE INDEX idx_bookings_part_date_in ON bookings_partitioned(date_in, date_out);

-- Step 4: Migrate data from the original table to the partitioned table
INSERT INTO bookings_partitioned SELECT * FROM bookings;

-- Step 5: Test queries to measure performance improvement
EXPLAIN ANALYZE
SELECT b.id, u.first_name, u.last_name, p.name, p.type, py.payment_method, py.status
FROM bookings_partitioned b
INNER JOIN users u ON b.user_id = u.id
INNER JOIN properties p ON b.property_id = p.id
INNER JOIN payments py ON b.id = py.booking_id
WHERE b.start_date BETWEEN '2025-04-01' AND '2025-06-31'
ORDER BY b.start_date;

-- Query 2: Compare with the original table
EXPLAIN ANALYZE
SELECT b.id, u.first_name, u.last_name, p.name, p.type, py.payment_method, py.status
FROM bookings b
INNER JOIN users u ON b.user_id = u.id
INNER JOIN properties p ON b.property_id = p.id
INNER JOIN payments py ON b.id = py.booking_id
WHERE b.start_date BETWEEN '2025-04-01' AND '2023-06-31'
ORDER BY b.start_date;

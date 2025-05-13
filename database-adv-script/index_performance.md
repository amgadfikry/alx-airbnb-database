# Implement Indexes for Optimization

## High-usage columns in the database schema

1. **email** in the `user` table
2. **user_id** and **role_id** in the `user_role` table
3. **user_id** in `user-addresses` and `payment_methods` tables
4. **sender_id** and **receiver_id** in the `messages` table
5. **is_active**, **type**, and **price** in the `properties` table
6. **property_id** in `property_photos`, `property_addresses`, and `property_rules` tables
7. **property_id**, **status**, and **date** in `property_calendar` table
8. **property_id** and **user_id** in the `bookings` and `reviews` tables
9. **property_id** and **amenity_id** in the `property_amenities` table



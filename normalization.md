# Database Schema Normalization

This document explains the normalization steps applied to the real estate platform database schema to ensure data integrity and optimal performance.

## Normalization Process

### First Normal Form (1NF)

1NF ensures that each column holds atomic values, with no repeating groups.

- **Users Table**: Attributes like `id`, `email`, and `phone` are atomic. Email is unique, avoiding redundancy.
- **Properties Table**: Attributes, including `name` and `price`, are separate and non-repeating.

### Second Normal Form (2NF)

2NF ensures all non-key attributes are fully dependent on the primary key.

- **User Addresses Table**: All address details are dependent on `user_id`, ensuring full dependency on the primary key.
- **Property Rules Table**: Each rule is dependent on `property_id`, ensuring no partial dependency.

### Third Normal Form (3NF)

3NF eliminates transitive dependencies.

- **Bookings Table**: Attributes such as `status` and `total_price` depend directly on `booking_id`, avoiding indirect dependencies.
- **Payments Table**: Attributes are directly linked to `booking_id`, with no transitive dependency, ensuring streamlined dependency.

## Summary

These normalization steps optimize the database for accuracy and efficiency, reducing redundancy and facilitating robust data integrity across the application.

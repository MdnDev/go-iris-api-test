-- +goose Up
CREATE TABLE IF NOT EXISTS users(
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email TEXT NOT NULL UNIQUE,
  is_admin BOOLEAN NOT NULL DEFAULT FALSE,
  stars_count INTEGER NOT NULL DEFAULT 0,
  is_open_to_review BOOLEAN,
  contributions_count INTEGER NOT NULL DEFAULT 0,
  review_count INTEGER NOT NULL DEFAULT 0,
  content_count INTEGER NOT NULL DEFAULT 0
);

-- +goose Down
DROP TABLE users;

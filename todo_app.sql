-- Write a query to drop a database named todo_app if it exists
DROP DATABASE IF EXISTS todo_app;
-- Write a query to create a database named todo_app
CREATE DATABASE todo_app;
-- Write a query to create a user named michael with an encrypted password stonebreaker
DROP USER IF EXISTS michael;
-- Write a query to delete a user named michael if it exists
CREATE USER michael
  WITH
    ENCRYPTED PASSWORD 'stonebreaker';

\c todo_app;

DROP TABLE IF EXISTS tasks;

CREATE TABLE tasks (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) UNIQUE NOT NULL,
  description text NULL,
  created_at timestamp NOT NULL DEFAULT now(),
  updated_at timestamp NULL,
  completed boolean NOT NULL DEFAULT false
);

ALTER TABLE IF EXISTS tasks
  DROP COLUMN IF EXISTS completed;

ALTER TABLE IF EXISTS tasks
  ADD COLUMN completed_at timestamp NULL DEFAULT NULL;

ALTER TABLE IF EXISTS tasks
  ALTER COLUMN updated_at
    DROP NOT NULL;

ALTER TABLE IF EXISTS tasks
  ALTER COLUMN updated_at
    SET DEFAULT now();

INSERT INTO tasks (title, description)
  VALUES ('Study SQL', 'Complete this exercise');

INSERT INTO tasks (title, description)
  VALUES ('Study PostgreSQL', 'Read all the documentation');

SELECT * FROM tasks;
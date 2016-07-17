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
-- Write a query to create a table named tasks using the Initial columns detailed below
CREATE TABLE tasks (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) UNIQUE NOT NULL,
  description text NULL,
  created_at timestamp NOT NULL DEFAULT now(),
  updated_at timestamp NULL,
  completed boolean NOT NULL DEFAULT false
);

-- remove the column named completed
ALTER TABLE IF EXISTS tasks
  DROP COLUMN IF EXISTS completed;

-- add a column to tasks named completed_at:timestamp, that may be NULL, and has a default value of NULL.
ALTER TABLE IF EXISTS tasks
  ADD COLUMN completed_at timestamp NULL;

ALTER TABLE IF EXISTS tasks
  ALTER COLUMN completed_at
    SET DEFAULT NULL;

ALTER TABLE IF EXISTS tasks
  ALTER COLUMN updated_at
    DROP NOT NULL;

-- change the updated_at column to not allow NULL values, and have a default value of now()
ALTER TABLE IF EXISTS tasks
  ALTER COLUMN updated_at
    SET DEFAULT now();
-- create a new task, by only setting values (not defining which columns)
INSERT INTO tasks (title, description)
  VALUES ('Study SQL', 'Complete this exercise');

-- create a new task
INSERT INTO tasks (title, description)
  VALUES ('Study PostgreSQL', 'Read all the documentation');

-- select all the titles of tasks that are not yet completed
SELECT title FROM tasks WHERE completed_at is NULL;

-- update the task with a title of 'Study SQL' to be completed as of now
UPDATE tasks
  SET completed_at = now() WHERE title = 'Study SQL';

-- select all titles and descriptions of tasks that are not yet completed
SELECT title, description FROM tasks WHERE completed_at is NULL;

-- select all fields of every task sorted by creation date in descending order
SELECT * FROM tasks ORDER BY created_at DESC;
-- SELECT * FROM tasks;
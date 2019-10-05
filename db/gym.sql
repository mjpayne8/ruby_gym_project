DROP TABLE bookings;
DROP TABLE gym_classes;
DROP TABLE members;

CREATE TABLE members (
  id SERIAL8 PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  address TEXT
);

CREATE TABLE gym_classes (
  id SERIAL8 PRIMARY KEY,
  class_name VARCHAR(255),
  class_date DATE,
  class_time TIME,
  duration INT,
  spaces INT
);

CREATE TABLE bookings (
  id SERIAL8 PRIMARY KEY,
  member_id INT8 REFERENCES members(id),
  gym_class_id INT8 REFERENCES gym_classes(id)
);

DROP TABLE bookings;
DROP TABLE gym_classes;
DROP TABLE members;
DROP TABLE memberships;

CREATE TABLE memberships (
  id SERIAL8 PRIMARY KEY,
  type VARCHAR(255),
  start_time TIME,
  end_time TIME
);

CREATE TABLE members (
  id SERIAL8 PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  address TEXT,
  membership_id INT8 REFERENCES memberships(id)
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
  member_id INT8 REFERENCES members(id) ON DELETE CASCADE,
  gym_class_id INT8 REFERENCES gym_classes(id) ON DELETE CASCADE
);

INSERT INTO jobs (name, label) VALUES ('gardener', 'O´Connor Landscaping');

INSERT INTO job_grades (job_name, grade, label, salary) VALUES 
('gardener', 0, 'Gardener', 250)

INSERT INTO datastore (name, label, shared) VALUES 
('society_gardener', 'Gardener', 1);

INSERT INTO society_money (society, money) VALUES 
('society_gardener', 0);

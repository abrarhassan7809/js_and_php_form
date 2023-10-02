SET @@AUTOCOMMIT = 1;

DROP DATABASE IF EXISTS GTLM;
CREATE DATABASE GTLM;

USE GTLM;


CREATE user IF NOT EXISTS dbadmin@localhost;
GRANT all privileges ON GTLM.users TO dbadmin@localhost;
GRANT all privileges ON GTLM.groups TO dbadmin@localhost;
GRANT all privileges ON GTLM.usersgroups TO dbadmin@localhost;
GRANT all privileges ON GTLM.projects TO dbadmin@localhost;
GRANT all privileges ON GTLM.tasks TO dbadmin@localhost;
GRANT all privileges ON GTLM.comments TO dbadmin@localhost;
GRANT all privileges ON GTLM.assignees TO dbadmin@localhost;


CREATE TABLE users(
	employeeID int NOT NULL	PRIMARY KEY,
	username varchar(50) NOT NULL,
	password varchar(50) NOT NULL,
	dob date NOT NULL,
	contact int NOT NULL,
	email varchar(50) NOT NULL,
	jobRole varchar(50) NOT NULL
);

insert into users values(1,'XXX','password','1981-09-21','789789789','XXX@whirlpool.com','Manager');
insert into users values(2,'YYY','password','1985-09-21','123121312','YYY@whirlpool.com','Developer');
insert into users values(3,'Admin','password','1980-09-21','456456456','admin@whirlpool.com','Admin');

CREATE TABLE groups(
	groupName varchar(50) NOT NULL PRIMARY KEY,
	groupDescription varchar(200) NOT NULL
);

insert into groups values('GroupA','Development team for project A');
insert into groups values('GroupB','Development team for project B');

/*1 group can only contain 1 unique user*/
CREATE TABLE usersgroups(
	groupName varchar(50) NOT NULL,
	employeeID int NOT NULL,
	PRIMARY KEY(groupName,employeeID),
	FOREIGN KEY(groupName) REFERENCES groups(groupName) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(employeeID) REFERENCES users(employeeID) ON UPDATE CASCADE ON DELETE NO ACTION
);

insert into usersgroups values('GroupA','1');
insert into usersgroups values('GroupA','2');
insert into usersgroups values('GroupB','2');
insert into usersgroups values('GroupB','3');


CREATE TABLE projects (
	projectName varchar(100) NOT NULL PRIMARY KEY,
	description varchar(100) NOT NULL,
	clientName varchar(50) NOT NULL,
	status varchar(50) NOT NULL,
	projectManager varchar(50) NOT NULL
);

insert into projects values('SAMSUNG','Project SAMSUNG descriptions','SAMSUNG','In-progress','XXX');
insert into projects values('WHIRLPOOL','Project WHIRLPOOL descriptions','WHIRLPOOL','In-progress','YYY');

CREATE TABLE tasks (
	taskID int NOT NULL AUTO_INCREMENT PRIMARY KEY,
	projectName varchar(100) NOT NULL,
	taskTitle varchar(100) NOT NULL,
	priority varchar(50) NOT NULL,
	sprint varchar(50) NOT NULL,
	taskDescription varchar(2000),
	status varchar(50) NOT NULL,
	type varchar(50) NOT NULL,
	dueDate date,
	FOREIGN KEY(projectName) REFERENCES projects(projectName) ON UPDATE CASCADE ON DELETE CASCADE
)AUTO_INCREMENT = 1;

INSERT INTO tasks (projectName, taskTitle, priority, sprint, taskDescription, status, type, dueDate)
VALUES ('SAMSUNG','Testing task 1','High','1','Testing task 1 details','todo','Task','2023-09-21'),
    ('SAMSUNG','Testing task 2','Medium','1','Testing task 2 details','inprogress','Task','2023-09-28');


CREATE TABLE comments(
	commentID int NOT NULL AUTO_INCREMENT PRIMARY KEY,
	employeeID int NOT NULL,
	taskID int NOT NULL,
	details varchar(2000) NOT NULL,
	updatedTime timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY(taskID) REFERENCES tasks(taskID) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(employeeID) REFERENCES users(employeeID) ON UPDATE CASCADE ON DELETE CASCADE
)AUTO_INCREMENT = 1;

INSERT INTO comments (employeeID,taskID,details) VALUES
(1,1,'This task will be completed on time.'),
(2,2,'Let us have a meeting to talk about this task.');

/*1 task can only contain 1 unique assignee which is either user or group*/
CREATE TABLE assignees(
	taskID int NOT NULL,
	assignee varchar(50) NOT NULL,
	PRIMARY KEY(taskID,assignee),
	FOREIGN KEY(taskID) REFERENCES tasks(taskID) ON UPDATE CASCADE ON DELETE CASCADE
);

insert into assignees values(1,'GroupA');
insert into assignees values(1,'Sam');
insert into assignees values(2,'GroupB');
insert into assignees values(2,'Evelyn');


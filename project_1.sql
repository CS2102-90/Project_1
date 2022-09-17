CREATE	TABLE 	Countries(
	cname 		VARCHAR(20) PRIMARY KEY,
	tax_code	INTEGER NOT NULl	
);

CREATE TABLE Employees(
	eid 	INTEGER PRIMARY KEY,
	ename 	VARCHAR(50) NOT NULL, 
	salary  INTEGER NOT NULL
);

CREATE TABLE Users(
	email 		VARCHAR(50) PRIMARY KEY,
	uname 		VARCHAR(50) NOT NULL,
	card_1		VARCHAR(20) NOT NULL,
	card_2 		VARCHAR(20),
);

CREATE	TABLE	Creators(
	email 	VARCHAR(50) PRIMARY KEY,
	country VARCHAR(20) NOT NULL,

	FOREIGN KEY (email) REFERENCES Users(email) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (country) REFERENCES Countries(cname) ON DELETE SET NULL ON UPDATE CASCADE	
);

CREATE	TABLE	Backers(
	email 			VARCHAR(50) PRIMARY KEY,
	street_name		VARCHAR(50) NOT NULL,
	house_number	VARCHAR(30) NOT NULL,
	zip_code		INTEGER NOT NULL,
	country 		VARCHAR(20) REFERENCES Countries(cname),
	
	FOREIGN KEY (email) REFERENCES Users(email) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE 	TABLE	Projects(
	pid 			SERIAL,
	ptype 			VARCHAR(40),
	reward_level 	VARCHAR(20) NOT NULL,
	min_funding 	INTEGER,
	funding_goal	INTEGER,
	deadline_date 	DATE,
	cemail 			VARCHAR(50) NOT NULL,
	bemail 	 		VARCHAR(),
	create_date  	DATE,
	
	UNIQUE(pid, reward_level),
	UNIQUE(pid, deadline_date),
	PRIMARY KEY (pid, reward_level, min_funding, deadline_date),
	FOREIGN KEY cemail REFERENCES Creators(email) ON DELETE SET NULL ON UPDATE CASCADE, 
);

CREATE TABLE Funding(
	pid 			INTEGER,
	reward_level 	VARCHAR(20) NOT NULL,
	min_funding 	INTEGER
	amount 			INTEGER,
	bemail 			VARCHAR(50) NOT NULL,
	fund 			INTEGER NOT NULL,
	ddl 			DATE,
	fund_date 		DATE,
	
	PRIMARY KEY (pid, bemail, ddl),
	FOREIGN KEY (pid, reward_level, min_funding, ddl) REFERENCES Projects(pid, reward_level, min_funding, deadline_date) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (bemail) REFERENCES Backers(email) ON DELETE SET NULL ON UPDATE CASCADE,
	CHECK (amount >= min_funding),
	CHECK (fund_date <= DATEADD(day, 0, ddl))
);

CREATE TABLE Update_project(
	pid 			INTEGER,
	reward_level	VARCHAR(20) NOT NULL,
	min_funding 	INTEGER,
	deadline_date 	DATE,
	update_time		TIME,
	update_date		DATE,
	
	PRIMARY KEY (pid, update_time, update_date),
	FOREIGN KEY (pid, reward_level, min_funding, deadline_date, cemail) REFERENCES Projects(pid, reward_level, min_funding, deadline_date, cemail) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Refund(
	pid 		INTEGER NOT NULL,
	bemail 		VARCHAR(50) NOT NULL,
	ddl 		DATE NOT NULL,
	refund_date DATE NOT NULL,

	PRIMARY KEY (pid, bemail, refund_date),
	FOREIGN KEY (pid, bemail, ddl) REFERENCES Funding(pid, bemail, ddl) ON DELETE CASCADE ON UPDATE CASCADE,
	CHECK (refund_date <= DATEADD(day, -90, ddl))
);

CREATE TABLE Check_Refund(
	eid				INTEGER,
	pid 			INTEGER NOT NULL,
	bemail 			VARCHAR(50) NOT NULL,
	refund_date 	DATE NOT NULL,
	refund_status 	VARCHAR(50),
	
	 
	UNIQUE(pid, bemail),
	CHECK (
		(refund_status = 'APPROVED') OR 
		(refund_status = 'REJECT')
	),
	PRIMARY KEY (eid, pid, bemail),
	FOREIGN KEY (eid) REFERENCES Employees(eid) ON DELETE SET NULL ON UPDATE CASCADE,
	FOREIGN KEY (pid, bemail, refund_date) REFERENCES Refund(pid, bemail, refund_date) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Verify(
	eid 			INTEGER UNIQUE,
	uemail 			VARCHAR(50) NOT NULL,
	vertify_status  VARCHAR(50),
	vertify_date	DATE,

	PRIMARY KEY(eid, uemail),
	FOREIGN KEY(eid) REFERENCES Employees(eid) ON DELETE SET NULL ON UPDATE CASCADE,
	FOREIGN KEY(uemail) REFERENCES Users(email) ON DELETE CASCADE ON UPDATE CASCADE
);
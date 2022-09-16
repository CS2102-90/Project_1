CREATE	TABLE 	Countries(
	cname 		VARCHAR(20) PRIMARY KEY,
	tax_code	INTEGER NOT NULl,
);

CREATE TABLE Users(
	uname 	VARCHAR(50) NOT NULL,
	email 	VARCHAR(50) PRIMARY KEY,
	card_1	VARCHAR(20) NOT NULL,
	card_2 	VARCHAR(20),
);

CREATE	TABLE	Creators(
	email 	VARCHAR(50) UNIQUE NOT NULL,
	country VARCHAR(20),
	FOREIGN KEY (email) REFERENCES Users(email) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (country) REFERENCES Countries(cname) ON UPDATE CASCADE ON DELETE SET NULL,	
);

CREATE 	TABLE	Projects(
	pid 			SERIAL,
	pname 			VARCHAR(100),
	ptype 			VARCHAR(40),
	reward_level 	VARCHAR(20) NOT NULL,
	funding_goal	BIGINT,
	deadline_date 	DATE,
	deadline_time 	TIME,
	cemail VARCHAR(50) NOT NULL,
	backers VARCHAR()
	
	PRIMARY KEY (pid, reward_level),
	FOREIGN KEY cemail REFERENCES Creators(email) ON DELETE SET NULL ON UPDATE CASCADE, 
	
);

CREATE	TABLE	Backers(
	email 	VARCHAR(50) PRIMARY KEY,
	street_name		VARCHAR(50) NOT NULL,
	house_number	VARCHAR(30) NOT NULL,
	zip_code		INTEGER NOT NULL,
	country 		VARCHAR(20) REFERENCES Countries(cname),
	
	FOREIGN KEY (email) REFERENCES Users(email),	
);

CREATE TABLE Employees(
	eid 	INTEGER UNIQUE NOT NULL,
	ename 	VARCHAR(50) NOT NULL, 
);

CREATE TABLE Funding(
	pname 	VARCHAR(100),
	reward_level 	VARCHAR(20) NOT NULL,
	min_funding 	BIGINT,
	bemail 	VARCHAR(50) NOT NULL,
	fund 	INTEGER NOT NULL,
	
	PRIMARY KEY (pname, bemail),
	FOREIGN KEY (pname, reward_level, min_funding) REFERENCES Projects(pname, reward_level, funding_goal) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (bemail) REFERENCES Backers(email) ON UPDATE CASCADE ON DELETE SET NULL,
)

CREATE TABLE Refund(
	pname 	VARCHAR(100),
	bname 	VARCHAR(50),
)

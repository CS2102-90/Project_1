CREATE	TABLE 	Countries(
	cname 		VARCHAR(20) PRIMARY KEY,
	tax_code	INTEGER NOT NULl,
);

CREATE	TABLE	Creators(
	uname 	VARCHAR(50) NOT NULL,
	email 	VARCHAR(50) UNIQUE NOT NULL,
	card_1	VARCHAR(20) NOT NULL,
	card_2 	VARCHAR(20),
	country VARCHAR(20) REFERENCES Countries(cname),
	PRIMARY KEY (uname, email),
	
);

CREATE 	TABLE	Projects(
	pid 			SERIAL,
	pname 			VARCHAR(100),
	ptype 			VARCHAR(40),
	reward_level 	VARCHAR(20) NOT NULL,
	funding_goal	BIGINT,
	deadline 		DATE,
	creator VARCHAR(50) NOT NULL,
	backers VARCHAR()
	
	PRIMARY KEY (pid, reward_level),
	FOREIGN KEY creator REFERENCES Creators(uname, email) ON DELETE CASCADE ON UPDATE CASCADE, 
	
);

CREATE	TABLE	Backers(
	uname 	VARCHAR(50) NOT NULL,
	email 	VARCHAR(50) UNIQUE NOT NULL,
	card_1	VARCHAR(20) NOT NULL,
	card_2 	VARCHAR(20),
	street_name		VARCHAR(50) NOT NULL,
	house_number	VARCHAR(30) NOT NULL,
	zip_code		INTEGER NOT NULL,
	country 		VARCHAR(20) REFERENCES Countries(cname),
-- 	projects		SERIAL UNIQUE,
	
-- 	UNIQUE(projects, back_level),
	PRIMARY KEY (uname, email),
-- 	FOREIGN KEY (projects, back_level) REFERENCES Projects(pid, reward_level),
	
);

CREATE TABLE Employees(
	eid 	INTEGER UNIQUE NOT NULL,
	ename 	VARCHAR(50) NOT NULL, 
);

CREATE TABLE Funding(
	pname 	VARCHAR(100),
	bname 	VARCHAR(50),
	reward_level 	VARCHAR(20) NOT NULL,
	email 	VARCHAR(50) NOT NULL,
	
	PRIMARY KEY (pname, bname),
-- 	UNIQUE (pname, bname, reward_level),
	FOREIGN KEY (pname, reward_level) REFERENCES Projects(pname, reward_level) ON UPDATE CASCADE,
	FOREIGN KEY (bname, email) REFERENCES Backers(uname, email),
)

CREATE TABLE Refund(
	pname 	VARCHAR(100),
	bname 	VARCHAR(50),
)

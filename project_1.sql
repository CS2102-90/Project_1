CREATE	TABLE 	Countries(
	cname 		VARCHAR(20) PRIMARY KEY,
	tax_code	INTEGER NOT NULl,
);

CREATE	TABLE	Users(
	uname 	VARCHAR(50) NOT NULL,
	email 	VARCHAR(50) UNIQUE NOT NULL,
	card_1	VARCHAR(20) NOT NULL,
	card_2 	VARCHAR(20),
	utype 	VARCHAR(10) CHECK (
		utype = 'creator'
		OR utype = 'backer'
	),
	street_name		VARCHAR(50),
	house_number	VARCHAR(30),
	zip_code		VARCHAR(30),
	cname 			VARCHAR(20) REFERENCES Countries(cname),
	PRIMARY KEY (uname, email),
	
);

CREATE 	TABLE	Projects(
	pname 			VARCHAR(100) PRIMARY KEY,
	ptype 			VARCHAR(40),
	reward_level 	VARCHAR(10) CHECK (
		reward_level = 'Platinum'
		OR reward_level = 'Gold'
		OR reward_level = 'Silver'
		OR reward_level = 'Bronze'
	),
	
);


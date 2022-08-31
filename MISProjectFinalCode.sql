USE mugdhavsonawane_workspace; 

CREATE TABLE PASSENGER(
AccountID INTEGER PRIMARY KEY NOT NULL,
PassengerName VARCHAR(40), 
PassengerAge INT,
FrequentflyerID INT);

INSERT INTO PASSENGER
VALUES ("123456","Yifan Jia","20","123456");
INSERT INTO PASSENGER
VALUES ("136475","Mugdha Sonawane","20","136475");
INSERT INTO PASSENGER
VALUES ("273849","Isaiah Bae","20","273849");
INSERT INTO PASSENGER
VALUES ("394874","Mobeen Rana","20","394874");
INSERT INTO PASSENGER
VALUES ("948576","Melissa Satran","20","948576");

CREATE TABLE AIRPORT(
AirportCode VARCHAR(8),
AirportName VARCHAR(50), 
AirportCity VARCHAR(30),
AirportState VARCHAR(30),
AirportAddress VARCHAR(50),
Classificarion VARCHAR(30),
TimeZone VARCHAR(8),
CONSTRAINT AIRPORT_PK PRIMARY KEY (AirportCode));

INSERT INTO AIRPORT
VALUES ("ABI","Abilene Regional Airport","Abilene", "TX","6c Wireless Main Road, Airport, Tiruchirapalli","Class C international airport","GMT-6");
INSERT INTO AIRPORT
VALUES ("ALS","San Luis Valley Regional Airport","Alamosa", "CO","Tucson, AZ 85756","National airport","GMT-7");
INSERT INTO AIRPORT
VALUES ("BIL","Billings Logan International Airport","Billings", "MT","1901 Terminal Cir, Billings, Mt 59105","Regional airport","MT");
INSERT INTO AIRPORT
VALUES ("BGM","Greater Binghamton Airport","Binghamton", "NY","Airport Rd, Johnson City, NY 13790","Regional airport","GMT-5");
INSERT INTO AIRPORT
VALUES ("BOI","Boise Airport","Boise", "ID","3201 W Airport Way #1000, Boise, ID 83705","National airport","GMT-7");


CREATE TABLE AIRCRAFT(
AirplaneNumber VARCHAR(30) PRIMARY KEY, 
AirplaneMake VARCHAR(25),
WeightLimit VARCHAR(30),
FlightNumber VARCHAR(30),
AirportCode VARCHAR(8));

select * from AIRCRAFT;

INSERT INTO AIRCRAFT
VALUES ("Boeing 737-900","titanium, composites","155,000 lbs","A320","ALS");
INSERT INTO AIRCRAFT
VALUES ("Airbus A320-100","titanium, steel","175,000 lbs","A321","BIL");
INSERT INTO AIRCRAFT
VALUES ("Embraer 190","aluminum,, steel","105,000 lbs","ERJ-145","ABI");
INSERT INTO AIRCRAFT
VALUES ("Boeing 777-300ER","titanium, steel","180,000 lbs","RJ 900","BOI");
INSERT INTO AIRCRAFT
VALUES ("Gulfstream G650","composites, steel","125,000 lbs","DL 5425","BGM");


 CREATE TABLE FLIGHTCREW(
 EmployeeID INT NOT NULL, 
 EmployeeName VARCHAR(25),
 EmployeeTitle VARCHAR(25),
 EmployeeAge INT,
 Employeestreetaddress VARCHAR(50),
 Employeezipcode INT,
 EmployeeCity VARCHAR(30),
 EmployeeState VARCHAR(30),
 AirportCode VARCHAR(8),
CONSTRAINT FLIGHTCREW_PK PRIMARY KEY (EmployeeID),
CONSTRAINT FLIGHTCREW_FK FOREIGN KEY(AirportCode) REFERENCES AIRPORT(AirportCode));


INSERT INTO FLIGHTCREW
VALUES ("1859006","Virat Kohli","Passenger assistant","25","330 1st Ave","85003","Dallas","TX","ABI");
INSERT INTO FLIGHTCREW
VALUES ("3847905","Steve Smith","Airline food servicer","35","10400 Belle Creek Blvd","80640","Denver","CO","ALS");
INSERT INTO FLIGHTCREW
VALUES ("1384006","Mitchel Johnson","Airline security officer","32","2747 NY-28, Old Forge","13420","Old Forge","NY","BGM");
INSERT INTO FLIGHTCREW
VALUES ("9498378","James Anderson","Airline baggage handler","29","317 W Main St","59715","Bozeman","MT","BIL");
INSERT INTO FLIGHTCREW
VALUES ("2738904","Kevin White","Aircraft fueler","40","670 Julia Davis Dr","83702","Boise","ID","BOI");


 CREATE TABLE FLIGHT(
 FlightNumber VARCHAR(30),
 Departure TIME,
 Arrival TIME, 
 FlightPrice VARCHAR(8),
 AirportCode VARCHAR(8),
 GateNumber VARCHAR(8),
 AirplaneNumber VARCHAR(30),
 EmployeeID INT NOT NULL,
CONSTRAINT FLIGHT_PK PRIMARY KEY (FlightNumber),
CONSTRAINT FLIGHT_FK1 FOREIGN KEY (AirplaneNumber) REFERENCES AIRCRAFT( AirplaneNumber), 
CONSTRAINT FLIGHT_FK2 FOREIGN KEY (EmployeeID) REFERENCES FLIGHTCREW(EmployeeID));

INSERT INTO FLIGHT
VALUES ("DL 5425","6:49","13:50","$820","BGM","B15","Gulfstream G650","1384006");
INSERT INTO FLIGHT
VALUES ("ERJ-145","16:42","19:54","$300","ABI","C11","Embraer 190","1859006");
INSERT INTO FLIGHT
VALUES ("RJ 900","6:45","11:59","$247","BOI","C16","Boeing 777-300ER","2738904");
INSERT INTO FLIGHT
VALUES ("A320","8:00","10:30","$773","ALS","A6","Boeing 737-900","3847905");
INSERT INTO FLIGHT
VALUES ("A321","13:37","22:26","$309","BIL","D14","Airbus A320-100","9498378");


ALTER TABLE AIRCRAFT
ADD FOREIGN KEY (FlightNumber) REFERENCES FLIGHT(FlightNumber);

ALTER TABLE AIRCRAFT
ADD FOREIGN KEY (AirportCode) REFERENCES AIRPORT(AirportCode);


CREATE TABLE TICKET(
 TicketID VARCHAR(20) PRIMARY KEY, 
 FromLocation VARCHAR(50),
 ToLocation VARCHAR(50),
 Seat CHAR(3),
 Price VARCHAR(5),
Flightstatus VARCHAR(20),
Class VARCHAR(20),
AccountID INT NOT NULL,
FlightNumber VARCHAR(30),
CONSTRAINT TICKET_FK1 FOREIGN KEY(AccountID)
REFERENCES PASSENGER(AccountID),
CONSTRAINT TICKET_FK2 FOREIGN KEY(FlightNumber)
REFERENCES FLIGHT(FlightNumber));

SELECT * FROM TICKET;

INSERT INTO TICKET
VALUES (182774950834,"7250 S Tucson Blvd, Tucson, AZ 85756","Airport Rd, Johnson City, NY 13790","D15","$820","In flight","First class","123456","DL 5425");
INSERT INTO TICKET
VALUES (281049372994,"6000 N Terminal Pkwy, Atlanta, GA 30320","Tucson, AZ 85756","B07","$773","On time","Business class","136475","A320");
INSERT INTO TICKET
VALUES (012837649303,"2400 Aviation Dr, DFW Airport, TX 75261","1901 Terminal Cir, Billings, Mt 59105","C12","$309","On time","Business class","273849","A321");
INSERT INTO TICKET
VALUES (394803058740,"8500 Peña Blvd, Denver, CO 80249","6c Wireless Main Road, Airport, Tiruchirapalli","D22","$300","Delayed","Business class","394874","ERJ-145");
INSERT INTO TICKET
VALUES (023480394748,"10000 W O'Hare Ave, Chicago, IL 60666","3201 W Airport Way #1000, Boise, ID 83705","A5","$247","On time","Business class","948576","RJ 900");

CREATE TABLE LUGGAGE(
LuggageID VARCHAR(20) PRIMARY KEY,
CarouselNumber INT NOT NULL,
Weight VARCHAR(20),
AccountID INT NOT NULL,
AirplaneNumber VARCHAR(30),
CONSTRAINT LUGGAGE_FK1 FOREIGN KEY(AccountID) REFERENCES PASSENGER(AccountID),
CONSTRAINT LUGGAGE_FK2 FOREIGN KEY(AirplaneNumber) REFERENCES AIRCRAFT(AirplaneNumber));

SELECT * FROM LUGGAGE;
INSERT INTO LUGGAGE
VALUES ("2129873","3","22 pounds","123456","Airbus A320-100");
INSERT INTO LUGGAGE
VALUES ("2349434","2","50 pounds","136475","Boeing 737-900");
INSERT INTO LUGGAGE
VALUES ("3892834","7","26.5 pounds","273849","Boeing 777-300ER");
INSERT INTO LUGGAGE
VALUES ("3429953","11","22 pounds","394874","Embraer 190");
INSERT INTO LUGGAGE
VALUES ("6050795","1","15 pounds","948576","Gulfstream G650");

    
SELECT AccountID, PassengerName, FrequentflyerID
FROM PASSENGER
WHERE (PassengerAge = 20);

SELECT TicketID, FromLocation, ToLocation, Seat, Flightstatus, Class, AccountID, FlightNumber
FROM TICKET
WHERE (Price < 800.00) AND (Class = "Business class");

SELECT LuggageID, AccountID, AirplaneNumber
FROM LUGGAGE
WHERE Weight <= 30.00 
AND Weight >= 20.00 
AND AirplaneNumber = "Boeing 777-300ER";

SELECT PASSENGER.AccountID, LUGGAGE.AccountID, LuggageID, CarouselNumber, PassengerName
FROM PASSENGER INNER JOIN LUGGAGE
ON PASSENGER.AccountID = LUGGAGE.AccountID
ORDER BY CarouselNumber;

SELECT FLIGHTCREW.EmployeeID, FLIGHT.EmployeeID, EmployeeName, GateNumber, 
AirplaneNumber
FROM FLIGHTCREW INNER JOIN FLIGHT
ON FLIGHTCREW.EmployeeID = FLIGHT.EmployeeID
ORDER BY GateNumber;

SELECT AIRCRAFT.AirportCode, AIRPORT.AirportCode, AirplaneNumber, AirportName, 
Classification, AirportCity, FlightNumber
FROM AIRPORT LEFT OUTER JOIN AIRCRAFT
ON AIRCRAFT.AirportCode = AIRPORT.AirportCode
ORDER BY AirportName;

UPDATE LUGGAGE
SET WEIGHT = 25
	WHERE LuggageID = 2129873;

UPDATE TICKET
SET Class = "First Class"
	WHERE TicketID = 281049372994;
    
UPDATE FLIGHT
SET Departure = "9:00"
	WHERE FlightNumber = "A320";
    
UPDATE FLIGHTCREW
SET EmployeeAge = 36
	WHERE EmployeeID = "3847905";
    
UPDATE PASSENGER
SET PassengerAge = "21"
	WHERE PassengerName = "Isaiah Bae";
    
DELETE From LUGGAGE 
WHERE WEIGHT > 50 ;

DELETE From FLIGHTCREW
WHERE EmployeeID = '1859006';

DELETE From FLIGHT
WHERE EmployeeID = '1859006';

DELETE From Ticket
WHERE Flightstatus = 'arrived'; 

DELETE From PASSENGER 
WHERE FrequentflyerID = '948576';
/*
 created
 hw4_aircraft
 hw4_airport
 hw4_flights
 hw4_ticket
 hw4_ticket_flights
 hw4_bookings
 hw4_passenger_info
 hw4_baggage
 hw4_boarding_info
 hw4_payment
 hw4_fare_conditions
 hw4_aircraft_seats
 
 not created
 hw4_one_connection
 */
drop table if exists hw4_flights CASCADE;

drop table if exists hw4_airport CASCADE;

DROP TABLE IF EXISTS hw4_aircraft CASCADE;

DROP TABLE IF EXISTS hw4_ticket CASCADE;

DROP TABLE IF EXISTS hw4_ticket_flights CASCADE;

DROP TABLE IF EXISTS hw4_bookings CASCADE;

DROP TABLE IF EXISTS hw4_passenger_info CASCADE;

DROP TABLE IF EXISTS hw4_baggage CASCADE;

DROP TABLE IF EXISTS hw4_boarding_info CASCADE;

drop table if exists hw4_payment CASCADE;

drop table if exists hw4_fare_conditions CASCADE;

drop table if exists hw4_aircraft_seats CASCADE;

CREATE TABLE hw4_aircraft(
	aircraft_code char(3),
	model char(25),
	PRIMARY KEY(aircraft_code),
	CONSTRAINT "hw4_flights_aircraft_code_fkey" FOREIGN KEY (aircraft_code) REFERENCES hw4_aircraft(aircraft_code)
);

CREATE TABLE hw4_airport (
	airport_code char(3) NOT NULL,
	airport_name varchar(40) NOT NULL,
	city char(20) NOT NULL,
	timezone text NOT NULL,
	PRIMARY KEY (airport_code)
);

create table hw4_fare_conditions(
	fare_id int NOT NULL,
	fare_type varchar(25) NOT NULL,
	primary key (fare_id)
);

create table hw4_aircraft_seats(
	aircraft_code char(3) NOT NULL,
	seat_no varchar(3) NOT NULL,
	fare_id int NOT NULL,
	seat_booked_status varchar(3),
	primary key(aircraft_code, seat_no),
	constraint "hw4_aircraft_seats_aircraft_id_fky" foreign key (aircraft_code) references hw4_aircraft(aircraft_code),
	constraint "hw4_aircraft_seats_fare_id_fky" foreign key (fare_id) references hw4_fare_conditions(fare_id)
);

CREATE TABLE hw4_flights (
	flight_id int,
	flight_no char(6),
	scheduled_departure timestamp with time zone,
	scheduled_arrival timestamp WITH time zone,
	departure_airport char(3) NOT NULL,
	arrival_airport char(3) NOT NULL,
	status varchar(20) NOT NULL,
	aircraft_code char(3) NOT NULL,
	seats_available integer NOT NULL,
	seats_booked integer NOT NULL,
	base_price money not null,
	fare_id int not null,
	PRIMARY KEY (flight_id),
	CONSTRAINT "hw4_flights_arrival_airport_fkey" FOREIGN KEY (arrival_airport) REFERENCES hw4_airport(airport_code),
	CONSTRAINT "hw4_flights_departure_airport_fkey" FOREIGN KEY (departure_airport) REFERENCES hw4_airport(airport_code),
	constraint "hw4_flights_fare_id_fky" foreign key (fare_id) references hw4_fare_conditions(fare_id)
);

create table hw4_payment(
	payment_id serial NOT NULL,
	payment_card_number varchar(20) NOT NULL,
	payment_cvv varchar(6) NOT NULL,
	payment_date timestamp with time zone NOT NULL,
	amount_paid money NOT NULL,
	primary key (payment_id)
);

CREATE TABLE hw4_bookings (
	book_ref character(6) NOT NULL,
	book_date timestamp WITH time zone NOT NULL,
	total_amount money NOT NULL,
	payment_id int NOT NULL,
	PRIMARY KEY(book_ref),
	constraint "hw4_bookings_payment_id_fky" foreign key (payment_id) references hw4_payment(payment_id)
);

create table hw4_passenger_info(
	passenger_id SERIAL,
	passenger_first_name varchar(40) NOT NULL,
	passenger_last_name varchar(40) NOT NULL,
	passenger_email varchar(50) NOT NULL,
	passenger_no varchar(15) NOT NULL,
	passenger_gender varchar(7) NOT NULL,
	passenger_birth_day timestamp NOT NULL,
	PRIMARY KEY(passenger_id)
);

CREATE TABLE hw4_ticket(
	ticket_no char(13) NOT NULL,
	book_ref character(6) NOT NULL,
	passenger_id int NOT NULL,
	PRIMARY KEY (ticket_no),
	CONSTRAINT "hw4_ticket_book_ref_fkey" FOREIGN KEY (book_ref) REFERENCES hw4_bookings(book_ref)
);

CREATE TABLE hw4_ticket_flights (
	ticket_no character(13) NOT NULL,
	flight_id integer NOT NULL,
	fare_type varchar(25) NOT NULL,
	amount numeric(10, 2) NOT NULL,
	PRIMARY KEY (ticket_no, flight_id),
	CONSTRAINT "hw4_ticket_flights_flight_id_fkey" FOREIGN KEY (flight_id) REFERENCES hw4_flights(flight_id),
	CONSTRAINT "hw4_ticket_flights_ticket_no_fkey" FOREIGN KEY (ticket_no) REFERENCES hw4_ticket(ticket_no)
);

create table hw4_baggage(
	baggage_id varchar(20) NOT NULL,
	baggage_claim_no varchar(10) NOT NULL,
	baggage_amount int NOT NULL,
	primary key (baggage_id)
);

create table hw4_boarding_info(
	boarding_id SERIAL,
	passenger_id int NOT NULL,
	boarding_time timestamp WITH time zone NOT NULL,
	boarding_gate char(6) NOT NULL,
	seat_no varchar(3) NOT NULL,
	baggage_id varchar(10) NOT NULL,
	primary key (boarding_id),
	constraint "hw4_boarding_info_passenger_id_fky" FOREIGN key (passenger_id) references hw4_passenger_info(passenger_id),
	constraint "hw4_boarding_info_baggage_id_fky" FOREIGN key (baggage_id) references hw4_baggage(baggage_id)
);

/*========================================================*/
/*aircraft*/
INSERT INTO
	hw4_aircraft
VALUES
	('773', 'Boeing 777-300');

INSERT INTO
	hw4_aircraft
VALUES
	('763', 'Boeing 767-300');

INSERT INTO
	hw4_aircraft
VALUES
	('SU9', 'Boeing 777-300');

INSERT INTO
	hw4_aircraft
VALUES
	('320', 'Boeing 777-300');

INSERT INTO
	hw4_aircraft
VALUES
	('321', 'Boeing 777-300');

/*========================================================*/
insert into
	hw4_airport
values
	(
		'IAH',
		'George Bush International Airport',
		'Houston',
		'CT'
	);

insert into
	hw4_airport
values
	(
		'GLS',
		'Scholes International Airport',
		'Galveston',
		'CT'
	);

insert into
	hw4_airport
values
	(
		'AUS',
		'Austin-Bergstorm International Airport',
		'Austin',
		'CT'
	);

insert into
	hw4_airport
values
	(
		'SAT',
		'San Antonio International Airport',
		'San Antonio',
		'CT'
	);

insert into
	hw4_airport
values
	(
		'DFW',
		'Dallas/Fort Worth International Airport',
		'Dallas',
		'CT'
	);

	

/*========================================================*/
insert into
	hw4_fare_conditions
values
(1, 'economy');

insert into
	hw4_fare_conditions
values
(2, 'business');

insert into
	hw4_fare_conditions
values
(3, 'first class');

/*========================================================*/
insert into
	hw4_flights
values
	(
		1001,
		'PG0001',
		'2020-12-03 12:50:00-06',
		'2020-12-03 01:20:00-06',
		'IAH',
		'GLS',
		'scheduled',
		'773',
		30,
		0,
		80,
		1
	);

insert into
	hw4_flights
values
	(
		1002,
		'PG0002',
		'2020-12-01 00:50:00-06',
		'2020-12-01 02:05:00-06',
		'IAH',
		'AUS',
		'scheduled',
		'763',
		30,
		0,
		500,
		2
	);

insert into
	hw4_flights
values
	(
		1003,
		'PG0003',
		'2020-12-01 00:50:00-06',
		'2020-12-01 02:20:00-06',
		'IAH',
		'SAT',
		'scheduled',
		'SU9',
		30,
		0,
		1400,
		3
	);

insert into
	hw4_flights
values
	(
		1004,
		'PG0004',
		'2020-12-01 00:50:00-06',
		'2020-12-01 03:35:00-06',
		'IAH',
		'DFW',
		'scheduled',
		'320',
		30,
		0,
		80,
		1
	);

insert into
	hw4_flights
values
	(
		1005,
		'PG0005',
		'2020-12-01 00:50:00-06',
		'2020-12-01 01:20:00-06',
		'IAH',
		'GLS',
		'scheduled',
		'321',
		30,
		0,
		500,
		2
	);

insert into
	hw4_flights
values
	(
		1006,
		'PG0006',
		'2020-12-01 00:50:00-06',
		'2020-12-01 02:05:00-06',
		'IAH',
		'AUS',
		'scheduled',
		'773',
		30,
		0,
		1400,
		3
	);

insert into
	hw4_flights
values
	(
		1007,
		'PG0007',
		'2020-12-01 00:50:00-06',
		'2020-12-01 02:20:00-06',
		'IAH',
		'SAT',
		'scheduled',
		'763',
		30,
		0,
		80,
		1
	);

insert into
	hw4_flights
values
	(
		1008,
		'PG0008',
		'2020-12-01 00:50:00-06',
		'2020-12-01 03:35:00-06',
		'IAH',
		'DFW',
		'scheduled',
		'SU9',
		30,
		0,
		500,
		2
	);

insert into
	hw4_flights
values
	(
		1009,
		'PG0009',
		'2020-12-01 00:50:00-06',
		'2020-12-01 01:20:00-06',
		'IAH',
		'GLS',
		'scheduled',
		'320',
		30,
		0,
		1400,
		3
	);

insert into
	hw4_flights
values
	(
		1010,
		'PG0010',
		'2020-12-01 00:50:00-06',
		'2020-12-01 02:05:00-06',
		'IAH',
		'AUS',
		'scheduled',
		'321',
		30,
		0,
		80,
		1
	);

insert into
	hw4_flights
values
	(
		1011,
		'PG0011',
		'2020-12-01 00:50:00-06',
		'2020-12-01 02:20:00-06',
		'IAH',
		'SAT',
		'scheduled',
		'773',
		30,
		0,
		500,
		2
	);

insert into
	hw4_flights
values
	(
		1012,
		'PG0012',
		'2020-12-01 00:50:00-06',
		'2020-12-01 03:35:00-06',
		'IAH',
		'DFW',
		'scheduled',
		'763',
		30,
		0,
		1400,
		3
	);

/*========================================================*/
insert into
	hw4_aircraft_seats
values
	('321', 'M11', 1, 'no');

insert into
	hw4_aircraft_seats
values
	('321', 'M12', 1, 'no');

insert into
	hw4_aircraft_seats
values
	('321', 'M13', 1, 'no');

insert into
	hw4_aircraft_seats
values
	('321', 'M14', 1, 'no');

insert into
	hw4_aircraft_seats
values
	('321', 'M15', 1, 'no');

insert into
	hw4_aircraft_seats
values
	('321', 'M16', 1, 'no');

insert into
	hw4_aircraft_seats
values
	('321', 'M17', 1, 'no');

insert into
	hw4_aircraft_seats
values
	('321', 'M18', 1, 'no');

insert into
	hw4_aircraft_seats
values
	('321', 'M19', 1, 'no');

insert into
	hw4_aircraft_seats
values
	('321', 'M20', 1, 'no');

insert into
	hw4_aircraft_seats
values
	('320', 'L11', 3, 'no');

insert into
	hw4_aircraft_seats
values
	('320', 'L12', 3, 'no');

insert into
	hw4_aircraft_seats
values
	('320', 'L13', 3, 'no');

insert into
	hw4_aircraft_seats
values
	('320', 'L14', 3, 'no');

insert into
	hw4_aircraft_seats
values
	('320', 'L15', 3, 'no');

insert into
	hw4_aircraft_seats
values
	('320', 'L16', 3, 'no');

insert into
	hw4_aircraft_seats
values
	('320', 'L17', 3, 'no');

insert into
	hw4_aircraft_seats
values
	('320', 'L18', 3, 'no');

insert into
	hw4_aircraft_seats
values
	('320', 'L19', 3, 'no');

insert into
	hw4_aircraft_seats
values
	('320', 'L20', 3, 'no');

insert into
	hw4_aircraft_seats
values
	('320', 'K11', 2, 'no');

insert into
	hw4_aircraft_seats
values
	('320', 'K12', 2, 'no');

insert into
	hw4_aircraft_seats
values
	('320', 'K13', 2, 'no');

insert into
	hw4_aircraft_seats
values
	('320', 'K14', 2, 'no');

insert into
	hw4_aircraft_seats
values
	('320', 'K15', 2, 'no');

insert into
	hw4_aircraft_seats
values
	('320', 'K16', 2, 'no');

insert into
	hw4_aircraft_seats
values
	('320', 'K17', 2, 'no');

insert into
	hw4_aircraft_seats
values
	('320', 'K18', 2, 'no');

insert into
	hw4_aircraft_seats
values
	('320', 'K19', 2, 'no');

insert into
	hw4_aircraft_seats
values
	('320', 'K20', 2, 'no');

insert into
	hw4_aircraft_seats
values
	('320', 'J11', 1, 'no');

insert into
	hw4_aircraft_seats
values
	('320', 'J12', 1, 'no');

insert into
	hw4_aircraft_seats
values
	('320', 'J13', 1, 'no');

insert into
	hw4_aircraft_seats
values
	('320', 'J14', 1, 'no');

insert into
	hw4_aircraft_seats
values
	('320', 'J15', 1, 'no');

insert into
	hw4_aircraft_seats
values
	('320', 'J16', 1, 'no');

insert into
	hw4_aircraft_seats
values
	('320', 'J17', 1, 'no');

insert into
	hw4_aircraft_seats
values
	('320', 'J18', 1, 'no');

insert into
	hw4_aircraft_seats
values
	('320', 'J19', 1, 'no');

insert into
	hw4_aircraft_seats
values
	('320', 'J20', 1, 'no');

insert into
	hw4_aircraft_seats
values
	('SU9', 'I11', 3, 'no');

insert into
	hw4_aircraft_seats
values
	('SU9', 'I12', 3, 'no');

insert into
	hw4_aircraft_seats
values
	('SU9', 'I13', 3, 'no');

insert into
	hw4_aircraft_seats
values
	('SU9', 'I14', 3, 'no');

insert into
	hw4_aircraft_seats
values
	('SU9', 'I15', 3, 'no');

insert into
	hw4_aircraft_seats
values
	('SU9', 'I16', 3, 'no');

insert into
	hw4_aircraft_seats
values
	('SU9', 'I17', 3, 'no');

insert into
	hw4_aircraft_seats
values
	('SU9', 'I18', 3, 'no');

insert into
	hw4_aircraft_seats
values
	('SU9', 'I19', 3, 'no');

insert into
	hw4_aircraft_seats
values
	('SU9', 'I20', 3, 'no');

insert into
	hw4_aircraft_seats
values
	('SU9', 'H11', 2, 'no');

insert into
	hw4_aircraft_seats
values
	('SU9', 'H12', 2, 'no');

insert into
	hw4_aircraft_seats
values
	('SU9', 'H13', 2, 'no');

insert into
	hw4_aircraft_seats
values
	('SU9', 'H14', 2, 'no');

insert into
	hw4_aircraft_seats
values
	('SU9', 'H15', 2, 'no');

insert into
	hw4_aircraft_seats
values
	('SU9', 'H16', 2, 'no');

insert into
	hw4_aircraft_seats
values
	('SU9', 'H17', 2, 'no');

insert into
	hw4_aircraft_seats
values
	('SU9', 'H18', 2, 'no');

insert into
	hw4_aircraft_seats
values
	('SU9', 'H19', 2, 'no');

insert into
	hw4_aircraft_seats
values
	('SU9', 'H20', 2, 'no');

insert into
	hw4_aircraft_seats
values
	('SU9', 'G11', 1, 'no');

insert into
	hw4_aircraft_seats
values
	('SU9', 'G12', 1, 'no');

insert into
	hw4_aircraft_seats
values
	('SU9', 'G13', 1, 'no');

insert into
	hw4_aircraft_seats
values
	('SU9', 'G14', 1, 'no');

insert into
	hw4_aircraft_seats
values
	('SU9', 'G15', 1, 'no');

insert into
	hw4_aircraft_seats
values
	('SU9', 'G16', 1, 'no');

insert into
	hw4_aircraft_seats
values
	('SU9', 'G17', 1, 'no');

insert into
	hw4_aircraft_seats
values
	('SU9', 'G18', 1, 'no');

insert into
	hw4_aircraft_seats
values
	('SU9', 'G19', 1, 'no');

insert into
	hw4_aircraft_seats
values
	('SU9', 'G20', 1, 'no');

insert into
	hw4_aircraft_seats
values
	('763', 'F11', 3, 'no');

insert into
	hw4_aircraft_seats
values
	('763', 'F12', 3, 'no');

insert into
	hw4_aircraft_seats
values
	('763', 'F13', 3, 'no');

insert into
	hw4_aircraft_seats
values
	('763', 'F14', 3, 'no');

insert into
	hw4_aircraft_seats
values
	('763', 'F15', 3, 'no');

insert into
	hw4_aircraft_seats
values
	('763', 'F16', 3, 'no');

insert into
	hw4_aircraft_seats
values
	('763', 'F17', 3, 'no');

insert into
	hw4_aircraft_seats
values
	('763', 'F18', 3, 'no');

insert into
	hw4_aircraft_seats
values
	('763', 'F19', 3, 'no');

insert into
	hw4_aircraft_seats
values
	('763', 'F20', 3, 'no');

insert into
	hw4_aircraft_seats
values
	('763', 'E11', 2, 'no');

insert into
	hw4_aircraft_seats
values
	('763', 'E12', 2, 'no');

insert into
	hw4_aircraft_seats
values
	('763', 'E13', 2, 'no');

insert into
	hw4_aircraft_seats
values
	('763', 'E14', 2, 'no');

insert into
	hw4_aircraft_seats
values
	('763', 'E15', 2, 'no');

insert into
	hw4_aircraft_seats
values
	('763', 'E16', 2, 'no');

insert into
	hw4_aircraft_seats
values
	('763', 'E17', 2, 'no');

insert into
	hw4_aircraft_seats
values
	('763', 'E18', 2, 'no');

insert into
	hw4_aircraft_seats
values
	('763', 'E19', 2, 'no');

insert into
	hw4_aircraft_seats
values
	('763', 'E20', 2, 'no');

insert into
	hw4_aircraft_seats
values
	('763', 'D11', 1, 'no');

insert into
	hw4_aircraft_seats
values
	('763', 'D12', 1, 'no');

insert into
	hw4_aircraft_seats
values
	('763', 'D13', 1, 'no');

insert into
	hw4_aircraft_seats
values
	('763', 'D14', 1, 'no');

insert into
	hw4_aircraft_seats
values
	('763', 'D15', 1, 'no');

insert into
	hw4_aircraft_seats
values
	('763', 'D16', 1, 'no');

insert into
	hw4_aircraft_seats
values
	('763', 'D17', 1, 'no');

insert into
	hw4_aircraft_seats
values
	('763', 'D18', 1, 'no');

insert into
	hw4_aircraft_seats
values
	('763', 'D19', 1, 'no');

insert into
	hw4_aircraft_seats
values
	('763', 'D20', 1, 'no');

insert into
	hw4_aircraft_seats
values
	('773', 'C11', 3, 'no');

insert into
	hw4_aircraft_seats
values
	('773', 'C12', 3, 'no');

insert into
	hw4_aircraft_seats
values
	('773', 'C13', 3, 'no');

insert into
	hw4_aircraft_seats
values
	('773', 'C14', 3, 'no');

insert into
	hw4_aircraft_seats
values
	('773', 'C15', 3, 'no');

insert into
	hw4_aircraft_seats
values
	('773', 'C16', 3, 'no');

insert into
	hw4_aircraft_seats
values
	('773', 'C17', 3, 'no');

insert into
	hw4_aircraft_seats
values
	('773', 'C18', 3, 'no');

insert into
	hw4_aircraft_seats
values
	('773', 'C19', 3, 'no');

insert into
	hw4_aircraft_seats
values
	('773', 'C20', 3, 'no');

insert into
	hw4_aircraft_seats
values
	('773', 'B11', 2, 'no');

insert into
	hw4_aircraft_seats
values
	('773', 'B12', 2, 'no');

insert into
	hw4_aircraft_seats
values
	('773', 'B13', 2, 'no');

insert into
	hw4_aircraft_seats
values
	('773', 'B14', 2, 'no');

insert into
	hw4_aircraft_seats
values
	('773', 'B15', 2, 'no');

insert into
	hw4_aircraft_seats
values
	('773', 'B16', 2, 'no');

insert into
	hw4_aircraft_seats
values
	('773', 'B17', 2, 'no');

insert into
	hw4_aircraft_seats
values
	('773', 'B18', 2, 'no');

insert into
	hw4_aircraft_seats
values
	('773', 'B19', 2, 'no');

insert into
	hw4_aircraft_seats
values
	('773', 'B20', 2, 'no');

insert into
	hw4_aircraft_seats
values
	('773', 'A13', 1, 'no');

insert into
	hw4_aircraft_seats
values
	('773', 'A14', 1, 'no');

insert into
	hw4_aircraft_seats
values
	('773', 'A15', 1, 'no');

insert into
	hw4_aircraft_seats
values
	('773', 'A16', 1, 'no');

insert into
	hw4_aircraft_seats
values
	('773', 'A17', 1, 'no');

insert into
	hw4_aircraft_seats
values
	('773', 'A18', 1, 'no');

insert into
	hw4_aircraft_seats
values
	('773', 'A19', 1, 'no');
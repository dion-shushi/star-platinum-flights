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
	airport_code char(3),
	airport_name varchar(40),
	city char(20),
	timezone text,
	PRIMARY KEY (airport_code)
);

create table hw4_fare_conditions(
	fare_id int,
	fare_type varchar(25),
	primary key (fare_id)
);

create table hw4_aircraft_seats(
	aircraft_code char(3),
	seat_no varchar(4),
	fare_id int,
	primary key(aircraft_code, seat_no),
	constraint "hw4_aircraft_seats_aircraft_id_fky" foreign key (aircraft_code) references hw4_aircraft(aircraft_code),
	constraint "hw4_aircraft_seats_fare_id_fky" foreign key (fare_id) references hw4_fare_conditions(fare_id)
);

CREATE TABLE hw4_flights (
	flight_id int,
	flight_no char(6),
	scheduled_departure timestamp with time zone,
	scheduled_arrival timestamp WITH time zone,
	departure_airport char(3),
	arrival_airport char(3),
	status varchar(20),
	aircraft_code char(3),
	seats_available integer NOT NULL,
	seats_booked integer NOT NULL,
	PRIMARY KEY (flight_id),
    CONSTRAINT "hw4_flights_arrival_airport_fkey" FOREIGN KEY (arrival_airport) REFERENCES hw4_airport(airport_code),
    CONSTRAINT "hw4_flights_departure_airport_fkey" FOREIGN KEY (departure_airport) REFERENCES hw4_airport(airport_code)
);

create table hw4_payment(
	payment_id char(6),
	payment_method char(6),
	payment_date timestamp with time zone,
	amount_paid int,
	primary key (payment_id)
);

CREATE TABLE hw4_bookings (
    book_ref character(6) NOT NULL,
    book_date timestamp WITH time zone NOT NULL,
    total_amount numeric(10, 2) NOT NULL,
	payment_id char(6),
    PRIMARY KEY(book_ref),
	constraint "hw4_bookings_payment_id_fky" foreign key (payment_id) references hw4_payment(payment_id)
);

CREATE TABLE hw4_ticket(
    ticket_no char(13) NOT NULL,
    book_ref character(6) NOT NULL,
    passenger_id varchar(20) NOT NULL,
    PRIMARY KEY (ticket_no),
    CONSTRAINT "hw4_ticket_book_ref_fkey" FOREIGN KEY (book_ref) REFERENCES hw4_bookings(book_ref)
);

CREATE TABLE hw4_ticket_flights (
    ticket_no character(13) NOT NULL,
    flight_id integer NOT NULL,
    fare_conditions character varying(10) NOT NULL,
    amount numeric(10, 2) NOT NULL,
    PRIMARY KEY (ticket_no, flight_id),
    CONSTRAINT "hw4_ticket_flights_flight_id_fkey" FOREIGN KEY (flight_id) REFERENCES hw4_flights(flight_id),
    CONSTRAINT "hw4_ticket_flights_ticket_no_fkey" FOREIGN KEY (ticket_no) REFERENCES hw4_ticket(ticket_no),
);

create table hw4_baggage(
	baggage_id varchar(20),
	baggage_claim_no varchar(10),
	baggage_amount int,
	primary key (baggage_id),
	constraint "hw4_passenger_info_baggage_id_fkey" foreign key (baggage_id) references hw4_baggage(baggage_id)
);

create table hw4_passenger_info(
	passenger_id varchar(20),
	passenger_name varchar(40),
	passenger_email char(50),
	passenger_no char(15),
	baggage_id varchar(20),
	PRIMARY KEY(passenger_id),
	constraint "hw4_passenger_info_baggage_id_fkey" foreign key (baggage_id) references hw4_baggage(baggage_id)
);

create table hw4_boarding_info(
	passenger_id varchar(20),
	boarding_time timestamp WITH time zone,
	boarding_gate char(6),
	seat_no char(3),
	baggage_id varchar(10),
	departure_aiport char(3),
	primary key (passenger_id),
	constraint "hw4_boarding_info_baggage_id_fky" FOREIGN key (baggage_id) references hw4_baggage(baggage_id)
);

/*========================================================*/

/*aircraft*/
INSERT INTO hw4_aircraft
VALUES ('773', 'Boeing 777-300');

INSERT INTO hw4_aircraft
VALUES ('763', 'Boeing 767-300');

INSERT INTO hw4_aircraft
VALUES ('SU9', 'Boeing 777-300');

INSERT INTO hw4_aircraft
VALUES ('320', 'Boeing 777-300');

INSERT INTO hw4_aircraft
VALUES ('321', 'Boeing 777-300');

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
	hw4_flights
values
	(
		1001,
		'PG0001',
		'2020-12-01 00:50:00-06',
		'2020-12-01 01:20:00-06',
		'IAH',
		'GLS',
		'scheduled',
		'773',
		50,
		0
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
		50,
		0
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
		50,
		0
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
		50,
		0
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
		50,
		0
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
		50,
		0
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
		50,
		0
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
		50,
		0
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
		50,
		0
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
		50,
		0
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
		50,
		0
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
		50,
		0
	);


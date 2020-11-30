drop table if exists hw4_flights CASCADE;;
drop table if exists hw4_airport CASCADE;;

CREATE TABLE hw4_airport (
	airport_code char(3),
	airport_name varchar(40),
	city char(20),
	timezone text,
	PRIMARY KEY (airport_code)
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


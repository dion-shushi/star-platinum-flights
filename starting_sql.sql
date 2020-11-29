drop table if exists test_flights;
create table test_flights
(
	flight_id integer NOT NULL,
	flight_no character(6) NOT NULL,
	scheduled_departure timestamp WITH time zone NOT NULL,
	scheduled_arrival timestamp WITH time zone NOT NULL,
	departure_airport character(3) NOT NULL,
	arrival_airport character(3) NOT NULL,
	STATUS character varying(20) NOT NULL,
	aircraft_code character(3) NOT NULL,
 	seats_available integer NOT NULL,
	seats_booked integer NOT NULL,
	price integer,
	flight_class character(15) NOT NULL,
	from_city character(15),
	to_city character(15),
	PRIMARY KEY (flight_id)
);

insert into test_flights
values(
		1001,
		'PG0001',
		'2020-12-01 00:50:00-06',
		'2020-12-01 01:20:00-06',
		'IAH',
		'GLS',
		'scheduled',
		'773',
		50,
		0,
		80,
		'economy',
		'houston',
		'galveston'		
);

insert into test_flights
values(
		1002,
		'PG0002',
		'2020-12-01 00:50:00-06',
		'2020-12-01 02:05:00-06',
		'IAH',
		'AUS',
		'scheduled',
		'763',
		50,
		0,
		500,
		'business',
		'houston',
		'austin'
);

insert into test_flights
values(
		1003,
		'PG0003',
		'2020-12-01 00:50:00-06',
		'2020-12-01 02:20:00-06',
		'IAH',
		'SAT',
		'scheduled',
		'SU9',
		50,
		0,
		1400,
		'firstclass',
		'houston',
		'san antonio'
);

insert into test_flights
values(
		1004,
		'PG0004',
		'2020-12-01 00:50:00-06',
		'2020-12-01 03:35:00-06',
		'IAH',
		'DFW',
		'scheduled',
		'320',
		50,
		0,
		80,
		'economy',
		'houston',
		'dallas'
);

insert into test_flights
values(
		1005,
		'PG0005',
		'2020-12-01 00:50:00-06',
		'2020-12-01 01:20:00-06',
		'IAH',
		'GLS',
		'scheduled',
		'321',
		50,
		0,
		500,
		'business',
		'houston',
		'galveston'
);

insert into test_flights
values(
		1006,
		'PG0006',
		'2020-12-01 00:50:00-06',
		'2020-12-01 02:05:00-06',
		'IAH',
		'AUS',
		'scheduled',
		'773',
		50,
		0,
		1400,
		'firstclass',
		'houston',
		'austin'
);

insert into test_flights
values(
		1007,
		'PG0007',
		'2020-12-01 00:50:00-06',
		'2020-12-01 02:20:00-06',
		'IAH',
		'SAT',
		'scheduled',
		'763',
		50,
		0,
		80,
		'economy',
		'houston',
		'san antonio'
);

insert into test_flights
values(
		1008,
		'PG0008',
		'2020-12-01 00:50:00-06',
		'2020-12-01 03:35:00-06',
		'IAH',
		'DFW',
		'scheduled',
		'SU9',
		50,
		0,
		500,
		'business',
		'houston',
		'dallas'
);

insert into test_flights
values(
		1009,
		'PG0009',
		'2020-12-01 00:50:00-06',
		'2020-12-01 01:20:00-06',
		'IAH',
		'GLS',
		'scheduled',
		'320',
		50,
		0,
		1400,
		'firstclass',
		'houston',
		'galveston'
);

insert into test_flights
values(
		1010,
		'PG0010',
		'2020-12-01 00:50:00-06',
		'2020-12-01 02:05:00-06',
		'IAH',
		'AUS',
		'scheduled',
		'321',
		50,
		0,
		80,
		'economy',
		'houston',
		'austin'
);

insert into test_flights
values(
		1011,
		'PG0011',
		'2020-12-01 00:50:00-06',
		'2020-12-01 02:20:00-06',
		'IAH',
		'SAT',
		'scheduled',
		'773',
		50,
		0,
		500,
		'business',
		'houston',
		'san antonio'
);

insert into test_flights
values(
		1012,
		'PG0012',
		'2020-12-01 00:50:00-06',
		'2020-12-01 03:35:00-06',
		'IAH',
		'DFW',
		'scheduled',
		'763',
		50,
		0,
		1400,
		'firstclass',
		'houston',
		'dallas'
);


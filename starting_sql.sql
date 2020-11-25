drop table if exists test_flights;
create table test_flights
(
	flight_id integer NOT NULL,
	flight_class character(10) NOT NULL,
	from_city character(10),
	to_city character(10),
	price integer,
	PRIMARY KEY (flight_id)
);

insert into test_flights
values(
		1004,
		'economy',
		'houston',
		'galveston',
		100
);

insert into test_flights
values(
		1005,
		'business',
		'houston',
		'galveston',
		400
);

insert into test_flights
values(
		1006,
		'economy',
		'galveston',
		'houston',
		300
);

insert into test_flights
values(
		1007,
		'business',
		'galveston',
		'houston',
		400
);

insert into test_flights
values(
		1008,
		'economy',
		'houston',
		'austin',
		300
);
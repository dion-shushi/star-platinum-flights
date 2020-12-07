const express = require('express');
const app = express();
const cors = require('cors');
const pool = require('./db');

// middleware
app.use(cors());
app.use(express.json());

app.post('/sendFlightInfo', async (request, response) => {
  try {
    const from = request.body.from_c;
    const to = request.body.to_c;

    const getFlights = await pool.query(`SELECT * FROM hw4_flights where from_city=($1) and to_city=($2) order by price asc`, [from, to]);
    const res = getFlights.rows;
    // console.log(res);
    response.json(res);
  } catch (err) {
    console.log(err.message);
  }
});

app.post('/grabFlights', async (request, response) => {

  try {
    let from = request.body.from_c;
    let to = request.body.to_c;
    from = from[0].toUpperCase() + from.substring(1, from.length);
    to = to[0].toUpperCase() + to.substring(1, to.length);

    let from_d = request.body.from_d;
    let to_d = request.body.to_d;

    // let aircraft_code = request.body.aircraft_code;
    let fare_id = request.body.fare_id;

    // console.log('from date ' + from_d);
    // console.log(from_d + 1);
    // console.log('to_date ' + to_d);

    const from_ = await pool.query(`SELECT airport_code from hw4_airport where city=($1)`, [from]);
    const to_ = await pool.query(`SELECT airport_code from hw4_airport where city=($1)`, [to]);

    const airport_code_from = from_.rows[0].airport_code;
    const airport_code_to = to_.rows[0].airport_code;

    // console.log('from ' + airport_code_from);
    // console.log('to ' + airport_code_to)

    const airport_cities = await pool.query(
      `select flight_id, scheduled_departure, scheduled_arrival, departure_airport, arrival_airport, base_price from hw4_flights
      where departure_airport = ($1) and arrival_airport = ($2) and scheduled_departure >= ($3) and fare_id = ($4)`,
      [airport_code_from, airport_code_to, from_d, fare_id]);


    response.json(airport_cities.rows);

    // console.log("airportcities.rows")
    let date = '' + airport_cities.rows[0].scheduled_departure;
    // console.log(date);
    // console.log(date.substring(11,18));
    // console.log(airport_cities.rows);
  } catch (err) {
    console.log(err.message);
  }
});

app.post('/flightInfoFromId', async (request, response) => {
  try {
    let flight_id = request.body.flight_id;

    const flights = await pool.query(
      `select * from hw4_flights where flight_id=($1)`,
      [flight_id]);

    response.json(flights.rows);
  } catch (err) {
    console.log(err.message);
  }
});

app.post('/updatePassengerTables', async (req, res) => {
  try {
    const first = req.body.f_name;
    const last = req.body.l_name;
    const email = req.body.email;
    const number = req.body.number;
    const gender = req.body.gender;
    const birth_date = req.body.b_date;

    // console.log(first + ' ' + last + ' ' + email + ' ' + number + ' ' + gender + ' ' + birth_date);

    const newTodo = await pool.query(`INSERT INTO hw4_passenger_info (passenger_first_name, passenger_last_name, passenger_email, passenger_no, passenger_gender, passenger_birth_day) VALUES($1, $2, $3, $4, $5, $6) RETURNING *`,
      [first, last, email, number, gender, birth_date]);
    res.json(newTodo.rows);
  } catch (err) {
    console.log(err.message);
  }
});

app.post('/updatePaymentTable', async (req, res) => {
  try {
    const flight_id = req.body.flight_id;
    const number = req.body.number;
    const cvv = req.body.cvv;
    const date = req.body.date;

    //grab the flight row that is selected from the "available flights" table on the web page
    const flights = await pool.query(
      `select * from hw4_flights where flight_id=($1)`,
      [flight_id]);

    let selected_flight = flights.rows[0];
    // console.log(flight_id);

    //insert into the payment table
    const newTodo = await pool.query(`INSERT INTO hw4_payment (payment_card_number, payment_cvv, payment_date, amount_paid) VALUES($1, $2, $3, $4)`,
      [number, cvv, date, selected_flight.base_price]);

    //return all the seats that are available from the selected flights that are the same class as the selected flight
    //that means that i need to filter the available flights table on the page based on the class that is selcted on the web page
    res.json(newTodo.rows);

  } catch (err) {
    console.log(err.message);
  }
});

app.post("/grabFareId", async (request, response) => {
  try {
    let fare_t = request.body.fare_type;
    
    // fare_t = fare_t[0].toUpperCase() + fare_t.substring(1, fare_t.length);
    console.log(fare_t);
    // console.log(flight_id);
    const fare_row = await pool.query(`SELECT fare_id FROM hw4_fare_conditions WHERE fare_type=($1)`,
      [fare_t]);
    response.json(fare_row.rows[0]);
  } catch (err) {
    console.error(err.message);
  }
})

app.post("/getSelectedFlight", async (request, response) => {
  try {
    const flight_id = request.body.flight_id;
    // console.log(flight_id);
    const the_flight = await pool.query(`SELECT * FROM hw4_flights WHERE flight_id=($1)`,
      [flight_id]);
    response.json(the_flight.rows[0]);
  } catch (err) {
    console.error(err.message);
  }
})

app.post("/displaySeats", async (request, response) => {
  try {
    const aircraft_code = request.body.aircraft_code;
    const fare_id = request.body.fare_id;
    
    console.log(aircraft_code + ' ' + fare_id);

    const the_flight = await pool.query(`SELECT * FROM hw4_aircraft_seats WHERE aircraft_code=($1) and fare_id=($2)`,
      [aircraft_code, fare_id]);
    response.json(the_flight.rows);
  } catch (err) {
    console.error(err.message);
  }
})

app.post("/updateBookingsTable", async (request, response) => {
  try {
    const b_ref = request.body.book_ref;
    const b_date = request.body.book_date;
    const total_amount = request.body.total_amount;
    const payment_id = request.body.payment_id;

    const bookingsQuery = await pool.query(`INSERT INTO hw4_bookings (book_ref, book_date, total_amount, payment_id) VALUES($1, $2, $3, $4)`,
      [b_ref, b_date, total_amount, payment_id]);
    response.json(bookingsQuery.rows);
  } catch (err) {
    console.error(err.message);
  }
})

app.get("/getBookingsTable", async (request, response) => {
  try {
    const bookedQuery = await pool.query(`SELECT * FROM hw4_bookings`);
    response.json(bookedQuery.rows);
  } catch (err) {
    console.error(err.message);
  }
}) 

// set up the server listening at port 5000 (the port number can be changed)
app.listen(5000, () => {
  console.log("server has started on port 5000");
});
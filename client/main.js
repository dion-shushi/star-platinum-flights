// set global variable for all the flights
let availableFlights = []

// function to set the global variable to the returned flights
const setAvailableFlights = (data) => {
  availableFlights = data;
}

let selectedFlight = [];

let basicFlightInfo = {
  flying_from: '',
  flying_to: '',
  departure_date: '',
  arrival_date: '',
  return_date: '',
  departure_airport: '',
  arrival_airport: '',
  return_arrival_date: '',
  flight_class: '',
  price: '',
  number_of_passengers: ''
}

let paymentInfo = {
  payment_card_number: '',
  payment_cvv: '',
  payment_date: '',
  amount_paid: ''
}

let bookingsInfo = {
  book_ref: '',
  book_date: '',
  total_amount: '',
  payment_id: ''
}

let passengersInfo = [
  {
    passenger_first_name: '',
    passenger_last_name: '',
    passenger_email: '',
    passenger_no: '',
    passenger_gender: '',
    passenger_birth_day: ''
  }
]

let ticketInfo = [
  {
    ticket_no: '',
    book_ref: '',
    passenger_id: ''
  }
]

let baggageInfo = {
  baggage_id: '',
  baggage_claim_no: '',
  baggage_amount: ''
}

// function to display all the returned flights
const displayTodos = () => {

  const dynamicTable = document.getElementById("dynamic-table");
  var toAdd = "<div id='available-flights'>";
  toAdd += "<div id='table-title'></div>";
  toAdd += "<table class='table' id='result-list'>";
  toAdd += "<tbody id='result-table'></tbody>";
  toAdd += "</table></div>";

  dynamicTable.innerHTML = toAdd;

  const resultTable = document.querySelector('#result-table');

  const result_list = document.getElementById("table-title");
  result_list.innerHTML = "<div id='table-title'>Available Flights</div>";

  const from = document.getElementById('from_location').value;
  const to = document.getElementById('to_location').value;

  // display all flights by modifying the HTML in "result-table"
  let tableHTML = "";
  availableFlights.map(flight => {
    let date = new Date(flight.scheduled_departure);
    tableHTML +=
      `<tr key=${flight.flight_id} id="clickable" onClick=flightClicked(${flight.flight_id}) data-toggle="modal" data-target="#firstModalID">
    <th>${from}</th>
    <th>${to}</th>
    <th>${date.getUTCHours() - 6}:${date.getUTCMinutes()} PM</th>
    <th>${flight.base_price}</th>
    </tr>`;
  })

  resultTable.innerHTML = tableHTML;
}

async function setSelectedFlight(flightID) {
  const body = {
    flight_id: flightID
  }

  try {
    const response = await fetch("http://localhost:5000/getSelectedFlight", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(body)
    });
    const jsonData = await response.json();
    // console.log(jsonData)
    selectedFlight = jsonData;
  } catch (err) {
    console.log(err.message);
  }
}

async function displayCities() {
  const flight_class = document.getElementById('flight_class').value;
  const from_city = document.getElementById('from_location').value;
  const to_city = document.getElementById('to_location').value;
  const from_date = document.getElementById('departure').value;
  // var nDate = new Date(from_date);
  // console.log(nDate.getDate());
  const to_date = document.getElementById('return').value;
  let fare_id = 0;

  //grab the class_id from the hw4_fare_conditions table

  try {
    const body = {
      fare_type: flight_class
    };

    const response = await fetch("http://localhost:5000/grabFareId", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(body)
    });

    const jsonData = await response.json();
    fare_id = jsonData.fare_id;
    // console.log(fare_id);
  } catch (err) {
    console.log(err.message);
  }

  try {
    const body = {
      from_c: from_city,
      to_c: to_city,
      from_d: from_date,
      to_d: to_date,
      fare_id: fare_id
    };
    const response = await fetch("http://localhost:5000/grabFlights", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(body)
    });
    // response.json() is the returned array
    const jsonData = await response.json();

    setAvailableFlights(jsonData);
    displayTodos();
    // console.log(jsonData);

  } catch (err) {
    console.log(err.message);
  }
}

async function flightClicked(flight_id) {
  await setSelectedFlight(flight_id);
  const modalHeader = document.querySelector('#firstModalTitleId');
  const modalBody = document.querySelector('.modal-body');

  const from_city = document.getElementById('from_location').value;
  const to_city = document.getElementById('to_location').value;

  const from_date = document.getElementById('departure').value;
  const to_date = document.getElementById('return').value;

  const people_numbers = document.getElementById('people_num').value;

  console.log(selectedFlight);

  basicFlightInfo.flying_from = from_city;
  basicFlightInfo.flying_to = to_city;
  basicFlightInfo.departure_date = selectedFlight.scheduled_departure;
  basicFlightInfo.return_date = selectedFlight.scheduled_arrival;
  basicFlightInfo.departure_airport = selectedFlight.departure_airport;
  basicFlightInfo.arrival_airport = selectedFlight.arrival_airport;
  basicFlightInfo.number_of_passengers = people_numbers;
  basicFlightInfo.flight_class - selectedFlight.fare_id;
  basicFlightInfo.price = selectedFlight.base_price;

  modalHeader.innerHTML = `${basicFlightInfo.departure_airport} -> ${basicFlightInfo.arrival_airport}`;
  let date = new Date(basicFlightInfo.departure_date);
  // console.log(date.getUTCHours() - 6 + ':' + date.getUTCMinutes());

  modalBody.innerHTML = `Flying from ${basicFlightInfo.flying_from} to ${basicFlightInfo.flying_to} at ${date.getUTCHours() - 6}:${date.getUTCMinutes()} PM`;
}

async function goToPaymentPage() {
  const first_name = document.getElementById('passengerFirstName').value;
  const last_name = document.getElementById('passengerLastName').value;
  const email_address = document.getElementById('passengerEmail').value;
  const phone_number = document.getElementById('passengerNumber').value;
  const birth_date = document.getElementById('passengerBirthDate').value;
  
  let gender = '';
  const rbs = document.querySelectorAll('input[name="sex"]');
  for (const rb of rbs) {
    if (rb.checked) {
      gender = rb.value;
      break;
    }
  }

  passengersInfo.passenger_first_name = first_name;
  passengersInfo.passenger_last_name = last_name;
  passengersInfo.passenger_email = email_address;
  passengersInfo.passenger_no = phone_number;
  passengersInfo.passenger_gender = gender;
  passengersInfo.passenger_birth_day = birth_date;


  const body = {
    f_name: first_name,
    l_name: last_name,
    email: email_address,
    number: phone_number,
    gender: gender,
    b_date: birth_date
  }

  try {
    const response = await fetch("http://localhost:5000/updatePassengerTables", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(body)
    });

    const jsonData = await response.json();
    // console.log(jsonData);

  } catch (err) {
    console.log(err.message);
  }
}

async function goToSelectSeatsPage() {
  const credit_number = document.getElementById('creditCardNum').value;
  const credit_cvv = document.getElementById('creditCardCVV').value;
  const current_date = new Date();

  paymentInfo.payment_card_number = credit_number;
  paymentInfo.payment_cvv = credit_cvv;
  paymentInfo. payment_date = current_date;
  paymentInfo.amount_paid = basicFlightInfo.price;

  const body = {
    flight_id: selectedFlight.flight_id,
    number: credit_number,
    cvv: credit_cvv,
    date: current_date
  }

  try {
    const response = await fetch("http://localhost:5000/updatePaymentTable", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(body)
    });

    const jsonData = await response.json();
    // console.log(jsonData);

  } catch (err) {
    console.log(err.message);
  }

  //display all the seats that are available on the aircraft for the flight selected
  displaySeats();
}

async function displaySeats() {
  let avalilableSeats = [];
  try {
    const body = {
      aircraft_code: selectedFlight.aircraft_code,
      fare_id: selectedFlight.fare_id
    }
    const response = await fetch("http://localhost:5000/displaySeats", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(body)
    });

    const jsonData = await response.json();
    console.log(jsonData);
    avalilableSeats = jsonData;

  } catch (err) {
    console.log(err.message);
  }

  const dynamicSeatsTable = document.getElementById("dynamic-seats-table");
  var toAdd = "<div id='available-seats'>";
  toAdd += "<div id='seats-table-title'></div>";
  toAdd += "<table class='table' id='result-seats-list'>";
  toAdd += "<tbody id='result-seats-table'></tbody>";
  toAdd += "</table></div>";

  dynamicSeatsTable.innerHTML = toAdd;

  const resultSeatsTable = document.querySelector('#result-seats-table');

  const resultSeatslist = document.getElementById("seats-table-title");
  resultSeatslist.innerHTML = "<div id='table-title'>Pick</div>";

  // display all flights by modifying the HTML in "result-table"

  let seatsTableHTML = `<select name="picked-seats" id="selected-seats" class="seatsButton">`;
  avalilableSeats.map(seat => {
    seatsTableHTML +=
      `<option value="${seat.seat_no}"> ${seat.seat_no} </option>`;
  })
  seatsTableHTML += `</select>`;

  resultSeatsTable.innerHTML = seatsTableHTML;
}

async function goToReviewPage() {
  const seatNum = document.getElementById('selected-seats').value;
  console.log('seat picked ' + seatNum);
  const reviewModal = document.getElementById('review-modal-body');

  reviewModal.innerHTML = `<div>${seatNum} is picked for flight ${selectedFlight.flight_id}</div>`
}

async function goToBookTicketsPage() {
  const body = {
    book_ref: 'ABC124',
    book_date: new Date(),
    total_amount: basicFlightInfo.price,
    payment_id: 1
  }
  try{
    const response = await fetch("http://localhost:5000/updateBookingsTable", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(body)
    });

    const jsonData = await response.json();
    console.log(jsonData);
  } catch (err){
    console.log(err.message);
  }
}

async function displayBookedFlights(){
  const response = await fetch("http://localhost:5000/getBookingsTable", {
    method: "GET",
    headers: { "Content-Type": "application/json" }
  });
  const jsonData = await response.json();

  console.log(jsonData);
}

async function goToArt() {
  window.open(
    "https://www.reddit.com/r/StardustCrusaders/comments/fzz2o6/fanart_star_platinum_the_world/", "_blank");
}
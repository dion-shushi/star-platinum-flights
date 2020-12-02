// set global variable for all the flights
let availableFlights = []

// function to set the global variable to the returned flights
const setAvailableFlights = (data) => {
  availableFlights = data;
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
      `<tr key=${flight.flight_id} id="clickable" onClick=clicked(${flight.flight_id}) data-toggle="modal" data-target="#firstModalID">
    <th>${from}</th>
    <th>${to}</th>
    <th>${date.getUTCHours()-6}:${date.getUTCMinutes()} PM</th>
    <th>${flight.base_price}</th>
    </tr>`;
  })

  resultTable.innerHTML = tableHTML;
}

async function clicked(flight_id) {
  console.log(flight_id);
  const modalHeader = document.querySelector('#firstModalTitleId');
  const modalBody = document.querySelector('.modal-body');

  const from_city = document.getElementById('from_location').value;
  const to_city = document.getElementById('to_location').value;

  const from_date = document.getElementById('departure').value;
  var nDate = new Date(from_date);
  console.log(nDate.getDate());
  const to_date = document.getElementById('return').value;
  try {
    const body = {
      flight_id: flight_id
    };
    const response = await fetch("http://localhost:5000/flightInfoFromId", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(body)
    });
    // response.json() is the returned array
    const jsonData = await response.json();

    modalHeader.innerHTML = `${jsonData[0].departure_airport} -> ${jsonData[0].arrival_airport}`;
    let date = new Date(jsonData[0].scheduled_departure);
    console.log(date.getUTCHours()-6 + ':' + date.getUTCMinutes());

    modalBody.innerHTML = `Flying from ${from_city} to ${to_city} at ${date.getUTCHours()-6}:${date.getUTCMinutes()} PM`;
    console.log(jsonData);

  } catch (err) {
    console.log(err.message);
  }
}

async function displayWithFilter() {
  // grab the value that is in the the dropdown with the id "from_location"
  const from_city = document.getElementById('from_location').value;
  const to_city = document.getElementById('to_location').value;

  const from_date = document.getElementById('departure');
  const to_date = document.getElementById('return');

  // try... catch... to catch error
  // POST request that sends the variable "city" from above to the link "/sendFlightInfo"
  // returns an array of all the rows that are flying from "city"
  try {
    const body = {
      from_c: from_city,
      to_c: to_city
    };
    const response = await fetch("http://localhost:5000/sendFlightInfo", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(body)
    });
    // response.json() is the returned array
    const jsonData = await response.json();
    console.log(jsonData);
    setAvailableFlights(jsonData);
    displayTodos();

  } catch (err) {
    console.log(err.message);
  }
}

async function displayCities() {
  const from_city = document.getElementById('from_location').value;
  const to_city = document.getElementById('to_location').value;
  const from_date = document.getElementById('departure').value;
  var nDate = new Date(from_date);
  console.log(nDate.getDate());
  const to_date = document.getElementById('return').value;
  try {
    const body = {
      from_c: from_city,
      to_c: to_city,
      from_d: from_date,
      to_d: to_date
    };
    const response = await fetch("http://localhost:5000/grabFlights", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(body)
    });
    // response.json() is the returned array
    const jsonData = await response.json();

    let arrayOfData = [
      {
        from_airport: jsonData[0].departure_airport,
        to_airport: jsonData[0].arrival_airport
      }
    ]

    const departure_date_input = document.getElementById('departure').value;
    console.log(departure_date_input);

    // console.log(arrayOfData);
    console.log(jsonData);

    setAvailableFlights(jsonData);
    displayTodos();
    // console.log(jsonData);

  } catch (err) {
    console.log(err.message);
  }
}

async function goToPassengerInfoPage(){

}
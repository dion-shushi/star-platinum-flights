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

  // display all flights by modifying the HTML in "result-table"
  let tableHTML = "";
  availableFlights.map(flight => {
    tableHTML +=
      `<tr key=${flight.flight_id} id="clickable" onClick=clicked(${flight.flight_id}) data-toggle="modal" data-target="#myModal">
    <th>${flight.from_city}</th>
    <th>${flight.to_city}</th>
    <th>${flight.price}</th>
    </tr>`;
  })

  resultTable.innerHTML = tableHTML;
}

function clicked(flightId) {
  console.log("clicked " + flightId);
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

async function displayCity() {
  const from_city = document.getElementById('from_location').value;
  const to_city = document.getElementById('to_location').value;
  try {
    const body = {
      from_c: from_city,
      to_c: to_city
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

    console.log(arrayOfData);

    // setAvailableFlights(jsonData);
    // displayTodos();
    // console.log(jsonData);

  } catch (err) {
    console.log(err.message);
  }
}

// insert a new todo
async function insertTodo() {
  // read the todo description from input
  const description = document.querySelector('#todo-description').value;
  // console.log(description);

  // use try... catch... to catch error
  try {

    // insert new todo to "http://localhost:5000/todos", with "POST" method
    const body = { description: description };
    const response = await fetch("http://localhost:5000/todos", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(body)
    });

    // refresh the page when inserted
    location.reload();
    return false;

  } catch (err) {
    console.log(err.message);
  }
}

// delete a todo by id
async function deleteTodo(id) {
  try {
    // delete a todo from "http://localhost:5000/todos/${id}", with "DELETE" method
    const deleteTodo = await fetch(`http://localhost:5000/todos/${id}`, {
      method: "DELETE"
    })

    // refresh the page when deleted
    location.reload();
    return false;

  } catch (err) {
    console.log(err.message);
  }
}

// update a todo description
async function updateTodo(id) {

  const description = document.querySelector('#edited-description').value;
  // console.log(description);
  // console.log(id);

  try {
    // update a todo from "http://localhost:5000/todos/${id}", with "PUT" method
    const body = { description };
    const response = await fetch(`http://localhost:5000/todos/${id}`, {
      method: "PUT",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(body)
    })

    // refresh the page when updated
    location.reload();
    return false;

  } catch (err) {
    console.log(err.message);
  }
}

async function goToArt() {
  window.open(
    "https://www.reddit.com/r/StardustCrusaders/comments/fzz2o6/fanart_star_platinum_the_world/", "_blank");
}
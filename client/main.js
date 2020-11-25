// set global variable for all the flights
let availableFlights = []

// function to set the global variable to the returned flights
const setAvailableFlights = (data) => {
  availableFlights = data;
}


// function to display all the returned flights
const displayTodos = () => {
  const resultTable = document.querySelector('#result-table');
  const from = document.getElementById('from_location');
  const to = document.getElementById('to_location');


  // display all flights by modifying the HTML in "result-table"
  let tableHTML = "";
  availableFlights.map(flight => {
    tableHTML +=
      `<tr key=${flight.flight_id}>
    <th>${flight.from_city}</th>
    <th>${flight.to_city}</th>
    <th>${flight.price}</th>
    </tr>`;
  })
  resultTable.innerHTML = tableHTML;
}

async function displayWithFilter() {
  // grab the value that is in the the dropdown with the id "from_location"
  const city = document.getElementById('from_location').value;

  // try... catch... to catch error
  // POST request that sends the variable "city" from above to the link "/sendFlightInfo"
  // returns an array of all the rows that are flying from "city"
  try {
    const body = { city: city };
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
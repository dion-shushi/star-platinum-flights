// set global variable todos
let todos = []

// function to set todos
const setTodos = (data) => {
  todos = data;
}

// function edit todo
const editTodo = (id) => {

  const descrip = todos.filter(todo => todo.todo_id === id)[0].description;
  document.querySelector('#edited-description').value = descrip;
  document.querySelector('#save-edit-description').addEventListener("click", function() {updateTodo(id)});

}

// function to display todos
const displayTodos = () => {
  const todoTable = document.querySelector('#todo-table');
  const from = document.getElementById('from_location');
  const to = document.getElementById('to_location');
  

  // display all todos by modifying the HTML in "todo-table"
  let tableHTML = "";
  todos.map(todo =>{
    tableHTML +=
    `<tr key=${todo.todo_id}>
    <th>${todo.description}</th>
    <th><button class="btn btn-warning" type="button" data-toggle="modal" data-target="#edit-modal" onclick="editTodo(${todo.todo_id})">Edit</button></th>
    <th><button class="btn btn-danger" type="button" onclick="deleteTodo(${todo.todo_id})">Delete</button></th>
    </tr>`;
  })
  todoTable.innerHTML = tableHTML;
}

async function displayWithFilter(){
  // read the todo description from input
  const city = document.getElementById('from_location').value;
  // console.log(passenger_count);
  // console.log(description);

  // use try... catch... to catch error
  try {

    // insert new todo to "http://localhost:5000/todos", with "POST" method
    const body = { city: city };
    const response = await fetch("http://localhost:5000/sendFlightInfo", {
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


// select all the todos when the codes first run
selectTodo();


// The following are async function to select, insert, update and delete todos
// select all the todos
async function selectTodo() {
  // use try... catch... to catch error
  try {

    // GET all todos from "http://localhost:5000/todos"
    const response = await fetch("http://localhost:5000/todos")
    const jsonData = await response.json();

    setTodos(jsonData);
    // displayTodos();

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

async function print(){
  const response = await fetch("http://localhost:5000/get", {
    method: "GET",
    headers: { "Content-Type": "application/json" }
  });
  console.log(response.message);
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
    const body = {description};
    const response = await fetch(`http://localhost:5000/todos/${id}`, {
      method: "PUT",
      headers: {"Content-Type": "application/json"},
      body: JSON.stringify(body)
    })

    // refresh the page when updated
    location.reload();
    return false;

  } catch (err) {
    console.log(err.message);
  }
}

async function goToArt(){
    window.open( 
        "https://www.reddit.com/r/StardustCrusaders/comments/fzz2o6/fanart_star_platinum_the_world/", "_blank"); 
}
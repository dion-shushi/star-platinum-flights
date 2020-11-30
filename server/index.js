const express = require('express');
const app = express();
const cors = require('cors');
const pool = require('./db');

// middleware
app.use(cors());
app.use(express.json());      //req.body

//ROUTES

//insert a todo
app.post('/todos', async (req, res) => {
  try {
    const { description } = req.body;
    const newTodo = await pool.query(`INSERT INTO todo (description) VALUES($1) RETURNING *`,
      [description]);
    res.json(newTodo);
  } catch (err) {
    console.log(err.message);
  }
});

app.post('/sendFlightInfo', async (request, response) => {
  try {
    const from = request.body.from_c;
    const to = request.body.to_c;

    const getFlights = await pool.query(`SELECT * FROM hw4_flights where from_city=($1) and to_city=($2) order by price asc`, [from, to]);
    const res = getFlights.rows;
    console.log(res);
    response.json(res);
  } catch (err) {
    console.log(err.message);
  }
});

app.post('/grabFlights', async (request, response) => {

  try{
    let from = request.body.from_c;
    let to = request.body.to_c;
    from = from[0].toUpperCase() + from.substring(1,from.length);
    to = to[0].toUpperCase() + to.substring(1,to.length);
    console.log('from ' + from);
    console.log('to ' + to)
  
    const from_ = await pool.query(`SELECT airport_code from hw4_airport where city=($1)`, [from]);
    const to_ = await pool.query(`SELECT airport_code from hw4_airport where city=($1)`, [to]);
  
    const airport_code_from = from_.rows[0].airport_code;
    const airport_code_to = to_.rows[0].airport_code;
  
    const airport_cities = await pool.query(`SELECT * from hw4_flights where departure_airport=($1) and arrival_airport=($2)`, [airport_code_from, airport_code_to]);
  
    response.json(airport_cities.rows);
  
    console.log(airport_cities.rows);
  } catch (err){
    console.log(err.message);
  }
});

//get all todo
app.get('/todos', async (req, res) => {
  try {
    const allTodos = await pool.query(`SELECT * FROM todo`);
    res.json(allTodos.rows);
  } catch (err) {
    console.log(err.message);
  }
});

//get a todo by id
app.get('/todos/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const todo = await pool.query(`SELECT * FROM todo 
                                   WHERE todo_id = $1`,
      [id]);
    res.json(todo.rows);
  } catch (err) {
    console.log(err.message);
  }
});

//update a todo by id
app.put("/todos/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const { description } = req.body;
    const updateTodo = await pool.query(`UPDATE todo SET description = $1 
                                         WHERE todo_id = $2`,
      [description, id]);
    res.json("Todo was updated!");
  } catch (err) {
    console.error(err.message);
  }
});

//delete a todo by id
app.delete("/todos/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const deleteTodo = await pool.query(`DELETE FROM todo 
                                         WHERE todo_id = $1`,
      [id]);
    res.json("Todo was deleted!");
  } catch (err) {
    console.log(err.message);
  }
});

// set up the server listening at port 5000 (the port number can be changed)
app.listen(5000, () => {
  console.log("server has started on port 5000");
});
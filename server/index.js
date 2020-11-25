const express = require('express');
const app = express();
const cors = require('cors');
const pool = require('./db');

// middleware
app.use(cors());
app.use(express.json());      //req.body

//ROUTES

//insert a todo
app.post('/todos', async(req, res)=>{
  try{
    const {description} = req.body;
    const newTodo = await pool.query(`INSERT INTO todo (description) VALUES($1) RETURNING *`,
      [description]);
    res.json(newTodo);
  } catch(err){
    console.log(err.message);
  }
});

app.post('/sendFlightInfo', async(request, response) => {
  try{
    const filter = request.body.city;
    const getFlights = await pool.query(`SELECT * FROM test_flights where from_city=($1)`, [filter]);
    const res = getFlights.rows;
    console.log(res);
    response.json(res);
  } catch(err){
    console.log(err.message);
  }
});
//   console.log('req');
//   console.log(request.body);
//   pool.query('SELECT * FROM test_flights', (err, res) => {
//     if (err) {
//       console.log(err.stack)
//     } else {
//       response.json(res.rows);
//     }
//   })
// })

app.get('/get', async(req,res)=>{
  res.send("sending data");
})

//get all todo
app.get('/todos', async(req, res)=>{
  try{
    const allTodos = await pool.query(`SELECT * FROM todo`);
    res.json(allTodos.rows);
  } catch(err){
    console.log(err.message);
  }
});

//get a todo by id
app.get('/todos/:id', async(req, res)=>{
  try{
    const { id } = req.params;
    const todo = await pool.query(`SELECT * FROM todo 
                                   WHERE todo_id = $1`, 
      [id]);
    res.json(todo.rows);
  } catch(err){
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
app.listen(5000, ()=>{
  console.log("server has started on port 5000");
});
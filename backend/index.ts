import mongoose from "mongoose";
const bodyParser = require("body-parser");
const cors = require("cors");
const express = require("express");
require("dotenv").config();

const app = express();
const server = require("http").createServer(app);

const DB_URL = process.env.DB_URL || "mongodb://localhost:27017/swayamraksha";

mongoose
  .connect(DB_URL)
  .then(() => {
    console.log("Connected to DB");
  })
  .catch((err: any) => {
    console.log("Error while connecting DB", err);
  });

app.get("/", (req: any, res: any) => {
  return res.send("Hello World!");
});

app.use(express.json());
app.use(cors());
app.use(bodyParser.json());
app.use(
  bodyParser.urlencoded({
    extended: true,
  })
);

const logger = (req: any, res: any, next: any) => {
  console.log("Path:", req.path);
  console.log("Body:", req.body);
  next();
};

app.use(logger);

require("./startup/route")(app);

const PORT = process.env.PORT || 3000;

server.listen(PORT, () => {
  console.log("Server running on port localhost:3000");
});

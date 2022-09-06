var fs = require('fs');
const https = require('https');
const express = require('express');
const app = express();
const path = require('path');

app.use('/public', express.static(path.resolve('./components/home/public/')));

app.set("views", path.join(__dirname, "views"));
app.set("view engine", "ejs");

app.get("/", (req, res) => {
	res.render("home", {
	});
});

app.listen(process.env.HOME_PORT);
console.log(`Home running on ${process.env.HOME_PORT}`)
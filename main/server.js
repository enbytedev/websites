var fs = require('fs');
const https = require('https');
const express = require('express');
const app = express();
const path = require('path');

app.use(express.static('public'));

app.set("views", path.join(__dirname, "views"));
app.set("view engine", "ejs");

app.get("/", (req, res) => {
	res.render("home", {
	});
});

app.get("/banner", (req, res) => {
	var banner = new Array("banner/bash1.png", 
		"banner/bash2.png",
		"banner/html1.png",
		"banner/python1.png",
		"banner/java1.png",
		"banner/java2.png",
		"banner/java3.png",
		"banner/java4.png",
		"banner/js1.png",
		"banner/js2.png",
		"banner/js3.png",
		"banner/js4.png");
	var rNum = Math.floor(Math.random() * banner.length);
	res.set('cache-control', 'no-cache,max-age=0,no-store,s-maxage=0,proxy-revalidate')
	res.sendFile(banner[rNum], { root: "."});
});

app.listen(3100);
console.log("Homepage running on port 3100")
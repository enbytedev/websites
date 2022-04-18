var fs = require('fs');
const https = require('https');
const express = require('express');
const app = express();
const matter = require('gray-matter');
const path = require('path');
const {port} = require('./config.json');

app.use(express.static('public'));

var bodyParser = require("body-parser");
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.set("views", path.join(__dirname, "views"));
app.set("view engine", "ejs");

app.get("/:article", (req, res) => {

        if (req.params.article = favicon.ico) {
                return
        } else {
                // read the markdown file
                const file = matter.read(__dirname + '/articles/' + req.params.article + '.md');
                
                // use markdown-it to convert content to HTML
                var md = require("markdown-it")();
                let content = file.content;
                var result = md.render(content);
                
                res.render("index", {
                        post: result,
                        title: file.data.title,
                        description: file.data.description,
                });
        }
});

app.get("/", (req, res) => {
        const legacy = fs.readdirSync(__dirname + '/articles/').filter(file => file.startsWith('legacy-'));
        const current = fs.readdirSync(__dirname + '/articles/').filter(file => file.startsWith('current-'));
        res.render("home", {
                legacy: legacy,
                current: current
        });
});

app.listen(port);
console.log(`A-Wiki listening on port ${port}!`)

const express = require("express");
const app = express();
const {port} = require('./config.json');
const initRoutes = require("./func/routing");
global.__basedir = __dirname;
app.use(express.urlencoded({ extended: true }));
app.use(express.static(__dirname + '/public'));
app.set('views', __dirname + '/public/dist');
app.engine('html', require('ejs').renderFile);
initRoutes(app);
// Open app.
app.listen(port, () => {
  console.log(`Version Checker started successfully on port ${port}!`);
});
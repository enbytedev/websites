const config = require("../config.json");
const fs = require('fs');

/*

Info route

*/
const info = async (req, res) => {
  const requestName = req.params.name;
  const directoryPath = __basedir + "/public/info/";
  res.sendFile(directoryPath + requestName, requestName, (err) => {
//  res.status(500).send({
//    message: `Info on ${requestName} does not exist in this server's content datastore!`,
//  });
  });
};

/*

Docs route

*/
const docs = async (req, res) => {
  const requestName = req.params.name;
  const directoryPath = __basedir + "/public/docs/";
  if (req.params.name == "nodejs" || requestName == "node") {
    res.render(directoryPath + "nodejs.html")
  } else {
    res.render(directoryPath + "notfound.html")
  }
  res.sendFile(directoryPath + requestName, requestName, (err) => {
//  res.status(500).send({
//    message: `Docs about ${requestName} does not exist in this server's content datastore!`,
//  });
  });
};

/*

dist route

*/
const dist = async (req, res) => {
  const requestName = req.params.name;
  const directoryPath = __basedir + "/public/dist/";
  res.download(directoryPath + requestName, requestName, (err) => {
//  res.status(500).send({
//    message: `The distribution ${requestName} does not exist in this server's content datastore!`,
//  });
  });
};

module.exports = {
  info,
  docs,
  dist,
};
const express = require("express");
const router = express.Router();
const controller = require("./control");
const rateLimit = require('express-rate-limit')
 
const accessLimit = rateLimit({
    windowMs: 5 * 60 * 1000,
    max: 10,
    standardHeaders: true,
    legacyHeaders: false,
    message: 'Too many requests created from this IP, please try again after 5 minutes!',
})

let routes = (app) => {
    router.get("/info/:name", accessLimit, controller.info);
    router.get("/docs/:name", accessLimit, controller.docs);
    router.get("/dist/:name", accessLimit, controller.dist);
    
    app.use(router);
};
module.exports = routes;
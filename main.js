require('dotenv').config()

console.log("Starting all services with defined ports:\n")

if (process.env.HOME_PORT != "") {
    require("./components/home/app.js")
}

if (process.env.SERVICES_PORT != "") {
    require("./components/services/app.js")
}

if (process.env.CDN_PORT != "") {
    require("./components/cdn/app.js")
}
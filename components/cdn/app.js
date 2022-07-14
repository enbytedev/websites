var fs = require('fs');
const https = require('https');
const express = require('express');
const app = express();
const path = require('path');

app.use(express.static('assets/static'));

const bannerPath = "./components/cdn/assets/banner"
app.get("/banner", (req, res) => {
	var banner = new Array(`${bannerPath}/bash1.png`, 
        `${bannerPath}/bash2.png`,
		`${bannerPath}/html1.png`,
		`${bannerPath}/python1.png`,
		`${bannerPath}/java1.png`,
		`${bannerPath}/java2.png`,
		`${bannerPath}/java3.png`,
		`${bannerPath}/java4.png`,
		`${bannerPath}/js1.png`,
		`${bannerPath}/js2.png`,
		`${bannerPath}/js3.png`,
		`${bannerPath}/js4.png`);
	var rNum = Math.floor(Math.random() * banner.length);
	res.set('cache-control', 'no-cache,max-age=0,no-store,s-maxage=0,proxy-revalidate')
	res.sendFile(banner[rNum], { root: "."});
});

app.listen(process.env.CDN_PORT);
console.log(`CDN running on ${process.env.CDN_PORT}`)
var fs = require('fs');
const https = require('https');
const express = require('express');
const app = express();
const path = require('path');

app.use(express.static(__dirname + '/public'));

const cdnPath = "./components/cdn/assets"
app.get("/banner", (req, res) => {
	var banner = new Array(`${cdnPath}/banner/bash1.png`, 
        `${cdnPath}/banner/bash2.png`,
		`${cdnPath}/banner/html1.png`,
		`${cdnPath}/banner/python1.png`,
		`${cdnPath}/banner/java1.png`,
		`${cdnPath}/banner/java2.png`,
		`${cdnPath}/banner/java3.png`,
		`${cdnPath}/banner/java4.png`,
		`${cdnPath}/banner/js1.png`,
		`${cdnPath}/banner/js2.png`,
		`${cdnPath}/banner/js3.png`,
		`${cdnPath}/banner/js4.png`);
	var rNum = Math.floor(Math.random() * banner.length);
	res.set('cache-control', 'no-cache,max-age=0,no-store,s-maxage=0,proxy-revalidate')
	res.sendFile(banner[rNum], { root: "."});
});

app.get("/", (req, res) => {
	res.sendFile(`${cdnPath}/scripts/install.sh`, { root: "."});
});

app.listen(process.env.CDN_PORT);
console.log(`CDN running on ${process.env.CDN_PORT}`)
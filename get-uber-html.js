// The Uber webpage listing city name slugs is written in JavaScript
// so traditional scraping methods don't work. We're going to use phantomjs to download it instead.
// This code adapted from the example at https://www.thedataschool.co.uk/brian-scally/web-scraping-javascript-content/

var url = 'https://movement.uber.com/cities?lang=en-US'; 

var page = new WebPage(); 
var fs = require('fs'); 

page.open(url, function (status) { 
just_wait(); }); 

function just_wait() { 
setTimeout(function() { 
fs.write('uber_cities.html', 
page.content, 'w'); 
phantom.exit(); }, 2500); 
}
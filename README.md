# Uber movement data scraping
 This repository contains several scripts for scraping data using the Uber Movement Data Toolkit for further analysis and research.

### Requirements

[Uber Movement Data Toolkit](https://www.npmjs.com/package/movement-data-toolkit)

[PhantomJS](https://phantomjs.org/), for scraping city names from the Uber website only.

### Usage
./scrape-uber-data.sh YEAR

The script will download all available data for each city that has data published by Uber as a part of the Uber Movement Data Toolkit for the year given as an argument.


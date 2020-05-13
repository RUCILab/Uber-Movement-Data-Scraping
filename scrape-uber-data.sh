#!/bin/bash

# Uber movement data scraping script
# Rutgers Urban & Civic Informatics Lab - Maintained by Gavin Rozzi - gavin.rozzi@rutgers.edu
# Usage ./scrape-uber-data.sh YEAR

# Increased node memory heap. Needed to prevent mdt from crashing
export NODE_OPTIONS=--max-old-space-size=8192

# This is a script to generate data for research using the Uber movement data toolkit
YEAR=$1

# Create data directory if it doesnt already exist
mkdir -p ~/movement-data/uber/$YEAR

# Scrape the HTML of the Uber movement data page to get a listing of cities with available data
# If phantomjs throws an error try setting this environment variable: 'export QT_QPA_PLATFORM=offscreen'
phantomjs get-uber-html.js

# Filter the scraped HTML of the Uber web page and store the names of URL slugs as cities.txt

# cat prints the contents of the HTML code to stdin and pipe operators feed the output to grep. grep recognizes lines that have links and we filter them to just cities.
# Subsequent expressions clean the links until we have just the city slugs that can be plugged in to the API

# TODO this need to be split into cities with travel times and speed to prevent the mdt api from throwing errors.
# two loops need to be constructed.
cat uber_cities.html | grep -Eoi '<a [^>]+>' | grep -Eo 'href="[^\"]+"' | grep -e "explore" | sed 's/href="//g' | sed 's/"//g' | sed 's:/travel-times::g' | sed 's:/speeds::g' | sed 's:?lang=en-US::g' | sed 's:/explore/::g' | sed 's:/mobility-heatmap::g' | uniq -u > cities.txt  

# Iterate over the lines in cities.txt and download the data to folder for corresponding year
cat cities.txt | while read line ; do
   echo 'Downloading data for' $line, $YEAR
   # GeoJSON version
   mdt create-geometry-file $line $YEAR -o ~/movement-data/uber/$YEAR/$line.geojson
   # CSV version
   mdt create-geometry-file --format=CSV $line $YEAR -o ~/movement-data/uber/$YEAR/$line.csv --format=CSV
done

# Delete the empty files created by the errors. Not perfect, but gets rid of junk data until I can revise this script further.
find ~/movement-data/uber/ -type f -empty -delete

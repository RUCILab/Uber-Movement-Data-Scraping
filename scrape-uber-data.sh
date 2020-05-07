#!/bin/bash

# Uber movement data scraping script
# Rutgers Urban & Civic Informatics Lab - Maintained by Gavin Rozzi - gavin.rozzi@rutgers.edu

# This is a script to generate data for research using the Uber movement data toolkit
# Requires nodejs and the Uber mdt installed (npm install -g movement-data-toolkit)

# Usage: specify the year and city to generate a dataset. This script will output in both GeoJSON and CSV by default

# Declare which year we want to scrape (TODO: make this an argument instead of hard coding)
YEAR=2020

# Declare array of cities we want to scrape
declare -a CITIES=('new_york')

# Scrape data for each city and store its output
for city in ${CITIES[@]}; do
    echo 'Downloading data for' $city, $YEAR
    mdt create-geometry-file $city $YEAR -o $city-$YEAR.geojson
done
#!/bin/bash

# Create a script to report historical forecasting accuracy
read -p "Enter a city: " city

# Get and clean observed temperature (strip degree and keep number only)
obs_temp=$(curl -s "wttr.in/${city}?format=%t" | grep -Eo '[+-]?[0-9]{1,2}')
fs_temp=$(curl -s "wttr.in/$city?T"  | head -23 | tail -1 | grep -Eo '[+-]?[0-9]{1,2}' | head -n 1)

year=$(TZ="$city" date +%Y )
month=$(TZ="$city" date +%m )
day=$(TZ="$city" date +%d )

# Output result
echo -e "Observed temperature is     : $obs_temp°C\n
Forecasted temperature is  : $fs_temp°C\n
Date                       : $month-$day-$year\n
City                       : $city" 

# store in logs

record=$(echo -e "$year\t$month\t$day\t$obs_temp\t$fc_temp C")
echo $record>>poc.log




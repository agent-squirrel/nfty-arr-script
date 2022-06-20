#!/bin/bash

username="noone"
password="nopass"
arr="none"
title="none"
newtype="none"
domain="none"
topic="none"

if [[ -n $radarr_eventtype ]]; then
	arr="Radarr"
	title=$radarr_movie_title
	newtype="New movie"
elif [[ -n $sonarr_eventtype ]]; then
	arr="Sonarr"
	title=$sonarr_series_title
	newtype="New episode"
else
	exit 1
fi

if [ -f "config" ]; then
	. config
else
	. /config/custom_scripts/config
fi
curl -u $username:$password -X POST $endpoint \
	-H "Content-Type: application/json" \
	  --data @- << END;
{
	"topic": "$topic",
	"message": "$newtype downloaded, $title",
	"title": "$arr $newtype",
	"actions": [{ "action": "view", "label": "Goto $arr", "url": "https://$arr.$domain" }]
}
END

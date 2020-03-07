#!/bin/bash

poi_list="Hike_Bike Historic_Sites Hotels Medical_Facilities Parks Public_Facilities Restaurants"

INCOMING="2276"
OUTGOING="4326"

for layer in ${poi_list}
do
  shp2pgsql -s ${INCOMING}:${OUTGOING} -c ${layer}.shp > ${layer}.sql
  cat ${layer}.sql | psql -U postgres -d test
done

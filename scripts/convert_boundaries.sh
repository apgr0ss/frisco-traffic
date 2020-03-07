#!/bin/bash

poi_list="City_ETJ Citylimits County_Line Proposed_Annexation"

INCOMING="2276"
OUTGOING="4326"

for layer in ${poi_list}
do
  shp2pgsql -s ${INCOMING}:${OUTGOING} -c ${layer}.shp > ${layer}.sql
  cat ${layer}.sql | psql -U postgres -d test
done

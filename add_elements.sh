#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table -t --no-align -c"

ADD_TO_ELEMENTS=$($PSQL "INSERT INTO elements(atomic_number, symbol, name) VALUES(9, 'F', 'Fluorine'), (10, 'Ne', 'Neon')")
echo $ADD_TO_ELEMENTS
NON_METAL_ID=$($PSQL "SELECT type_id FROM types WHERE type = 'nonmetal'")
ADD_TO_PROPERTIES=$($PSQL "INSERT INTO properties(atomic_number, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id) VALUES(9, 18.998, -220, -188.1, $NON_METAL_ID), (10, 20.18, -248.6, -246.1, $NON_METAL_ID)")
echo $ADD_TO_PROPERTIES
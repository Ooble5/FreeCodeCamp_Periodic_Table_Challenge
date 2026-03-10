#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table -t --no-align -c"

# Create types table and enter values
CREATE_TYPES_TABLE=$($PSQL "CREATE TABLE types(type_id INT PRIMARY KEY, type VARCHAR(15) NOT NULL)")
echo $CREATE_TYPES_TABLE

I=1
$PSQL "SELECT type FROM properties GROUP BY type" | while read TYPE
do
  echo $TYPE
  INSERT_TYPE_NAME=$($PSQL "INSERT INTO types(type_id, type) VALUES($I, '$TYPE')")
  echo $INSERT_TYPE_NAME
  (( I=I+1 ))
done

# Update properties table

CREATE_TYPE_ID_COLUMN=$($PSQL "ALTER TABLE properties ADD COLUMN type_id INT")
echo $CREATE_TYPE_ID_COLUMN
$PSQL "SELECT * FROM types" | while IFS='|' read TYPE_ID TYPE_FOR_PROPERTIES
do
  echo $TYPE_ID
  echo $TYPE_FOR_PROPERTIES
  UPDATE_TYPE_ID_IN_PROPERTIES=$($PSQL "UPDATE properties SET type_id = $TYPE_ID WHERE type = '$TYPE_FOR_PROPERTIES'")
  echo $UPDATE_TYPE_ID_IN_PROPERTIES
done

SET_TYPE_ID_NOT_NULL=$($PSQL "ALTER TABLE properties ALTER COLUMN type_id SET NOT NULL")
echo $SET_TYPE_ID_NOT_NULL
SET_TYPE_ID_F_KEY=$($PSQL "ALTER TABLE properties ADD FOREIGN KEY(type_id) REFERENCES types(type_id)")
echo $SET_TYPE_ID_F_KEY

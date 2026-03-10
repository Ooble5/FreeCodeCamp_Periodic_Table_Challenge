#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table -t --no-align -c"

$PSQL "SELECT symbol FROM elements" | while read SYMBOL
do
 echo $SYMBOL
 FORMATTED=$(echo $SYMBOL | sed -E 's/^(.)(.?)$/\U\1\L\2/')
 FORMATTED_TABLE_RESULT=$($PSQL "UPDATE elements SET symbol = '$FORMATTED' WHERE symbol = '$SYMBOL'")
 echo $FORMATTED_TABLE_RESULT
done

cat ../atomic_mass.txt | while read NUMBER BAR MASS
do
  if [[ $NUMBER = 'atomic_number' ]]
  then
    continue
  fi
  UPDATED_MASS=$($PSQL "UPDATE properties SET atomic_mass = $MASS WHERE atomic_number = $NUMBER")
  echo $UPDATED_MASS
done

DELETE_MADE_UP_ELEMENT_FROM_PROPERTIES=$($PSQL "DELETE FROM properties WHERE atomic_number = 1000")
echo $DELETE_MADE_UP_ELEMENT_FROM_PROPERTIES
DELETE_MADE_UP_ELEMENT_FROM_ELEMENTS=$($PSQL "DELETE FROM elements WHERE atomic_number = 1000")
echo $DELETE_MADE_UP_ELEMENT_FROM_ELEMENTS
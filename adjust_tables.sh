#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table -t --no-align -c"

$PSQL "SELECT symbol FROM elements" | while read SYMBOL
do
  echo $SYMBOL
  FORMATTED=$(echo $SYMBOL | sed -E 's/^(.)(.?)$/\U\1\L\2/')
  FORMATTED_TABLE_RESULT=$($PSQL "UPDATE elements SET symbol = '$FORMATTED' WHERE symbol = '$SYMBOL'")
  echo $FORMATTED_TABLE_RESULT
done

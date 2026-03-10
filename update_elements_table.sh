#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table -t --no-align -c"

#Fix mistakes in elements table
ADD_UNIQUE=$($PSQL "ALTER TABLE elements ADD UNIQUE(symbol, name)")
echo $ADD_UNIQUE
SYMBOL_NO_NULL=$($PSQL "ALTER TABLE elements ALTER COLUMN symbol SET NOT NULL")
echo $SYMBOL_NO_NULL
NAME_NO_NULL=$($PSQL "ALTER TABLE elements ALTER COLUMN name SET NOT NULL")
echo $NAME_NO_NULL
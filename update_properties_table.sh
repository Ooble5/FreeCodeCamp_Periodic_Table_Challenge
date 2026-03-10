#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table -t --no-align -c"

# Fix mistakes in database
FIX_WEIGHT_COLUMN=$($PSQL "ALTER TABLE properties RENAME COLUMN weight TO atomic_mass")
echo $FIX_WEIGHT_COLUMN
MELTING_POINT_NO_NULL=$($PSQL "ALTER TABLE properties ALTER COLUMN melting_point SET NOT NULL")
echo $MELTING_POINT_NO_NULL
BOILING_POINT_NO_NULL=$($PSQL "ALTER TABLE properties ALTER COLUMN boiling_point SET NOT NULL")
echo $BOILING_POINT_NO_NULL
FIX_MELTING_POINT_COLUMN=$($PSQL "ALTER TABLE properties RENAME COLUMN melting_point TO melting_point_celsius")
echo $FIX_MELTING_POINT_COLUMN
FIX_BOILING_POINT_COLUMN=$($PSQL "ALTER TABLE properties RENAME COLUMN boiling_point TO boiling_point_celsius")
echo $FIX_BOILING_POINT_COLUMN
ATOMIC_NUMBER_F_KEY=$($PSQL "ALTER TABLE properties ADD FOREIGN KEY(atomic_number) REFERENCES elements(atomic_number)")
echo $ATOMIC_NUMBER_F_KEY
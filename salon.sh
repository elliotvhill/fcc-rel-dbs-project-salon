#!/bin/bash

# PSQL variable for fCC GitPod environment
PSQL="psql --username=freecodecamp --dbname=salon --tuples-only -c"

# Welcome message
echo -e "\n~~~~ Welcome to the Salon ~~~~"
echo -e "\nWhich service would you like to book?"

MAIN_MENU() {

# Get list of services from services table
SERVICES=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id;")

# List available services
echo "$SERVICES" | while read SERVICE_ID BAR NAME
do
    # Return formatted list of services
    echo -e "$SERVICE_ID) $NAME"
done
read SERVICE_ID_SELECTED

# Check if input matches a service_id
SERVICE_SELECTED_EXISTS=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")

if [[ ! $SERVICE_SELECTED_EXISTS ]]
# If invalid input
then
    # Display error
    echo -e "\nPlease select a valid option."
    MAIN_MENU

# If valid input
else
    # Read customer phone number
    echo -e "\nWhat is your phone number?"
    read CUSTOMER_PHONE
    
    # Lookup customer name using phone number
    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
    # If not found
    if [[ -z $CUSTOMER_NAME ]]
    then
        # Get new customer name
        echo -e "\nI don't have you in the system.\nWhat is your name?"
        read CUSTOMER_NAME
        
        # Insert new customer
        INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
        echo -e "You entered $CUSTOMER_PHONE, $CUSTOMER_NAME."
    fi
    
# Get time of appointment
echo -e "\nWhat time would you like to come in?"
read SERVICE_TIME

# TODO: Check that time is a valid input

# Get customer ID
CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")

# Insert new appointment
INSERT_NEW_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(service_id, customer_id, time) VALUES($SERVICE_ID_SELECTED, $CUSTOMER_ID, '$SERVICE_TIME')")

# Print a confirmation message
SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
SERVICE_NAME_FORMATTED=$(echo $SERVICE_NAME | sed 's/^ *| *$//g')
echo -e "\nI have put you down for a $SERVICE_NAME_FORMATTED at $SERVICE_TIME, $CUSTOMER_NAME.\nSee you then!" 
fi

}

MAIN_MENU

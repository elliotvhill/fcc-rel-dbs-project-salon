#!/bin/bash

# PSQL variable for fCC GitPod environment
PSQL="psql --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~ Welcome to the Salon ~~~~\n"

MAIN_MENU() {
    # If main menu is passed with an argument (i.e. a message)
    if [[ $1 ]]; then
        # Print argument
        echo -e "\n$1"
    fi

    echo -e "\nWhat would you like to do?"
    echo -e "\n1. View services\n2. Book an appointment\n3. Cancel an appointment\n4. Exit"
    read MAIN_MENU_SELECTION

    case $MAIN_MENU_SELECTION in
    1) SERVICES ;;
    2) BOOK_APPOINTMENT ;;
    3) CANCEL_APPOINTMENT ;;
    4) EXIT ;;
    *) MAIN_MENU "Please enter a valid option." ;;
    esac
}

SERVICES() {
    # Get list of services from services table
    SERVICES=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id;")

    # List available services
    echo -e "\nHere's a list of our services:"
    echo "$SERVICES" | while read SERVICE_ID BAR NAME
    do
        # Return formatted list of services
        echo -e "$SERVICE_ID) $NAME"
    done
    # Return to main menu
    MAIN_MENU
}

BOOK_APPOINTMENT() {
    # Get list of services from services table
    SERVICES=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id;")

    echo -e "\nWhat kind of appointment would you like to book?"
    
    # Show list of services from services table
    echo -e "$SERVICES" | while read SERVICE_ID BAR NAME
    do
        echo -e "$SERVICE_ID) $NAME"
    done
    read SERVICE_ID_SELECTED

    # If invalid input
    if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9+]$ ]] # Check if input is a number
    # TODO: Check if input matches a service_id
    then
        # Display error
        echo -e "\nPlease select a valid option."
        
        # Return to service selection
        BOOK_APPOINTMENT

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

CANCEL_APPOINTMENT() {
    echo -e "\nWhat is your phone number?"
    read CUSTOMER_PHONE
    # Look up if customer has any appointments booked
    # If none booked: "You don't have any appointments scheduled."
    # Send to main menu
}

EXIT() {
    echo -e "\nThanks for stopping by."
}

MAIN_MENU

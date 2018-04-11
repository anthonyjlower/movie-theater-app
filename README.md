# README

## PROMPT
Build a rails app so that a movie theater can sell tickets and track their sales performance online

__Tech Used__
* Rail 5.1.6
* postgresql
* .erb templates
* Vanilla javaScript/CSS
* Heroku
* SENDGRID


## Requirements
1) Customers should be able to see the movies and their showtimes

* root route renders the homepage (movies#index) that displays all of the the movies andt their related showings
* Page loads with just a list of the movies that are showing
* Customers can then select the desired date from the nav bar and client-side javaScript displays the showings for the selected day.
* Customers can select the desired showing to navigate to the page (showing#show) where tickets can be bought.

2) Customers can buy 1 or more tickets for a movie

* The checkout form contains a quantity selector that has a default value of 1, but allows the customer select up to the remaining amount of tickets for the showing.
* Max capacity is set in the showing table to allow for changes in capactity based off of which screen it is being shown on.

3) Movies have limited seating and cannot oversell their capacity

* Everytime a user loads the page to make a purchase (showing#show) that showing's max capactity and the amount of tickets that have been purchased already are sent over.
* This allows the ticket quantity picker to display a max amount of the remaining inventory of tickets.
* Once the showing sells out the purchase form goes away and a 'Sold Out' message is displayed in it's place.

4) Customers can buy a ticket by entering their name, email, credit card number, and credit card expiration date

* Form only requires name, email, credit card number, and credit card expiration date to be submit correctly.
* Form defaults to 1 ticket, the customer does need to select a different quantity if they want to buy muliple tickets.

5) Customer should recieve their reciept through an email.

* Once a customer completes their purchase they are sent to a confirmation page (transaction#show) informing them their purchase was successful and they will receieve an email.
* Using SENDGRID addon through Heroku an email is then sent to the customer repeating the quantitiy of tickets purchased, the movie title, showing information, price per ticket, and total amount spent.


6) Application should validate credit card information

* For testing the credit card validations are simple so fake numbers can still be used, but work flow for fake numbers is in place.
* Currently the route (transaction#create) checks that the expiration date is in the future, the credit card number has exactly 16 characters, and all of the characters are numerals - this last one is done by turning the string into an integer and back, which drops any non-numeric characters
* Once we are ready to start taking real credit cards we will want to implement more security through encrypitng credit card numbers, and using a gem to handle the validations [example](https://rubygems.org/gems/credit_card_validations)

7) Let the user know if there is an issue with their purchase

* If the form passes the credit card validation it also checks validation to make sure first_name, last_name, and email exist before creating the new transaction (transaction#create).
* If either of the validations fail the customer is redirected back to the page to purchse tickets (showing#show), with an error that reads either 'There was an error with your credit card information' or 'There was an error with your name or email'

8) Owner wants a dashboard with total revenue, most popular movies, most popular times of day, revenue by day of the week

* The dashboard can be reached from any spot on the website. Since admin authentication wasn't necessary the header allowing you to switch between customer and owner views was used to make access easy.
* Since it does not fit in a traditional CRUD sense this is a custom route (transaction#dashboard).
* Because of database realtions we were required to loop through at least 3 different arrays
* On the first array we loop through all of the transactions, every transaction has it's cost total added to the total revenue variable, we then look at the date and retrieve a weekday index and add it's cost to the day. Finally we look at the time and then search for that key exisiting in a hash and either add it to the existing total, or set it equal to the total if it is new.
* The second array loops through all of the movies and their related transactions. This allows us to build a new hash that is pushed into an array. This data structure makes it easier to display on the front end and allows for more functionality in linking.

9) Owner wants to be able to view a list of all orders

* Below the total revenue there is a link to view all of the transactions (transactions#index)
* This view displays the email that was used to place the order, what movie they saw, when the showing was, how many tickets were purchased, and the total dollar amount of the purchase

10) Owner wants to be able to view a list of all orders for specific movies

* In the movie sales table the owner can click on any movie title in order to see the transactions for that specific movie (movies#show)








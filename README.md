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
__1) Customers should be able to see the movies and their showtimes__

* Root route renders the homepage (movies#index) that displays all of the the movies and their related showings
* Page loads with just a list of the movies that are showing
* Customers can then select the desired date from the nav bar and client-side javaScript displays the showings for the selected day
* Customers can select the desired showing to navigate to the page (showing#show) where tickets can be bought

__2) Customers can buy 1 or more tickets for a movie__

* The checkout form contains a quantity selector that has a default value of 1, but allows the customer select up to the remaining amount of tickets for the showing
* Max capacity is set in the showing table to allow for changes in capactity based off of which screen it is being shown on

__3) Movies have limited seating and cannot oversell their capacity__

* Everytime a user loads the page to make a purchase (showing#show) that showing's max capactity and the amount of tickets that have been purchased already are sent over
* This allows the ticket quantity picker to display a max amount of the remaining inventory of tickets
* Once the showing sells out the purchase form goes away and a 'Sold Out' message is displayed in it's place

__4) Customers can buy a ticket by entering their name, email, credit card number, and credit card expiration date__

* Form only requires name, email, credit card number, and credit card expiration date to be submit successfully
* Form defaults to 1 ticket, the customer does need to select a different quantity if they want to buy muliple tickets

__5) Customer should recieve their receipt through an email__

* Once a customer completes their purchase they are sent to a confirmation page (transaction#show) informing them their purchase was successful and they will receieve an email receipt
* Using SENDGRID addon through Heroku to send an email showing the quantitiy of tickets purchased, the movie title, showing information, price per ticket, and total amount spent


__6) Application should validate credit card information__

* For demo the credit card validations are simple so data flow for failed validation is in place, but fake numbers can still be used
* Currently the route (transaction#create) checks that the expiration date is in the future, the credit card number has exactly 16 characters, and all of the characters are numerals - this last check is done by turning the string into an integer and back, which drops any non-numeric characters
* Once we are ready to start taking real credit cards we will want to implement more security through encrypitng credit card numbers, and using a gem to handle the validations - [example](https://rubygems.org/gems/credit_card_validations)

__7) Let the user know if there is an issue with their purchase__

* If the form passes the credit card validation it is run through validation to make sure first_name, last_name, and email exist before creating the new transaction (transaction#create)
* If any of the validations fail the customer is redirected back to the page to purchse tickets (showing#show) with an error that reads either 'There was an error with your credit card information' or 'There was an error with your name or email'

__8) Owner wants a dashboard with total revenue, most popular movies, most popular times of day, revenue by day of the week__

* The dashboard can be reached from any spot on the website. Since admin authentication wasn't necessary the header allowing you to switch between customer and owner views was used to make access easy.
* Since it does not fit in a traditional CRUD sense this is a custom route (transaction#dashboard).
* Because of database realtions we were required to loop through at least 3 different arrays
* On the first array we loop through all of the transactions, every transaction has it's cost added to the total revenue variable, then we look at the date and retrieve a weekday index and add it's cost to that day. Finally we look at the time and then search for that key exisiting in a hash and either add it to the existing total, or set it equal to the total if it is new
* The second array loops through all of the movies and their related transactions. This allows us to build a new hash that is pushed into an array. A hash is used for Movies because it makes it easier to display on the front end and allows for more functionality in to movie specific reports.

__9) Owner wants to be able to view a list of all orders__

* Below the total revenue there is a link to view all of the transactions (transactions#index)
* This view displays the email that was used to place the order, what movie they saw, when the showing was, how many tickets were purchased, and the total dollar amount of the purchase

__10) Owner wants to be able to view a list of all orders for specific movies__

* In the movie sales table the owner can click on any movie title in order to see the transactions for that specific movie (movies#show)
* This view displays the email that was used to place the order, when the showing was, how many tickets were purchased, and the total dollar amoutn of the purchase


## Next Steps and Future Plans
1. Change the static dates on homepage (movies#index) to be dynamic - shown in the [dynamic dates branch](https://github.com/anthonyjlower/movie-theater-app/tree/dynamic-dates)
2. Add gem for improved Credit Card Validation
3. Refactor code so models contain methods that complete some of the route functionality to increase modularity and DRY-ness
4. Change front-end to be SPA (react.js)








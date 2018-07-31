Browse this application at https://vote-dot-org-address-validator.herokuapp.com/

# Address Validator Coding Challenge

Having accurate addresses is important for Vote.org. In this challenge you will be given a 
very basic rails app that consists of a form with a field for 
- street address 
- city
- state 
- zip

The goal is to have the form validate the input to see if it forms a valid address
and if so, save the address components in the respective columns.

While not all addresses will have a value for every column it is important not to lose any
address information provided. For example if an address post direction value or unit value
is provided, those must be saved. Additionally any addresses that are not real addresses 
should not be saved. As a rule, all addresses should have
 - house number
 - street name 
 - city 
 - state (saved as 2 letter state abbreviation)
 - 5 digit zip code (only numbers) 

It is your job to update the Address model and controller so that all validated 
addresses are saved to the database and no invalid addresses are saved. The Address model
also has a `#to_s` method that needs to be filled in so that it returns the address as 
a string. 
 
While front end validation and feedback to the user is expected, you should not rely only on 
front end validations. Additionally a suggested layout has been included in a file labeled 
"wireframe.png". Feel free to use this mock or come up with a different design of the frontend. 

A few test cases have been provided to help get you started. You are encouraged to write more
tests as you go, but DO NOT delete any of the existing tests. Also, you may not change the
schema.

## Prerequisites

You'll need the following installed on your system:
1. ruby
2. rails
3. sqlite3

Instructions can be found here: http://guides.rubyonrails.org/getting_started.html#installing-rails

## Getting started

To run the project as is:
1. `bundle install`
2. `rake db:create`
3. `rake db:migrate`
4. `rails s`

To run the tests:
1. `rails generate rspec:install`
  (When prompted to overwrite spec/spec_helper.rb enter `n`)
2. `rspec` (or `bundle exec rspec`)

If everything is set up properly you should see `10 examples, 7 failures` to start. 
 
Here are some useful resources for Ruby On Rails:
- https://www.tutorialspoint.com/ruby-on-rails/rails-controllers.htm
- http://guides.rubyonrails.org/active_model_basics.html
- http://guides.rubyonrails.org/action_controller_overview.html
- http://guides.railsgirls.com/app
- https://www.railstutorial.org/book/toy_app
- https://relishapp.com/rspec/rspec-rails/v/3-7/docs (docs for rspec testing)

Information on Address standards / validations:
- https://pe.usps.com/text/pub28/28c1_001.htm

Here are some services that can be used for address validation:
- https://developers.google.com/maps/documentation/geocoding/intro
- https://wiki.openstreetmap.org/wiki/Nominatim
- https://developers.arcgis.com/rest/geocode/api-reference/overview-world-geocoding-service.htm
If you need an api key or are interested in using another service please let us know.

Your finished project should:
- validate addresses
- not save any invalid addresses
- be styled on the front end
- validate fields on the front end
- display feedback to the user
- be well-tested

When submitting the project please answer the following questions:
 1. What gems if any did you choose to use and why?
 - Bootstrap -> To get a basic theme quickly
 - jQuery-Rails -> For client-side validation with Bootstrap
 - SmartyStreets_Ruby_Sdk -> The documentation is great, the
 - WebMock -> For stubbing HTTP requests to not rely on external services for unit tests, and to avoid going over my free SmartyStreets monthly quota of 250 requests/month
 2. Were there any specific challenges or struggles you faced along the way?
 - Learning Ruby on Rails and Rspec because I haven't used it before (but really love it!)
 - Getting through a lot of errors when setting up Ruby on Rails environment on Windows 10. First I tried using the Linux Subsystem for Windows (because I read setting up Ruby in Linux was less error-prone than Windows), and that setup went smoothly. But there were issues getting debugging to work correctly, so I bailed on that and went to just running it on Windows 10.
 - Deciding what address validation service to use. After some research, I found out that some of the ones I looked at (like Google maps) did not actually provide addresss validation and standardization, or weren't CASS compliant. Also, the documentation for some of the APIs did not make it clear how to use their service for validation, or was just confusing.
 - Finding a well maintained gem for reliable address standardization and validation. Most of the gems I looked at on GitHub hadn't been updated for 3-5 years on average.
 3. Is there anything you'd want to improve or optimize if you had more time?
 - Localize the application to multiple languages (at least Spanish)
 - Make changes to ensure the form is accessible for screen readers
 - Improve the mobile experience
 - Auto-complete the street address as the user types and fill in the fields after a selected match
 - Add integration tests and more unit tests
 - Use caching for address validation to reduce external API calls for repeat addresses
 - Allow the user to confirm the validated address is the correct address they want to save (becuase of the possibility of multiple matches based on what they enter)
 - Add user first/last name and email to send status emails and any necessary future correspondence
 - Allow the user to optionally create an account so they can come back and update their address easily if they move
 - Add a secondary address validation service to use for fault tolerance in case the primary validation service is down
 - Better exception handling and retry logic for the address validation API calls (things like bad requests, too much data sent, too many requets in short period of time, etc.)
 4. If you were to take this project to production, what would be on your list of things to do?
- Minify the CSS and scripts
 - Encrypt API keys in config files/environment variables
 - Change the database from SQLite to something that has higher reliability, integrity and supports multiple writers like PostgreSQL
 - Use SSL to make sure each person's address is confidential when sending and receiving data from the webserver
 - Ensure there is a database backup mechanism in place so we minimize the chance of loosing any saved data
 - Look into database replication to improve availability
 - Deploy to a cloud platform like Heroku for reliable availability, application monitoring and scaling
 - Performance testing to see how responsive the website is with all of the newly registered voters we'll be getting!






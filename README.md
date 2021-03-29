# README

### Install dependencies

`bundle install`

You'll also need to have Postgresql up and running. If you don't have it installed you can use Homebrew and run:

`brew install postgresql`

### Database creation

`bundle exec rails db:create db:migrate db:seed`

### Run tests

`bundle exec rspec`

### Run the server

`bundle exec rails s`

The available endpoints (with params) are the following:
* ` GET /partners`
  * lat - latitude of the customer
  * lon - longitude of the customer
  * material - material for the job
* `GET partners/:id`
  * id - id of particular partner


### Solution

I focused on getting the right partners and the overall structure of the code

1. I followed a TDD approach
1. I made a few assumptions about the data model, since the task said I could do so. in a real scenario I would have added at least the following models:
    1. Customer, Rating (I assumed the average rating of a partner was just a field), Project
1. I also skipped basic model tests that would be done in a real scenario, like testing a model only takes valid data
1. After I got my solution working properly, I refactored the controller
    1. Moved the business logic to an isolated service so it could be used anywhere in the platform

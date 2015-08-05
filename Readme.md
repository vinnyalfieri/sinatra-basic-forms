# Basic Forms!

## Deliverables

Fork this repository. Deliver your work in the master branch.

## Objectives

1. Build out basic edit/update functionality for the songs resource
2. Create a form that produces a well-structured params hash for updating songs using mass-assignment

## Instructions

1) Bundle gems

`bundle`

2) Create the database schema

`rake db:migrate`
`rake db:migrate SINATRA_ENV=test`

3) Seed the database with data

`rake db:seed`

4) Run `shotgun` and open [localhost:9393](http://localhost:9393/) in your browser. Click around and see what has already been built out.

Your objective for this lab will be to make it possible for users to edit songs. You'll create the necessary routes and a form to make this feature work.

Since the test suite for this uses capybara to recreate the user flow (visit the song show page, click on the edit link, fill in and submit the form), you'll have to build out the functionality with that order in mind if you want your failures to go in a logical order. 

The following steps provide an overview of what you'll need to build:

### Create the edit route

Create an 'edit' route in app.rb and pass it a song id. This route is going to render the songs/edit template, so also create a song instance variable to pass to the view.

### Create the edit view

Create an edit view template in views/songs and build a form with named controls. The purpose of this form is to edit/update existing songs. These fields should have the songs current attributes set as their value so that they can be properly updated.

### Create the update route

Create an 'update' route in app.rb. The is is the route where you will post the data from the song edit form. Inside the controller block, use the params hash to update and save the changes to the song.

### Add the route action to your form

Make sure that the 'action' attribute of your form points to the correct route, and that the method is correct.

### Add the edit link

Add a link on each song show page that directs users to the edit view
and fix the songs!

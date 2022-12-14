# NOTES
### WHEN RUNNING rake db:seed:replant delete storage folder or it will continue creating a new image to attach to event (no longer required)

cookie middleware has been enabled
session middleware also enabled

cookies are client viewable
sessions are hashed client side, unhashed server side
cookies[:symbol] ||= 0
cookies[:symbol] = cookies[:symbol].to_i + 1

session[:symbol] ||= 0
session[:symbol] += 1

apparently cookie + session changes to config/application.rb required only if created rails in API only mode

same site cookie explanation = https://web.dev/samesite-cookies-explained/

faker can enforce unique values by adding a unique method call to the generator i.e. Faker::Music.unique.band 

sqlite3 human readable format: .mode columns, .headers on

rails console is still a very helpful cli command

can create migrations by following naming convention and options:
  - bin/rails g migration AddNameToEvents name:string

rspec testing built-in matchers
https://rubydoc.info/gems/rspec-expectations/frames

can show individual tests that passed by running (rspec -f d) aka (rspec -formatter documentation)

can check if new objects are being created with instance.object_id

can view routes with rails routes or in console by exploring app.:symbol_(url/path)

Because a cookie’s SameSite attribute was not set or is invalid, it defaults to SameSite=Lax, which prevents the cookie from being sent in a cross-site request. This behavior protects user data from accidentally leaking to third parties and cross-site request forgery.
Resolve this issue by updating the attributes of the cookie:
Specify SameSite='None' and 'Secure' if the cookie should be sent in cross-site requests. This enables third-party use.
Specify SameSite='Strict' or SameSite='Lax' if the cookie should not be sent in cross-site requests.

google returns a jwt credential

you can route to a controller action then render a different action's view

Turbolink features make page events triggered with javascript not happen unless page is refreshed, see stackoverflow link at bottom

## database models

### events
- id
- date
- location
- description
- charities

### users
- id
- username

### tickets
- user_id
- event_id
- amount

### artists
- id
- name

# step 1:
### setting up database tables;
created base tables
created join tables
  - join tables create references but not indexes
  - indexes are quick lookup systems for database search optimisation

# step 2:
### creating the models;
### active record associations

event :many <-  -> :many artists
event :many <- tickets -> :many users

rake db:migrate
bin/rails dbconsole

# step 3:
### routes; CRUD stuff;
search engines punish sites with routes that don't work
resources :model, only : [:index, :show]

#### user, event, ticket, artist
users can view: events, artists, own ticket
users can view: events through artists, artists through events
users can: 'buy' a ticket
users can't: create events, artists, other users
users can't: edit events, artists, other users, tickets

admin users can: create events, artists
admin users can: edit events, artists

Method  |Description
index	  |Show all newsletters
create	|Create a new newsletter
new	    |Render the form for creating a new newsletter
edit	  |Render the form for editing a newsletter
show	  |Show a single newsletter
update	|Update a newsletter
destroy	|Delete a newsletter

# step 4:
### styling;

css is loaded through app/assets/stylesheets/application.css
it defines order, imports appeared to break when not at the top of the order tree

site name?: IHEART Concerts

wanted to shortcut styling, installed bootstrap
bootstrap ruby had a guide for setting up and organising files
https://github.com/twbs/bootstrap-rubygem/blob/main/README.md

carousel

# step 5:
### dummy data

it became apparent that having dummy data in the tables would help a lot with visualising and processing requests for data from database
found video on faker gem
might need to create rake task to populate database with faker data
turns out there's already a rake task called db:seed that runs the seeds.rb file
truncate + reseed task = rake db:seed:replant

# step 6:
### testing

app was created with the -T flag
added gem rspec-rails
ran bundle install && bundle exec rails g rspec:install

# step ?:
### Questions;

What's the difference between Bundler and Ruby Gems?
How to enforce unique join in join table, how to do this on model level as well? (https://nelsonfigueroa.dev/uniqueness-constraint-between-two-columns-in-rails/)[doesn't work from model side :(]
oh! "You should use has_many :through if you need validations, callbacks, or extra attributes on the join model." - ruby on rails association_basics.html

<%= render partial: 'carousel', locals: { headliners: @data[:headliners] } %>

# step ?!:
### Look up again/References;
- strong params
- Alerts, Notices (FLASH)https://www.rubyguides.com/2019/11/rails-flash-messages/
- https://guides.rubyonrails.org/form_helpers.html#other-helpers-of-interest -form helpers
- https://academyxi.instructure.com/courses/186/pages/validations-in-controller-actions?module_item_id=26218 -form validation render vs redirect + @model.errors.messages
- https://api.rubyonrails.org/classes/ActionView/Helpers/FormHelper.html#method-i-form_with -form_with API docs
- what is the respond_to helper?
- http://www.railsstatuscodes.com/
- https://www.rubyguides.com/2019/05/rails-link_to-method/
- https://yoksel.github.io/flex-cheatsheet/
- https://scoutapm.com/blog/rails-nested-routes
- https://dmitripavlutin.com/javascript-fetch-async-await/
- https://stackoverflow.com/questions/71110271/events-not-loading-on-first-page-load-but-works-after-refresh

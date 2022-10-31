# NOTES

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
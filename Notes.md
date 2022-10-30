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

step 1:
setting up database tables;
created base tables
created join tables
  - join tables create references but not indexes
  - indexes are quick lookup systems for database search optimisation

step 2:
creating the models;
active record associations

event :many <-  -> :many artists
event :many <- tickets -> :many users

rake db:migrate
bin/rails dbconsole

step 3:
routes; CRUD stuff;
search engines punish sites with routes that don't work
resources :model, only : [:index, :show]

user, event, ticket, artist

creating
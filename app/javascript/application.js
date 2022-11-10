// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//= require jquery
//= require jquery_ujs
//= require popper
//= require bootstrap-sprockets
//= require './redux/actions.js'
//= require './redux/store.js'
//= require './redux/reducer.js'
//= require './redux-stuff.js'
import { Turbo } from "@hotwired/turbo-rails"
Turbo.session.drive = false
import "controllers"

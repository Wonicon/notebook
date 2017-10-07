# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Intend to be shared by all controllers
document.addEventListener 'turbolinks:load', ->
  document.body.addEventListener 'ajax:error', (event) ->
    console.log(event.detail)
    alert "#{event.detail[1]}:\n #{event.detail[0]}"

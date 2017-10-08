# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

document.addEventListener 'turbolinks:load', ->
  if document.URL.match('.*/categories')
    document.body.addEventListener 'ajax:success', (event) ->
      wrapper = document.createElement 'div'
      wrapper.innerHTML = event.detail[0]
      list = document.getElementById 'categories'
      list.appendChild wrapper.firstChild

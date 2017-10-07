# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

if document.URL.match('.*/categories/new')
  document.addEventListener 'turbolinks:load', ->
  document.body.addEventListener 'ajax:success', (event) ->
    item_wrapper = document.createElement 'div'
    item_wrapper.innerHTML = event.detail[0]['rendered']
    list = document.getElementById 'categories'
    list.appendChild item_wrapper.firstChild
  document.body.addEventListener 'ajax:error', (event) ->
    json = event.detail[0]
    name = json['name']
    reason = json['reason']['name']
    alert "'#{name}' #{reason}"

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

document.addEventListener 'turbolinks:load', ->
  if document.URL.match '.*/tasks/new'
    registerTaskItemListHandler()
  if document.URL.match '.*/tasks/\\d+'
    registerTaskItemCheckHandler()

registerTaskItemListHandler = ->
  task_item_list = document.getElementById 'task_item_list'
  task_item_btn = document.getElementById 'task_item_btn'
  new_task_item = document.getElementById 'new_task_item'
  task_items = document.getElementById 'task_items'
  json_builder = JSON.parse '[]'

  task_item_btn.onclick = ->
    item = new_task_item.value
    if !item
      alert 'New sub task cannot be empty'
    else
      json_builder[json_builder.length] = item
      li = document.createElement 'li'
      li.innerHTML = item
      task_item_list.appendChild li
      new_task_item.value = ''
      task_items.value = JSON.stringify json_builder

registerTaskItemCheckHandler = ->
  task_items = document.getElementsByClassName 'task_item'
  for task_item in task_items
    task_item.addEventListener 'change', (e) ->
      console.log this.checked
      Rails.ajax({
        type: 'PUT'
        url: document.URL + '/task_items/' + this.value
        data: 'finished=' + this.checked
      })

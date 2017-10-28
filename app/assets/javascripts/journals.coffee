# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Replace journal text with editable form containing raw data
editContent = (id, html) ->
  div = document.getElementById('journal-' + id)
  div.innerHTML = html.body.innerHTML
  form = document.getElementById('journal-edit-' + id)
  form.addEventListener 'ajax:success', (data, status, xhr) ->
    div.innerHTML = data.detail[0]

@edit = (id) ->
  Rails.ajax({
    type: 'GET'
    url: '/journals/' + id + '/edit'
    success: (data, status, xhr) -> editContent(id, data)
    error: (xhr, status, error) -> alert('Error')
  })

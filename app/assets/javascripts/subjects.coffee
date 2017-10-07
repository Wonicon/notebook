# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

if document.URL.match '.*/subjects/new'
  document.addEventListener 'turbolinks:load', ->
    cover = document.getElementById 'cover'
    cover.addEventListener 'change', updatePreview

updatePreview = ->
  cover = document.getElementById 'cover'
  preview = document.getElementById 'preview'
  if preview.src
    URL.revokeObjectURL(preview.src)  # Release covered resource
  preview.src = URL.createObjectURL(cover.files[0])

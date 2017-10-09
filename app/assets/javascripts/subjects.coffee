# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

cropper = null

document.addEventListener 'turbolinks:load', ->
  if document.URL.match '.*/subjects/new'
    cover = document.getElementById 'cover'
    cover.addEventListener 'change', updatePreview

updatePreview = ->
  cover = document.getElementById 'cover'
  cropper_area = document.getElementById 'cropper-area'
  cropped_cover = document.getElementById 'cropped_cover'

  if cropper && cover.files && cover.files.length
    cropper.destroy()
    URL.revokeObjectURL(cropper_area.src)  # Release covered resourcexx

  cropper_area.src = URL.createObjectURL(cover.files[0])
  cover.value = ''  # Don't upload this value

  cropper = new Cropper cropper_area, {
    dragMode: 'none'
    viewMode: 3
    aspectRatio: 1
    preview: '#img-preview'
  }

  set_value = -> cropped_cover.value = cropper.getCroppedCanvas().toDataURL('image/png')

  cropper_area.addEventListener 'ready', -> set_value()
  cropper_area.addEventListener 'cropend', -> set_value()

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

cropper = null

document.addEventListener 'turbolinks:load', ->
  if document.URL.match '.*/subjects/(new|\\d+/edit)'
    cover = document.getElementById 'cover'
    cover.addEventListener 'change', updatePreview
    set_value = ->
      c = cropper.getCropBoxData()
      console.log(c)
      document.getElementById('crop_width').value = c.width
      document.getElementById('crop_height').value = c.height
      document.getElementById('crop_left').value = c.left
      document.getElementById('crop_top').value = c.top
    cropper_area = document.getElementById 'cropper-area'
    cropper_area.addEventListener 'ready', set_value
    cropper_area.addEventListener 'cropend', set_value

    # Category dropdown selection initialization require by Semantic UI
    $('.ui.dropdown').dropdown()

  if document.URL.match '.*/subjects/.*'
    # Init tabs in show page
    $('.tabular.menu .item').tab({
      history: true,
      historyType: 'hashTag'
    })

updatePreview = ->
  cropper_area = document.getElementById 'cropper-area'

  if cropper && cover.files && cover.files.length
    cropper.destroy()
    URL.revokeObjectURL(cropper_area.src)  # Release covered resourcexx

  if cover.files[0]
    cropper_area.src = URL.createObjectURL(cover.files[0])
    cropper = new Cropper cropper_area, {
      dragMode: 'none'
      viewMode: 2
      aspectRatio: 1
      zoomable: false
      responsive: false  # Avoid unexpected zooming when resizing
      preview: '#img-preview'
    }
  else  # When cancel the file chooser
    cropper.destroy()
    cropper = null
    URL.revokeObjectURL(cropper_area.src)  # Release covered resourcexx
    cropper_area.src = '#'

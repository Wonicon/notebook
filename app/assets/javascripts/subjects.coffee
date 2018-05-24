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
      canvas = cropper.getCanvasData()
      image = cropper.getImageData()
      document.getElementById('crop_width').value  = c.width  * image.naturalWidth  / canvas.width
      document.getElementById('crop_height').value = c.height * image.naturalHeight / canvas.height
      document.getElementById('crop_left').value   = c.left   * image.naturalWidth  / canvas.width
      document.getElementById('crop_top').value    = c.top    * image.naturalHeight / canvas.height
    cropper_area = document.getElementById 'cropper-area'
    cropper_area.addEventListener 'ready', set_value
    cropper_area.addEventListener 'cropend', set_value

    # Category dropdown selection initialization require by Semantic UI
    $('.ui.dropdown').dropdown()

  
  ###############################
  # Init Simple Markdown Editor
  # #############################
  simplemde = new SimpleMDE
  # Avoid duplicated object while navigating with turbolink
  document.addEventListener("turbolinks:before-cache", ->
    simplemde.toTextArea()
    simplemde = null
  )

  if document.URL.match '.*/subjects/.*'
    # Init tabs in show page
    $('.tabular.menu .item').tab({})

updatePreview = ->
  cropper_area = document.getElementById 'cropper-area'

  if cropper && cover.files && cover.files.length
    cropper.destroy()
    URL.revokeObjectURL(cropper_area.src)  # Release covered resourcexx

  preview = document.getElementById('img-preview')
  origin = document.getElementById('origin-preview')
  if cover.files[0]
    cropper_area.src = URL.createObjectURL(cover.files[0])
    origin.style = 'display:none'  # hide original one
    preview.classList.add('cover-preview')  # give original size before hooked
    cropper = new Cropper cropper_area, {
      dragMode: 'none'
      viewMode: 2
      aspectRatio: 1
      zoomable: false
      responsive: false  # Avoid unexpected zooming when resizing
      preview: '#img-preview'
    }
  else  # When cancel the file chooser
    URL.revokeObjectURL(cropper_area.src)  # Release covered resourcexx
    cropper_area.src = '#'
    origin.style = ''  # display origin
    preview.classList.remove('cover-preview')  # hide area (1)
    preview.style = ''  # remove styles set by cropper to hide area (2)
    cropper.destroy()
    cropper = null

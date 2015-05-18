$(".images.edit").ready ->
  loadingModal = $("#loading_modal")
  message = $("#loading_modal_content")

  source = new Image
  img = $('#image')
  container = $('#image_container')

  tracker = new tracking.ObjectTracker('face')

  faces = []

  loadingModal.modal('show')
  console.log 'modal activated'

  source.onload = ->
    console.log 'image loaded'
    img.attr('src', source.src)
    ratio = container.width() / source.width
    tracking.track(source, tracker)

    tracker.on 'track', (event) ->
      event.data.forEach (rect) ->
        console.log 'face detected'
        plotRectangle(rect.x, rect.y, rect.width, rect.height, ratio)
        faces.push([rect.x, rect.y, rect.width, rect.height])

      $('input#faces').val(faces)
    $('#loading_modal').modal('hide')

  plotRectangle = (x, y, w, h, r) ->
    console.log 'plotting rectangle'
    rect = document.createElement('div')
    rect.classList.add 'rect'
    container.append(rect)
    offset = img.position()
    rect.style.width = (w * r) + 'px'
    rect.style.height = (h * r) + 'px'
    rect.style.left = (offset.left + (x*r)) + 'px'
    rect.style.top = (offset.top + (y*r)) + 'px'


  source.crossOrigin = "Anonymous"
  console.log 'Setting image source'
  source.src = $('#image').attr('src')

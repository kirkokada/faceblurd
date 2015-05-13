$(window).load ->
  source = new Image
  img = $('#image')
  container = $('#image_container')

  tracker = new tracking.ObjectTracker('face')

  faces = []
  
  source.onload = ->
    img.attr('src', source.src)
    ratio = container.width() / source.width
    console.log(ratio)
    localStorage.setItem("savedImageData", source.src);
    tracking.track(
      source,
      tracker
      )

    tracker.on 'track', (event) ->
      event.data.forEach (rect) ->
        console.log("Face detected!")
        plotRectangle(rect.x, rect.y, rect.width, rect.height, ratio)
        faces.push([rect.x, rect.y, rect.width, rect.height])

      $('input#faces').val(faces)

  plotRectangle = (x, y, w, h, r) ->
    console.log("Creating rectangle div")
    rect = document.createElement('div')
    rect.classList.add 'rect'
    container.append(rect)
    offset = img.position()
    rect.style.width = (w * r) + 'px'
    rect.style.height = (h * r) + 'px'
    rect.style.left = (offset.left + (x*r)) + 'px'
    rect.style.top = (offset.top + (y*r)) + 'px'

  source.crossOrigin = "Anonymous"
  source.src = $('#image').attr('src')

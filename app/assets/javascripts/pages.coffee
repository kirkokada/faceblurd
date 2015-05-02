# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  img = document.getElementById 'image'
  
  tracker = new tracking.ObjectTracker('face')
  
  tracking.track(img, tracker)

  tracker.on 'track', (event) ->
    event.data.forEach (rect) ->
      plotRectangle(rect.x, rect.y, rect.width, rect.height)

  plotRectangle = (x, y, w, h) ->
    rect = document.createElement('div')
    arrow = document.createElement('div')


    arrow.classList.add 'arrow'
    rect.classList.add 'rect'

    rect.appendChild arrow

    document.getElementById('image_container').appendChild(rect)

    rect.style.width = w + 'px'
    rect.style.height = h + 'px'
    rect.style.left = (img.offsetLeft + x) + 'px'
    rect.style.top = (img.offsetTop + y) + 'px'


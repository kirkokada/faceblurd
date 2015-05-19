$ ->
  $(document).on 'page:fetch', ->
    NProgress.start()
  $(document).on 'page:change', ->
    NProgress.done()
  $(document).on 'page:restore', ->
    NProgress.remove()

  $(document).ajaxStart ->
    NProgress.start()
  $(document).ajaxComplete ->
    NProgress.done()
  $(document).ajaxStop ->
    NProgress.remove()
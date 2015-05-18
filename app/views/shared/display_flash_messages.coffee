$('.modal').modal('hide')

$('#flash-content').html("<%= escape_javascript(render('layouts/flash_content')) %>")

$('#flash_modal').modal('show')
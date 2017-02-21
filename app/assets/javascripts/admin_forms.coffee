reorder = (parent) ->
  ids = []
  $(parent).children().each ->
    ids.push $(this).data('edit-id')
  $.ajax
    type: 'PUT'
    url: $('tbody').data('sortable')
    data: { ids: ids }

jQuery ->
  toastr.options =
    'closeButton': false
    'debug': false
    'positionClass': 'toast-bottom-right'
    'onclick': null
    'showDuration': '300'
    'hideDuration': '1000'
    'timeOut': '5000'
    'extendedTimeOut': '1000'
    'showEasing': 'swing'
    'hideEasing': 'linear'
    'showMethod': 'fadeIn'
    'hideMethod': 'fadeOut'

  $('button[data-form-submit]').click ->
    target = $(this).data('form-submit')
    $(target).submit()

  $('tr[data-edit-link] > td[data-row-click]').click ->
    target = $(this).parent().data('edit-link')
    window.location = target

  $('th[data-sort-column]').click ->
    parent = $(this).parents('table[data-sort-url]')
    target = $(parent).data('sort-url')
    sort_column = $(this).data('sort-column')
    dir = $(parent).data('sort-dir')
    if sort_column == $(parent).data('current-sort-column')
      dir = if dir == 'ASC' then 'DESC' else 'ASC'
    target += '?order_by=' + sort_column + '&dir=' + dir
    window.location = target

  $('*[data-toggle-state]').change ->
    target = $(this).data('toggle-state')
    if $(this).is(':checked')
      $(target).removeAttr 'disabled'
    else
      $(target).attr 'disabled', 'disabled'

  fixHelperModified = (e, tr) ->
    rows = tr.children()
    dragBlock = tr.clone()
    dragBlock.children().each (index) ->
      $(this).width rows.eq(index).width()
      return
    dragBlock

  $('tbody[data-sortable]').sortable(
    helper: fixHelperModified
    stop: (event, ui) ->
      reorder this
      return

  ).disableSelection()

  if $('#traffic').length > 0
    Morris.Area
      lineWidth: '0'
      pointSize: '0'
      grid: false
      element: 'traffic'
      data: $('#traffic').data('points')
      xkey: 'date'
      ykeys: ['count']
      labels: ['Visitors']
      parseTime: false

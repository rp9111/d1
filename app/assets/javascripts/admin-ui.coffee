jQuery ->

  $(window).keydown (e) ->
    if (e.metaKey or e.ctrlKey) and e.keyCode == 83
      saveForm()
      e.preventDefault()
      return false
    return
  
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

  $('#area_mode').change ->
    key = $('#area_mode').val()
    val = $('option[value="' + key + '"]').data('comment')
    $('#mode_comment').text val

  if $('#editor_structure').length > 0
    editorHtml = CodeMirror.fromTextArea($('#editor_structure').get(0),
      tabSize: 2
      indentWithTabs: false
      lineNumbers: true
      matchBrackets: true
      autoCloseBrackets: true
      theme: 'neo'
      styleActiveLine: true
      mode: 'text/html'
      autoCloseTags: true
      matchTags: bothTags: true
      extraKeys: 'Ctrl-J': 'toMatchingTag')

  if $('#editor_behavior').length > 0
    editorJavascript = CodeMirror.fromTextArea($('#editor_behavior').get(0),
      tabSize: 2
      indentWithTabs: false
      lineNumbers: true
      matchBrackets: true
      autoCloseBrackets: true
      theme: 'neo'
      styleActiveLine: true
      mode: 'javascript')

  if $('#editor_style').length > 0
    editorCss = CodeMirror.fromTextArea($('#editor_style').get(0),
      tabSize: 2
      indentWithTabs: false
      lineNumbers: true
      matchBrackets: true
      autoCloseBrackets: true
      theme: 'neo'
      styleActiveLine: true
      mode: 'css')

  if $('#editor_content').length > 0
    editorMarkdown = CodeMirror.fromTextArea($('#editor_content').get(0),
      tabSize: 2
      indentWithTabs: false
      lineNumbers: true
      matchBrackets: true
      autoCloseBrackets: true
      theme: 'neo'
      styleActiveLine: true
      lineWrapping: true
      mode: 'markdown')


  $('#editor-tabs a').click (e) ->
    e.preventDefault()
    $(this).tab 'show'
    $($(this).attr('href')).find('.CodeMirror:first').get(0).CodeMirror.refresh()

  flushEditors = ->
    editorHtml.save() unless editorHtml is undefined
    editorJavascript.save() unless editorJavascript is undefined
    editorCss.save() unless editorCss is undefined
    editorMarkdown.save() unless editorMarkdown is undefined
    
  saveForm = ->
    flushEditors()
    form = $('#editor_form')
    url = $('#editor_form').attr 'action'
    $.ajax
      type: 'POST'
      url: url
      data: form.serialize()
      success: (data) ->
        toastr.info('Okay, saved!')
        false
      failure: (data) ->
        toastr.error('Ah oh. The server couldn\'t save your theme. Try again in a little while.')
        false
    false

  $('#user-table').DataTable
    info: false

    # serverSide: true
    # ajax: $('#user-table').data('source')

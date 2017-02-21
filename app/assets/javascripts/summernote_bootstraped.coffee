# sendFile = (file, el) ->
#   form_data = new FormData
#   form_data.append 'file', file
#   $.ajax
#     data: form_data
#     type: 'POST'
#     url: '/upload'
#     cache: false
#     contentType: false
#     processData: false
#     success: (obj) ->
#       console.log JSON.stringify(obj)
#       $(el).summernote 'editor.insertImage', obj.attachment.url
#       return
#     error: (err) ->
#       console.log err
#       return
#   return
#
# # $('.wysiwyg').summernote
# #   height: 500
# #   onImageUpload: (files, editor, welEditable) ->
# #     # upload image to server and create imgNode...
# #     i = files.length - 1
# #     while i >= 0
# #       sendFile files[i], this
# #       i--
# #     return
#
# # sendFile = (file, editor, welEditable) ->
# #   data = new FormData
# #   data.append 'file', file
# #   $.ajax
# #     data: data
# #     datatype: 'json'
# #     type: 'POST'
# #     url: '/upload'
# #     cache: false
# #     contentType: false
# #     processData: false
# #     success: (url) ->
# #       console.log url
# #       console.log $(editor)
# #       # editor.insertImage welEditable, url
# #       $(editor).summernote('editor.insertImage', url);
# #     error: (err) ->
# #       # console.log err
# #       # $(editor).insertImage welEditable, err
# #       $(editor).summernote('editor.insertImage', err);
# #   return
# #
# jQuery ->
#   $('.summernote').summernote
#     tabsize: 2
#     dialogsInBody: true
#     popover: air: [
#       [
#         'style'
#         [
#           'bold'
#           'italic'
#           'underline'
#           'clear'
#         ]
#       ]
#       [
#         'fontsize'
#         [ 'fontsize' ]
#       ]
#       [
#         'para'
#         [
#           'ul'
#           'ol'
#           'paragraph'
#         ]
#       ]
#       [
#         'insert'
#         [
#           'picture'
#           'link'
#         ]
#       ]
#     ]
#     airMode: true
#     callbacks:
#       onImageUpload: (files, editor, welEditable) ->
#         i = files.length - 1
#         while i >= 0
#           sendFile files[i], this
#           i--
#         return
#
#     # callbacks:
#     #   onImageUpload: (files, editor, welEditable) ->
#     #     sendFile files[0] # , (data) ->
#     #       # alert 'goodbye'
#     #       # url = "#{data.scheme}://#{data.host}#{data.path}"
#     #       # editor.insertImage(welEditable, url)

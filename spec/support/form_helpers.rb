def submit_form
  find('input[name="commit"]').click
end

def sample_file
  File.expand_path('../../app/assets/images/avatar.png', File.dirname(__FILE__))
end

def fill_in_wysihtml5(css_id, options = {})
  options[:with] ||= ''
  page.execute_script("$('##{css_id}').data('wysihtml5').editor.setValue('#{options[:with]}');")
end

def add_content(selector, options = {})
  options[:with] ||= ''
  find(selector).set options[:with]
end

def type_into(selector, options = {})
  find(selector).native.send_keys options[:with]
end

def sendkey(target, keycode, *meta)
  script = "var e=jQuery.Event('key#{meta.empty? ? 'press' : 'down'}');"
  script += "e.metaKey=true;" if meta.include? 'command'
  script += "e.altKey=true;" if meta.include? 'alt'
  script += "e.keyCode=#{keycode};$('#{target}').trigger(e);"
  page.driver.execute_script(script)
end

def force(target, content)
  script = '$("' + target + '").html("' + content + '")'
  page.driver.execute_script(script)
end

# spec/support/integration_helpers.rb
def show_page
  save_and_open_page
  # save_page Rails.root.join('public', 'test.html')
  # Launchy.open Rails.root.join('public', 'test.html').to_s
end

def show_shot
  sleep 1
  save_and_open_screenshot
  # save_screenshot Rails.root.join('tmp', 'capybara', 'test.png')
  # Launchy.open Rails.root.join('tmp', 'capybara', 'test.png').to_s
end


def open_page
  rendered ||= response.body
  IO.write('/tmp/test.html', rendered)
  `open /tmp/test.html`
end
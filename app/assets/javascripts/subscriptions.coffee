jQuery ->
  $form = $('#subscription_form')
  $form.submit (event) ->
    if $('#user_stripe_token').length is 0
      # Disable the submit button to prevent repeated clicks:
      $("#subscribe_button").attr("disabled", true)
      $("#subscribe_button").val("Subscribing...")
      # Request a token from Stripe:
      Stripe.card.createToken $form, stripeResponseHandler
      # Prevent the form from being submitted:
      false
  return

stripeResponseHandler = (status, response) ->
  # Grab the form:
  $form = $('#subscription_form')
  if response.error
    # Problem!
    # Show the errors on the form:
    $form.find('.payment-errors').text response.error.message
    # Re-enable submission
    $("#subscribe_button").attr("disabled", false)
    $("#subscribe_button").val("Subscribe")
  else
    # Token was created!
    # Get the token ID:
    token = response.id
    # Insert the token ID into the form so it gets submitted to the server:
    $form.append $('<input type="hidden" name="user[stripe_token]">').val(token)
    # Submit the form:
    $form.get(0).submit()
  return

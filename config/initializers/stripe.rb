Rails.configuration.stripe = {
  :publishable_key => ENV['STRIPE_SK'],
  :secret_key      => ENV['STRIPE_CLIENT_ID']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]

# pk_test_WOuxu6ZZPDsPH6NEpxUYKagu00nMNIXrtl
# sk_test_AULa1uC5wSoUXCfjIexEsTc400FA8BSNpZ
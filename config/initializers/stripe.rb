Rails.configuration.stripe = {
  :publishable_key => ENV['pk_test_WOuxu6ZZPDsPH6NEpxUYKagu00nMNIXrtl'],
  :secret_key      => ENV['sk_test_AULa1uC5wSoUXCfjIexEsTc400FA8BSNpZ']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
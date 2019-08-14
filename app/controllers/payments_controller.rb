class PaymentsController < ApplicationController
    def index

    end

    def new
        Stripe.api_key = 

        @session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        line_items: [{
        name: 'T-shirt',
        description: 'Comfortable cotton t-shirt',
        images: ['https://example.com/t-shirt.png'],
        amount: 500,
        currency: 'myr',
        quantity: 1,
  }],
  success_url: 'https://example.com/success',
  cancel_url: 'https://example.com/cancel',
)


    end


end

require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'braintree'

Braintree::Configuration.environment = :sandbox
Braintree::Configuration.merchant_id = 'QuickStart_Merchant'
Braintree::Configuration.public_key = 'QuickStart_Public'
Braintree::Configuration.private_key = 'QuickStart_Private'

get '/' do
  erb :braintree
end

post '/' do
  result = Braintree::Transaction.sale(
    :amount => "1000.00",
    :credit_card => {
      :number => params[:number],
      :cvv => params[:cvv],
      :expiration_month => params[:month],
      :expiration_year => params[:year]
    }
  )

  erb :braintree_response, :locals => {:result => result}
end

Before('@moneris_test') do
  $gateway_login = 'store1'
  $gateway_password = 'yesguy'
  ActiveMerchant::Billing::Base.mode = :test
end

require 'money/bank/open_exchange_rates_bank'
require 'monetize'

oxr = Money::Bank::OpenExchangeRatesBank.new
oxr.app_id = ENV['OXR_APP_ID']
oxr.update_rates
Money.default_bank = oxr

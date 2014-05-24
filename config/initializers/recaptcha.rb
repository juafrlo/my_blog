Recaptcha.configure do |config|
  config.public_key  = ENV['RECAPTCHA_PUBLIC_KEY'].to_s
  config.private_key = ENV['RECAPTCHA_PRIVATE_KEY'].to_s
end

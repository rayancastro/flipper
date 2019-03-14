MoneyRails.configure do |config|
  config.default_currency = :brl  # or :gbp, :usd, etc.
  config.no_cents_if_whole = false
  config.default_format = {
    thousands_separator: ".",
    decimal_mark:        ","
   }
  end
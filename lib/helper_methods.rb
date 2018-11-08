module HelperMethods
  def is_date_valid?(dates)
    digit_regex = /\d{4}-\d{2}-\d{2}/
    digit_regex.match(dates)
  end
end

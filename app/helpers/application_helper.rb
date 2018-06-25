module ApplicationHelper
  def format_dollar(val)
    ActiveSupport::NumberHelper.number_to_currency(val)
  end

  def format_date(val)
    val.strftime('%-m/%-d/%Y').to_s
  end
end

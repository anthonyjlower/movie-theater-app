module ApplicationHelper
  def format_dollar(val)
    ActiveSupport::NumberHelper.number_to_currency(val)
  end

  def format_date(val)
    return unless val
    val.strftime('%-m/%-d/%Y').to_s
  end

  def format_showing_date(val)
    return unless val
    val.strftime('%A, %B %e')
  end
end

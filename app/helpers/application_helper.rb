# frozen_string_literal: true

module ApplicationHelper
  def datetime_format(datetime, variant = :short)
    format = case variant
             when :short then datetime < 1.day.ago ? '%m/%d/%y' : '%H:%M'
             when :longer then datetime.today? ? '%H:%M' : '%d %b %H:%M'
             else '%m/%d/%y %H:%M'
             end
    datetime.strftime(format)
  end

  def current_conversation
    defined?(@conversation) ? @conversation : nil
  end
end

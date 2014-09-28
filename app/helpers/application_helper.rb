module ApplicationHelper

  def present_date(days_from_now)
    if days_from_now.zero?
      'Today'
    elsif days_from_now == 1
      'Tomorrow'
    else
      (Time.current.to_date + number.days).to_s
    end
  end

  def date_class(days_from_now)
    if days_from_now.zero?
      'midLeftToday'
    elsif days_from_now == 1
      'midLeftTomorrow'
    else
      'midLeftTomorrow'
    end
  end

end

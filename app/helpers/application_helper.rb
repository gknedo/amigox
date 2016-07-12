module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "Amigo X"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def text_with_side_number(text, number)
    if (number > 0)
      return (text + '<span class="label label-default label-pill pull-xs-right">' + number.to_s + '</span>').html_safe
    else
      return text
    end
  end

  def text_with_black(text)
    return ('<b>' + text + '</b>').html_safe
  end
end
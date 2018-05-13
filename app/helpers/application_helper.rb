module ApplicationHelper
  def today
    Date.today
  end

  def now
    @now ||= Time.now
  end

  def do_hash(value)
    require 'digest/sha1'
    Digest::SHA1.hexdigest(value)
  end

  def decorate(object)
    ActiveDecorator::Decorator.instance.decorate(object)
  end

  def nl2br(text)
    ERB::Util.html_escape(text).gsub(/\r\n|\r|\n/, "<br />").html_safe
  end

  def array_to_collection(values)
    values.map { |value| [value, value] }
  end

  def controller_classes
    "#{controller_path.tr('/', ' ')} #{action_name}"
  end

  def h(text)
    CGI.escapeHTML(text.to_s)
  end

  def auto_link(text)
    URI.extract(text, %w(http https)).uniq.each do |url|
      sub_text = "<a href=\"#{url}\" target=\"_blank\">#{url}</a>"
      text.gsub!(url, sub_text)
    end
    text.html_safe
  end

  def for_logo_path
    if current_user.room.present?
      room_path(current_user.room)
    else
      root_path
    end
  end
end

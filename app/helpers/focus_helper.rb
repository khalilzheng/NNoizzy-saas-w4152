module FocusHelper
  def current_sound_line(title)
    t = (title.to_s.strip.empty? || title.to_s.strip.casecmp('None').zero?) ? 'None' : title.to_s
    "Current Sound: #{t}"
  end
end

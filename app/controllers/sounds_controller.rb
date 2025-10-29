class SoundsController < ApplicationController
  def index
    respond_to do |format|
      format.html { redirect_to root_path }
      format.json do
        curated = Sound.where(is_curated: true)
        if curated.exists?
          render json: curated.map { |s| serialize_sound(s) }
        else
          render json: []
        end
      end
    end
  end

  private

  def serialize_sound(s)
    {
      id: force_int(s.id),
      name: derive_name(s),
      file_url: pick_file_url(s),
      is_curated: derive_is_curated(s)
    }
  end

  def force_int(v)
    v.is_a?(String) ? v.to_i : (v || 0).to_i
  end

  def pick_file_url(s)
 
    val =
      if s.respond_to?(:file_url) && s.file_url.present?
        s.file_url
      elsif s.respond_to?(:audio_url) && s.audio_url.present?
        s.audio_url
      elsif s.respond_to?(:url) && s.url.present?
        s.url
      else
        ""
      end
    val.to_s
  end

  def derive_is_curated(s)
    if s.respond_to?(:is_curated) && !s.is_curated.nil?
      !!s.is_curated
    elsif s.respond_to?(:curated)
      !!s.curated
    else
      false
    end
  end

  def derive_name(s)
 
    n = s.respond_to?(:name) ? s.name.to_s.strip : ""
    return n unless n.empty?
 
    t = s.respond_to?(:title) ? s.title.to_s.strip : ""
    return t unless t.empty?

 
    from_file = humanize_slug(File.basename(pick_file_url(s)).sub(/\.\w+\z/, ""))
    return from_file unless from_file.empty?

    ""
  end

  def humanize_slug(slug)
    return "" if slug.to_s.strip.empty?
    slug.to_s.tr("_-", " ").split.map { |w| w[0] ? w[0].upcase + w[1..] : w }.join(" ")
  end
end

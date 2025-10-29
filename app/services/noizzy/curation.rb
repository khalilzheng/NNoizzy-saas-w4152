module Noizzy
  module Curation
    module_function

    # "White Noise" -> "white_noise.mp3"
    def normalize_filename(name)
      name.to_s.strip.downcase.gsub(/[^\w]+/, '_') + '.mp3'
    end

 
    def build_payload(sound)
      {
        title:   (sound.respond_to?(:name) ? sound.name : sound.try(:title)).to_s,
        file_url: [
          (:file_url if sound.respond_to?(:file_url)),
          (:audio_url if sound.respond_to?(:audio_url)),
          (:url if sound.respond_to?(:url)),
          (:path if sound.respond_to?(:path)),
          (:source if sound.respond_to?(:source))
        ].compact.map { |m| sound.public_send(m) }.compact.first.to_s
      }
    end
  end
end

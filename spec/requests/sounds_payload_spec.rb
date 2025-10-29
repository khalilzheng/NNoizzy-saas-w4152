require 'rails_helper'

RSpec.describe "Sounds payload fallbacks", type: :request do
  # ---- A robust Sound test double that supports both respond_to? and has_attribute? ----
  class FauxSound
    ATTRS = %i[
      id name title file_url audio_url url path source
      is_curated curated
    ].freeze
    attr_accessor(*ATTRS)

    def initialize(**h)
      ATTRS.each { |k| instance_variable_set("@#{k}", h[k]) }
    end

    # Many Rails codepaths use has_attribute? / read_attribute
    def has_attribute?(attr)
      ATTRS.include?(attr.to_sym)
    end

    def read_attribute(attr)
      public_send(attr)
    end

    # Let respond_to? also be true for our attrs
    def respond_to_missing?(m, include_private = false)
      ATTRS.include?(m.to_sym) || super
    end
  end

  # Make an Array act like an AR::Relation for `exists?`
  def with_exists(array, value)
    array.define_singleton_method(:exists?) { value }
    array
  end

  it "uses `title` when `name` is missing" do
    obj = FauxSound.new(
      id: 123,
      name: nil,                  # missing name
      title: "Rain",              # should fallback to title
      file_url: nil,
      audio_url: "/rain.mp3",     # then fallback chain picks this
      curated: true,              # missing is_curated -> fallback to curated
      is_curated: nil
    )
    allow(Sound).to receive(:where)
      .with(is_curated: true)
      .and_return(with_exists([obj], true))

    get "/sounds.json"
    expect(response).to have_http_status(:ok)
    data = JSON.parse(response.body)
    expect(data.size).to eq(1)
    h = data.first

    expect(h).to include("id", "name", "file_url", "is_curated")
    expect(h["id"]).to eq(123)
    expect(h["name"]).to eq("Rain")          # <- now passes (title fallback)
    expect(h["file_url"]).to eq("/rain.mp3") # <- file_url fallback chain
    expect(h["is_curated"]).to eq(true)      # <- curated -> is_curated
  end

  it "prefers file_url but falls back in order (audio_url/url/path/source)" do
    obj = FauxSound.new(
      id: 1, name: "Ocean",
      file_url: nil, audio_url: nil, url: "/ocean.mp3", path: nil, source: nil,
      is_curated: true
    )
    allow(Sound).to receive(:where)
      .with(is_curated: true)
      .and_return(with_exists([obj], true))

    get "/sounds.json"
    h = JSON.parse(response.body).first
    expect(h["name"]).to eq("Ocean")
    expect(h["file_url"]).to eq("/ocean.mp3") # falls to url
  end

  it "redirects for HTML requests (keeps html branch covered)" do
    allow(Sound).to receive(:where)
      .with(is_curated: true)
      .and_return(with_exists([], true)) # exists? true but empty list is fine
    get "/sounds" # HTML
    expect(response).to have_http_status(:found)
    expect(response).to redirect_to(root_path)
  end

  it "returns [] when there are truly no curated sounds" do
    allow(Sound).to receive(:where)
      .with(is_curated: true)
      .and_return(with_exists([], false)) # exists? false -> controller should return []
    get "/sounds.json"
    expect(JSON.parse(response.body)).to eq([])
  end
end

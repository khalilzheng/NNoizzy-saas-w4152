require 'rails_helper'

RSpec.describe "Focus page", type: :request do
  it "renders focus index with the expected UI keywords" do
    get "/"
    expect(response).to have_http_status(:ok)
    html = response.body

    expect(html).to include("Noizzy")
    expect(html).to include("Instant Start")
    expect(html).to match(/Current(\s*Sound)?\s*:/i)

 
    %w[Rain Ocean Fan].each { |t| expect(html).to include(t) }

 
    expect(html).to include("Play")
    expect(html).to include("Pause")
    expect(html).to include("Volume")
  end
end

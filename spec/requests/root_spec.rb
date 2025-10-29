require 'rails_helper'

RSpec.describe "Root", type: :request do
  it "renders the homepage successfully" do
    get root_path
    expect(response).to have_http_status(:ok)
 
    expect(response.body).to include("Instant Start").or include("Timer")
  end
end

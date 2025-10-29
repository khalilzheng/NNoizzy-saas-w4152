 
require 'rails_helper'

RSpec.describe "Sounds (HTML)", type: :request do
  it "redirects /sounds (HTML) to the homepage" do
    get "/sounds" 
    expect(response).to redirect_to(root_path)
  end
end

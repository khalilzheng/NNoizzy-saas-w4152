class HomeController < ApplicationController
  def index
    @curated = Sound.where(is_curated: true).order(:name).pluck(:name)
    @curated = %w[Rain Ocean Fan] if @curated.empty?

    respond_to do |format|
      format.html # renders app/views/home/index.html.erb
      format.json { render json: { curated: @curated } }
      # catch-all to avoid 406 for any other Accept
      format.any  { head :ok }
    end
  end
end

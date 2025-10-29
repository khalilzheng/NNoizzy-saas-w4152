class FocusController < ApplicationController
  def index
    @sounds = Sound.where(is_curated: true)
    @sounds = @sounds.order(:position) if Sound.column_names.include?('position')
  end
end
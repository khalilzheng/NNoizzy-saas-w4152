require 'rails_helper'

RSpec.describe Sound, type: :model do
  describe '.curated' do
    it 'returns only curated sounds' do
      s1 = Sound.create!(name: 'Rain', file_url: '/rain.mp3', is_curated: true)
      s2 = Sound.create!(name: 'Fan',  file_url: '/fan.mp3',  is_curated: false)
      expect(Sound.curated).to eq([s1])
    end
  end

  describe 'validations' do
    it 'requires name' do
      s = Sound.new(file_url: '/x.mp3')
      expect(s.valid?).to be false
      expect(s.errors[:name]).to be_present
    end

    it 'requires file_url' do
      s = Sound.new(name: 'X')
      expect(s.valid?).to be false
      expect(s.errors[:file_url]).to be_present
    end
  end
end

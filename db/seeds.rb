Sound.destroy_all

Sound.create!(
  name: "Rain",
  file_url: "/sounds/rain.mp3",
  is_curated: true
)

Sound.create!(
  name: "Ocean",
  file_url: "/sounds/ocean.mp3",
  is_curated: true
)

Sound.create!(
  name: "Fan",
  file_url: "/sounds/fan.mp3",
  is_curated: true
)

puts "Seeded #{Sound.count} curated sounds."
puts "Place the mp3 files in public/sounds/: rain.mp3, ocean.mp3, fan.mp3"

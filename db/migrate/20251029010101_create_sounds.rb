class CreateSounds < ActiveRecord::Migration[7.1]
  def change
    create_table :sounds do |t|
      t.string  :title,    null: false
      t.string  :file_url, null: false
      t.integer :duration_sec
      t.boolean :curated,  null: false, default: false
      t.timestamps
    end

    add_index :sounds, :title
  end
end

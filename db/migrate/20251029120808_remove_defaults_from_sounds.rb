 class RemoveDefaultsFromSounds < ActiveRecord::Migration[7.1]
  def up
    change_column_default :sounds, :title,    from: "",  to: nil if column_exists?(:sounds, :title)
    change_column_default :sounds, :file_url, from: "",  to: nil if column_exists?(:sounds, :file_url)
  end

  def down
    change_column_default :sounds, :title,    from: nil, to: ""  if column_exists?(:sounds, :title)
    change_column_default :sounds, :file_url, from: nil, to: ""  if column_exists?(:sounds, :file_url)
  end
end

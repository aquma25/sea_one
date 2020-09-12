class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.string "type"
      t.string "image"
      t.integer "play_ground_id", null: false

      t.timestamps
    end
  end
end

class CreateCourts < ActiveRecord::Migration[5.2]
  def change
    create_table :courts do |t|
      t.string  :address
      t.float   :latitude
      t.float   :longitude
      t.string  :court_name
      t.text    :content
      t.string  :place
      t.integer :status
      t.boolean :release
      t.string  :nearest
      t.time    :start_time
      t.time    :end_time
      t.integer :usage_fee
      t.string  :usage_week
      t.integer :user_id

      t.timestamps
      t.integer :lock_version
    end
  end
end

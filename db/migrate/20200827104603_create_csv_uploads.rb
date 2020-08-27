class CreateCsvUploads < ActiveRecord::Migration[5.2]
  def change
    create_table :csv_uploads do |t|
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end

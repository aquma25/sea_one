class CsvUpload < ApplicationRecord

  # static method
  class << self

    def import(file)
      CSV.foreach(file.path, headers: true) do |row|
        csv = CsvUpload.find_or_initialize_by(id: row["id"])
        begin
          csv.attributes = row.to_h
          csv.save!
        rescue => e
          logger.error "CSVファイルを保存出来ませんでした"
        end
      end
    end

  end
end

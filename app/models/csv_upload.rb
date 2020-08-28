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

    def export(id, email)
      csv_cont = CsvUpload.find(id)
      file_name = "id:#{id}" + "_" + email + "_" + Date.current.strftime("%Y%m%d")

      new_csv = CSV.generate do |csv|
        column_names = CsvUpload.column_names.reject{|i| i=="id" || i=="created_at" || i=="updated_at"}
        csv << column_names #１行目の項目
        csv << csv_cont.attributes.values_at(*column_names) # ２行目以降の内容
      end

      # ファイルに書き込む
      File.open("../#{file_name}.csv", "w", encoding: "UTF-8") do | file |
        file.write(new_csv)
      end

      [File::stat("../#{file_name}.csv").size, file_name]
    end
  end
end

class CsvUploadsController < ApplicationController
  def index
    @csv_uploads = CsvUpload.all
  end

  def csv_import
    CsvUpload.import(params["file"]) if params["file"].present?
    redirect_to csv_uploads_path
  end

  def csv_export
    head :no_content
    stat_size, file_name = CsvUpload.export(params[:id], current_user.email)

    # send_fileで自動的にDLされる
    send_file("../#{file_name}.csv", filename: "#{file_name}.csv", length: stat_size)
  end
end

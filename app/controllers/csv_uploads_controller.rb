class CsvUploadsController < ApplicationController
  def index
    @csv_uploads = CsvUpload.all
  end

  def csv_import
    CsvUpload.import(params["file"]) if params["file"].present?
    redirect_to csv_uploads_path
  end
end

module ExcelFilesHelper
  def add_courses_to_database(file, id)
    as_id = id
    if file.is_a?(ActiveStorage::Blob)
      # blob = params[:post][:file].blob
      # FileParser.new(blob, as_id).parse
      FileParser.new(ActiveStorage::Blob.find_by(id: as_id).attachments.first, as_id).parse
    else
      FileParser.new(file, as_id).parse
    end
  end
end

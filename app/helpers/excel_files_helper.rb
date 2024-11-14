module ExcelFilesHelper
  def add_courses_to_database(file, id)
    as_id = id
    FileParser.new(file, as_id).parse
  end
end

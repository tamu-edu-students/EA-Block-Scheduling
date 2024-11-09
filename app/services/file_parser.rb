# app/services/file_parser.rb

require "stringio"
require "roo"
require "roo/formatters/xml"
require_relative "../models/course"

# File parser class. Takes in excel file of college classes to be put in database.
class FileParser
  attr_reader :file_name, :term, :file, :as_id, :result
  Result = Struct.new(:successful?, :errors)

  def initialize(file, id)
    @result = Result.new(false, nil)
    if file.is_a?(ExcelFile)
      @file = ActiveStorage::Blob.find_by(id: id)
    elsif file.is_a?(ActiveStorage::Blob)
      @file = ActiveStorage::Blob.find_by(id: id)
    else
      @file = file
    end
    @as_id = id
    set_file_name(file)
    @term = generate_term
  end

  def parse
    if @file.nil?
      return Result.new(false, "No file attachment found")
    end
    if @file.is_a?(ActiveStorage::Blob)
      Tempfile.create([@file_name, "xlsx"]) do |temp_file|
        temp_file.binmode
        temp_file.write(@file.download)
        temp_file.rewind
        parse_xlsx(temp_file.path)
      end
    else
      parse_xlsx(@file.path)
    end
  end

  def set_file_name(file)
    case file
    when ActiveStorage::Blob
      @file_name = file.filename.to_s
    when ExcelFile
      @file_name = file.file.filename.to_s
    else
      @file_name = File.basename(file.to_s)
    end
  end

  def parse_xlsx(file_path)
    @as_id = 1 if @as_id.nil?
    begin
      xlsx = Roo::Spreadsheet.open(file_path, extension: :xlsx)
      data = []
      t = @term || ""
      xlsx.each_with_index do |row, row_index|
        next if row.empty? || row.nil?
        next if row_index == 0 || row[0].nil?
        start_t, end_t, dept_code, course_id = get_parsed_values(row[0].to_s, row[7].to_s)
        data << { term: t, dept_code: dept_code, course_id: course_id, course: row[0], syn: row[1], instructor: row[2],
                  location: row[3], room: row[4], days: row[6], start_time: start_t, end_time: end_t, as_id: @as_id }
      end
      add_courses(data)
      @result = Result.new(true, nil)
    rescue Exception
      if File.extname(@file_name) != ".xlsx"
        @result = Result.new(false, "Invalid file format")
      end
    end
  end

  def generate_term
    re = @file_name.match(/(?<year>\d{4})[_\s]+(?<sem>spring|fall)|(?<sem2>spring|fall)[_\s]+(?<year2>\d{4})/i)
    if re.nil?
      nil
    else
      year = re[:year].nil? ? re[:year2][2, 2] : re[:year][2, 2]
      sem = re[:sem].nil? ? re[:sem2][2, 2] : re[:sem][2, 2]
      "2#{year}#{sem}000"
    end
  end

  def get_parsed_values(course, time)
    start_t = time.split("-")[0]
    end_t = time.split("-")[1]
    dept_code = course[/(chem|math|phys|clen|engr)/i] || ""
    course_id = course[/\d{3,4}/] || ""
    start_t.gsub(/[[:space:]]/, "") unless start_t.nil?
    end_t.gsub(/[[:space:]]/, "") unless end_t.nil?
    [start_t, end_t, dept_code, course_id]
  end

  def add_courses(data)
    data.each do |d|
      Course.where(term: d[:term], dept_code: d[:dept_code], course_id: d[:course_id], sec_coreq_secs: "",
                   syn: d[:syn], sec_name: d[:course], short_title: "", im: "", building: d[:building],
                   room: d[:room], days: d[:days], start_time: d[:start_time], end_time: d[:end_time],
                   crs_capacity: nil, sec_cap: nil, student_count: 0, notes: "", as_id: d[:as_id]).first_or_create
    end
  end
end

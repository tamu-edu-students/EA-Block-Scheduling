# app/services/file_parser.rb

require "stringio"
require "roo"
require "roo/formatters/xml"
require_relative "../models/course"

# File parser class. Takes in excel file of college classes to be put in database.
class FileParser
  attr_reader :file_name, :term, :file, :as_id, :result
  Result = Struct.new(:successful?, :errors)

  def initialize(file, as_id)
    @result = Result.new(false, nil)
    @as_id = as_id
    @file = file
    if file.respond_to?(:blob)
      # @file = file.blob
      @file_name = file.blob.filename.to_s
    else
      # @file = File.read(file)
      @file_name = File.basename(file.path)
    end
    @term = generate_term
  end

  def parse
    @as_id = 1 if @as_id.nil?
    # if file.respond_to?(:blob)
    #   stream = StringIO.new(@file.download)
    # else
    #   stream = @file
    # end
    begin
      xlsx = Roo::Spreadsheet.open(@file.path)
      data = []
      t = @term || ""
      xlsx.each_with_index do |row, row_index|
        next if row_index == 0 || row[0].to_s.nil?
        start_t, end_t, dept_code, course_id = get_parsed_values(row[0].to_s, row[7].to_s)
        data << { term: t, dept_code: dept_code, course_id: course_id, course: row[0], syn: row[1], instructor: row[2],
                  location: row[3], room: row[4], days: row[6], start_time: start_t, end_time: end_t, as_id: @as_id }
      end
      add_courses(data)
      @result = Result.new(true, nil)
    rescue Exception => e
      if File.extname(@file_name) != ".xlsx"
        @result = Result.new(false, "Invalid file format")
      else
        @result = Result.new(false, e)
      end
    end
  end

  def generate_term
    re = @file_name.match(/(?<year>\d{4})[_\s]+(?<sem>spring|fall)|(?<sem>spring|fall)[_\s]+(?<year>\d{4})/i)
    if re.nil?
      nil
    else
      "2#{re[:year][2, 2]}#{re[:sem][0, 1]}000"
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
                   crs_capacity: nil, sec_cap: nil, student_count: 0, notes: "").first_or_create
    end
  end
end

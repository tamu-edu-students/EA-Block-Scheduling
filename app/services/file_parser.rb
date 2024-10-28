# app/services/file_parser.rb

require "stringio"
require "roo"
require "roo/formatters/xml"
require_relative "../models/course"

# File parser class. Takes in excel file of college classes to be put in database.
class FileParser
  attr_reader :file_name, :file_stream, :f
  Result = Struct.new(:successful?, :data, :errors)

  def initialize(file)
    @f = file
    if file.respond_to?(:blob)
      @file_name = file.blob.filename.to_s
      file_content = file.blob.download
      @file_stream = StringIO.new(file_content, encoding: "ISO-8859-1")
    else
      @file_name = File.basename(file.path)
      file_content = File.read(file.path)
      @file_stream = StringIO.new(file_content)
    end
  end

  def parse
    begin
      xlsx = Roo::Spreadsheet.open(@f)
      data = []
      xlsx.each_with_index do |row, row_index|
        next if row_index == 0 || row[0].nil?
        start_t, end_t = get_start_end(row[7])

        data << {
          course: row[0],
          syn: row[1],
          instructor: row[2],
          location: row[3],
          room: row[4],
          days: row[6],
          start_time: start_t,
          end_time: end_t
        }
      end
      Result.new(true, data, nil)
    rescue Exception => e
      Result.new(false, [], "Invalid file format")
    end
  end

  def get_start_end(time)
    start_t = time.split("-")[0].gsub(/[[:space:]]/, "") || ""
    end_t = time.split("-")[1].gsub(/[[:space:]]/, "") || ""
    [start_t, end_t]
  end
end

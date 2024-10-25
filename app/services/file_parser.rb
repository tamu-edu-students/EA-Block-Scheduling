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
    @file_name = file.respond_to?(:blob) ? file.blob.filename.to_s : File.basename(file.path)
    file_content = file.respond_to?(:blob) ? file.blob.download : File.read(file.path)
    @file_stream = file.respond_to?(:blob) ? StringIO.new(file_content, encoding: "ISO-8859-1") : StringIO.new(file_content)
  end

  def parse
    begin
      xlsx = Roo::Spreadsheet.open(@f)
      data = []

      xlsx.each_with_index do |row, row_index|
        next if row_index == 0 || row[0].nil?
        start_t = row[7].split("-")[0].gsub(/[[:space:]]/, "") unless row[7].nil?
        end_t = row[7].split("-")[1].gsub(/[[:space:]]/, "") unless row[7].nil?

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
end

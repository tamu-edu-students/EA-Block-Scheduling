require "roo"
require "csv"
module DocumentsHelper
  def parse_excel
    file_path = ActiveStorage::Blob.service.path_for(file.key)
    xlsx = Roo::Spreadsheet.open(file_path, extension: :xlsx)
    parsed_data = []
    begin
      sheet = xlsx.sheet(0)
      sheet.each do |row|
        p row
        start_t = row[7].split("-")[0] unless row[7].nil?
        end_t = row[7].split("-")[1] unless row[7].nil?
        parsed_data << {
          sec_name: row[0],
          syn: row[1],
          faculty_name: row[2],
          building: row[3],
          room: row[4],
          days: row[6],
          start_time: start_t,
          end_time: end_t
        }
      end
    rescue NoMethodError => e
      p e.message
    end
    parsed_data.compact!
  end

  def parse_csv(file)
    file_path = ActiveStorage::Blob.service.path_for(file.key)
    parsed_data = []

    CSV.foreach(file_path, headers: true) do |row|
      start_t = row["Time"].split(" - ")[0] unless row[7].nil?
      end_t = row["Time"].split(" - ")[1] unless row[7].nil?
      parsed_data << {
        sec_name: row["Course"],
        syn: row["Syn"],
        faculty_name: row["Instructor"],
        building: row["Location"],
        room: row["Room"],
        days: row["Days"],
        start_time: start_t,
        end_time: end_t
      }
    end
    parsed_data.compact!
  end
end

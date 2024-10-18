class ExcelFile < ApplicationRecord
  has_one_attached :file

  validates :name, presence: true
  validates :file, presence: true
  validate :correct_file_type

  def process_file
    return unless file.attached?

    begin
      spreadsheet = if Rails.env.test?
        file_path = ActiveStorage::Blob.service.path_for(file.key)
        Roo::Spreadsheet.open(file_path, extension: :xlsx)
      else
        Roo::Spreadsheet.open(file.download, extension: :xlsx)
      end

      header = spreadsheet.row(1)
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        # Process each row here
        puts row.inspect  # For demonstration; replace with actual processing logic
      end
    rescue IOError => e
      Rails.logger.error "Error processing file: #{e.message}"
      false
    end
  end

  private

  def correct_file_type
    if file.attached? && !file.content_type.in?(["application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "application/vnd.ms-excel"])
      errors.add(:file, "must be an Excel file")
    end
  end
end

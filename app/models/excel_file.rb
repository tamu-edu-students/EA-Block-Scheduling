class ExcelFile < ApplicationRecord
  has_one_attached :file

  validates :name, presence: true
  validates :file, presence: true
  validate :correct_file_type

  private

  def correct_file_type
    if file.attached? && !file.content_type.in?(["application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "application/vnd.ms-excel"])
      errors.add(:file, "must be an Excel file")
    end
  end
end

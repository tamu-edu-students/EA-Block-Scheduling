require 'rails_helper'

RSpec.describe ExcelFile, type: :model do

  it "is valid with a name and attached Excel file" do
    excel_file = ExcelFile.new(name: "Test File")
    excel_file.file.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'test.xlsx')), filename: 'test.xlsx', content_type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
    expect(excel_file).to be_valid
  end

  it "is invalid without a name" do
    excel_file = ExcelFile.new
    excel_file.valid?
    expect(excel_file.errors[:name]).to include("can't be blank")
  end

  it "is invalid without an attached file" do
    excel_file = ExcelFile.new(name: "Test File")
    excel_file.valid?
    expect(excel_file.errors[:file]).to include("can't be blank")
  end

  it "is invalid with a non-Excel file" do
    excel_file = ExcelFile.new(name: "Test File")
    excel_file.file.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'test.txt')), filename: 'test.txt', content_type: 'text/plain')
    excel_file.valid?
    expect(excel_file.errors[:file]).to include("must be an Excel file")
  end

  describe "#process_file" do
    it "processes the uploaded Excel file" do
      excel_file = ExcelFile.create(name: "Test File")
      excel_file.file.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'test.xlsx')), filename: 'test.xlsx', content_type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')

      expect { excel_file.process_file }.not_to raise_error
      # Add more specific expectations based on your processing logic
    end
  end

  describe "#process_file" do
    it "processes the uploaded Excel file" do
      excel_file = ExcelFile.new(name: "Test File")
      file_path = Rails.root.join('spec', 'fixtures', 'files', 'test.xlsx')
      excel_file.file.attach(io: File.open(file_path), filename: 'test.xlsx', content_type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
      excel_file.save!

      expect(excel_file.file).to be_attached
      expect { excel_file.process_file }.not_to raise_error
    end
  end
end

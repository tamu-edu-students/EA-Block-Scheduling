namespace :import do
  desc "Uploads data from xlsx"
  task :excel_data, [:xlsx_path] => :environment do |_t, args|
    excel_files_controller = ExcelFilesController.new
    excel_files_controller.import_data(xlsx_path: args[:xlsx_path])
  end
end

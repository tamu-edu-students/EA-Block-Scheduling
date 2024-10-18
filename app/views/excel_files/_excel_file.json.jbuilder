json.extract! excel_file, :id, :name, :file, :created_at, :updated_at
json.url excel_file_url(excel_file, format: :json)
json.file url_for(excel_file.file)

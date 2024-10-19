# app/controllers/documents_controller.rb

class DocumentsController < ApplicationController
  include DocumentsHelper

  def index
    @documents = Document.all
  end

  def new
    @document = Document.new
  end

  def delete
    @document = Document.find(params[:id])
    @document.destroy
    flash[:notice] = "Deleted document"
    redirect_to documents_path
  end

  def create
    @document = Document.new(document_params)
    success = false
    if @document.save
      if excel_file?(@document.file)
        parsed_data = parse_excel(file)
        p parsed_data
        success = true
      elsif csv_file?(@document.file)
        parsed_data = parse_csv(file)
        success = true
        p parsed_data
      else
        success = false
        # render json: { success: false, message: "File uploaded successfully, but unsupported file type" }, status: :ok
      end
    else
      success = false
      render json: { success: false, error: @document.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end

    redirect_to document_show_path(parsed_data: parsed_data) if success
  end

  def show
    @parsed_data = params[:parsed_data]
  end

  private

  def excel_file?(file)
    file.content_type.in? %w[application/vnd.ms-excel application/vnd.openxmlformats-officedocument.spreadsheetml.sheet]
  end

  def csv_file?(file)
    file.content_type == "text/csv" || file.content_type == "application/csv"
  end

  def document_params
    params.require(:document).permit(:file, :title, :description)
  end
end

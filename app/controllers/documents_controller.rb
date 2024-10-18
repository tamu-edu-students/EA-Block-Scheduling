# app/controllers/documents_controller.rb

class DocumentsController < ApplicationController
  def new
    @document = Document.new
  end
  def create
    @document = Document.new(document_params)
    if @document.save
      redirect_to @document, { success: true, message: "File uploaded successfully" }, status: :ok
    else
      render :new
    end
  end

  private
  def document_params
    params.require(:document).permit(:file)
  end
end

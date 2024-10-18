class ExcelFilesController < ApplicationController
  include Rails.application.routes.url_helpers
  before_action :set_excel_file, only: %i[ show edit update destroy ]
  # has_one_attached :file
  # GET /excel_files or /excel_files.json
  def index
    @excel_files = ExcelFile.all
  end

  # GET /excel_files/1 or /excel_files/1.json
  def show
  end

  # GET /excel_files/new
  def new
    @excel_file = ExcelFile.new
  end

  # GET /excel_files/1/edit
  def edit
  end

  # POST /excel_files or /excel_files.json
  def create
    @excel_file = ExcelFile.new(excel_file_params)

    respond_to do |format|
      if @excel_file.save
        format.html { redirect_to @excel_file, notice: "Excel file was successfully uploaded and saved." }
        format.json { render :show, status: :created, location: @excel_file }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @excel_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # def create
  #   @excel_file = ExcelFile.new(excel_file_params)

  #   if @excel_file.save
  #     if @excel_file.process_file
  #       redirect_to @excel_file, notice: 'Excel file was successfully uploaded and processed.'
  #     else
  #       flash.now[:alert] = 'Error processing the file.'
  #       render :new
  #     end
  #   else
  #     flash.now[:alert] = @excel_file.errors.full_messages.join(', ')
  #     render :new
  #   end
  # end

  # PATCH/PUT /excel_files/1 or /excel_files/1.json
  def update
    respond_to do |format|
      if @excel_file.update(excel_file_params)
        format.html { redirect_to @excel_file, notice: "Excel file was successfully updated." }
        format.json { render :show, status: :ok, location: @excel_file }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @excel_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /excel_files/1 or /excel_files/1.json
  def destroy
    @excel_file.destroy!

    respond_to do |format|
      format.html { redirect_to excel_files_path, status: :see_other, notice: "Excel file was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def process_file
    return false unless file.attached?

    begin
      spreadsheet = if file.blob.attachable?
                      Roo::Spreadsheet.open(file.blob.service.path_for(file.key), extension: :xlsx)
      else
                      Roo::Spreadsheet.open(file.download, extension: :xlsx)
      end

      header = spreadsheet.row(1)
      # Add your processing logic here
      # For example, you might want to read data from the spreadsheet and save it to your database

      true # Return true if processing was successful
    rescue ArgumentError => e
      errors.add(:file, "could not be processed: #{e.message}")
      false # Return false if there was an error
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_excel_file
      @excel_file = ExcelFile.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def excel_file_params
      params.require(:excel_file).permit(:name, :file)
    end
end

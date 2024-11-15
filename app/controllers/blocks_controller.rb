class BlocksController < ApplicationController
  # Skip login requirement in test environment
  skip_before_action :require_login, if: -> { Rails.env.test? }
  
  def index
    @blocks = defined?(@@generated_blocks) ? @@generated_blocks : []
    render :index
  end

  def generate
    courses = Course.all
    @@generated_blocks = Block.generate_blocks(courses)
    @blocks = @@generated_blocks    
    redirect_to blocks_path, notice: "Generated #{@@generated_blocks.length} blocks! Review the generated blocks."
  end

  def preview
    if defined?(@@generated_blocks)
      @generated_blocks = @@generated_blocks
    else
      redirect_to blocks_path
      return
    end
  end

  def export
    @blocks = defined?(@@generated_blocks) ? @@generated_blocks : []
    
    respond_to do |format|
      format.html { redirect_to blocks_path }
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="course_blocks.xlsx"'
        render xlsx: 'export', locals: { blocks: @blocks }
      }
    end
  end
end
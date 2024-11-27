class BlocksController < ApplicationController
<<<<<<< HEAD
  include BlocksHelper
=======
>>>>>>> origin/Blockgen-Re
  before_action :require_admin
  skip_before_action :require_admin, if: -> { Rails.env.test? }

  def index
    @blocks = defined?(@@generated_blocks) ? @@generated_blocks : []
    @generated_blocks = @blocks  # Keep this for backward compatibility if needed
    render :index
  end

  def generate
    courses = Course.all
    @@generated_blocks = Block.generate_blocks(courses)
    redirect_to blocks_path, notice: "Generated #{@@generated_blocks.length} blocks! Review the generated blocks."
  end

  def preview
    if defined?(@@generated_blocks)
      @generated_blocks = @@generated_blocks
<<<<<<< HEAD
      render :index
=======
      render :preview
>>>>>>> origin/Blockgen-Re
    else
      redirect_to blocks_path
    end
  end

  def export
    @blocks = defined?(@@generated_blocks) ? @@generated_blocks : []

    respond_to do |format|
      format.html { redirect_to blocks_path }
      format.xlsx {
        response.headers["Content-Disposition"] = 'attachment; filename="course_blocks.xlsx"'
        render xlsx: "export", locals: { blocks: @blocks }
      }
    end
  end
end

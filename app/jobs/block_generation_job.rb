# /app/jobs/block_generation_job.rb
class BlockGenerationJob < ApplicationJob
  queue_as :default

  def perform
    # Clear existing blocks if needed
    Block.destroy_all

    # Generate new blocks
    blocks = Block.generate_blocks

    # Log results
    Rails.logger.info "Generated #{blocks.count} blocks"
  end
end

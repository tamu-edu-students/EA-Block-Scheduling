class BlocksController < ApplicationController
    def index
      @all_classes = ScheduleManager.instance.all_classes
      render json: @all_classes
    end
  
    def create_typical_block
      @typical_block = Block.new(typical_block_params)
      if @typical_block.save
        redirect_to blocks_path, notice: 'Typical block was successfully created.'
      else
        @classes = Class.all
        render :new_typical_block
      end
    end
  
    private

  
    def get_typical_blocks
      typical_blocks = ScheduleManager.instance.typical_blocks
      render json: typical_blocks
    end
  
    def new_typical_block
        @classes = Class.all  # Assuming you have a Class model
        @typical_block = Block.new
    end
    
      def create_typical_block
        @typical_block = Block.new(typical_block_params)
        if @typical_block.save
          redirect_to blocks_path, notice: 'Typical block was successfully created.'
        else
          @classes = Class.all
          render :new_typical_block
        end
      end
    
      private
    
      def typical_block_params
        params.require(:block).permit(:name, :description, class_ids: [])
      end
end
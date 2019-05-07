class BlocksController < ApplicationController
  def create
    @block = Block.new(:blocker_id => @user_id, :blockee_id => params["user_id"].to_i)
    @friendship1 = Friendship.find_by(user_1_id: @user_id, user_2_id: params["user_id"].to_i)
    @friendship2 = Friendship.find_by(user_2_id: @user_id, user_1_id: params["user_id"].to_i)
    if @block.save
      if @friendship1
        @friendship1.destroy
      end
      if @friendship2
        @friendship2.destroy
      end
      flash[:notices] = ["User blocked"]
      redirect_to launchpad_path
    else
        flash[:errors] = ["Cannot block user"]
        redirect_to launchpad_path
    end
  end

  def destroy
    @block = Block.find_by(blocker_id: @user_id, blockee_id: params["user_id"].to_i)
    if @block
      @block.destroy
      flash[:notices] = ["User no longer blocked"]
      redirect_to launchpad_path
    else
      flash[:errors] = ["Action failed"]
      redirect_to launchpad_path
    end
    
  end
end
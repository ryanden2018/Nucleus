class BlocksController < ApplicationController
  def create
    @block = Block.new(:blocker_id => @user_id, :blockee_id => params["user_id"].to_i)
    @other_user = User.find(params["user_id"].to_i)
    if @block.save
      Friendship.remove_friendship(@user,@other_user)
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
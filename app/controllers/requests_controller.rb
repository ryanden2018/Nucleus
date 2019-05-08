class RequestsController < ApplicationController
  def create
    @friend_request = Request.new(:sender_id => @user_id, :reciever_id => params["friend_id"])
    if @friend_request.save
        flash[:notices] = ["Friend request sent"]
        redirect_to launchpad_path
    else
        flash[:errors] = ["Cannot send friend request"]
        redirect_to launchpad_path
    end
  end

  def destroy
    #@friend_request = Request.find_by(reciever_id: @user_id, sender_id: params["friend_id"])
    @friend_request = Request.find(params[:id])
    if @friend_request
      @friend_request.destroy
      flash[:notices] = ["Friend request ignored"]
      redirect_to launchpad_path
    else
      flash[:errors] = ["Ignore action failed"]
      redirect_to launchpad_path
    end
    
  end
end
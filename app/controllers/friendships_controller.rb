class FriendshipsController < ApplicationController

  def create
    @friendship = Friendship.new(params[:friendship])
    @friendship.out_friend_id = current_user.id
    @friendship.save

    respond_to do |format|

      format.html do
        flash[:errors] = @friendship.errors.full_messages
        redirect_to users_url
      end

      format.json do
        flash.now[:errors] = @friendship.errors.full_messages
        render :json => @friendship.in_friend
      end
    end
  end

  def destroy
    @friendship = Friendship.find_by_in_friend_id_and_out_friend_id(
      params[:out_friend_id],
      params[:in_friend_id]
    )
    if @friendship.nil?
      @friendship = Friendship.find_by_in_friend_id_and_out_friend_id(
        params[:in_friend_id],
        params[:out_friend_id]
      )
    end

    @friendship.destroy
    render json: @friendship.in_friend
  end
end

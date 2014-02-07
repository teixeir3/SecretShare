class FriendshipsController < ApplicationController

  def create
    @friendship = Friendship.new(params[:friendship]);
    @friendship.out_friend_id = current_user.id
    @friendship.save

    flash[:errors] = @friendship.errors.full_messages
    redirect_to users_url

  end

  def destroy

  end
end

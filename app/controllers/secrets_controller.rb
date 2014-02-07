class SecretsController < ApplicationController

  def new
    @secret = Secret.new(recipient_id: params[:id])
  end

  def create
    @secret = Secret.new(params[:secret])
    @secret.author_id = current_user.id
    @user = @secret.author
    @secret.save!


    if request.xhr?
      render partial: "secrets/secret.html", locals: {secret: @secret}
    else
      render :new
    end
  end
end

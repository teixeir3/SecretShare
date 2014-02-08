class TagsController < ApplicationController

  def index
    @tags = Tag.all

    respond_to do |format|
      format.html {render :index}

      format.json { render :json => @tags}
  end

  def new

  end

  def create
    @tag = Tag.new(params[:secret])
    @user = @secret.author
    @secret.save!


    if request.xhr?
      render partial: "secrets/secret.html", locals: {secret: @secret}
    else
      render :new
    end
  end

end

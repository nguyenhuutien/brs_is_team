class FeedBacksController < ApplicationController
  def new
    @feed_back = FeedBack.new
  end

  def create
    @feed_back = FeedBack.new feed_back_params
    if @feed_back.save
      flash[:success] = t("feed_back.create_success")
      redirect_to root_url
    else
      render :new
    end
  end

  private
  def feed_back_params
    params.require(:feed_back).permit :name, :email, :phone, :message
  end
end
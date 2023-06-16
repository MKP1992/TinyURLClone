class UrlsController < ApplicationController
  def index
    @url = Url.new
    @urls = Url.all
  end

  def create
    @url = Url.new(url_params)
    if @url.save
      redirect_to url_info_path(@url.slug)
    else
      flash[:notice] = @url.errors.messages
      render :index
    end
  end

  def info
    @url = Url.find_by(slug: params[:slug])
    if @url
      @visits = @url.visits
    else
      redirect_to root_path, notice: 'Invalid URL'
    end
  end

  private

  def url_params
    params.require(:url).permit(:original_url)
  end
end

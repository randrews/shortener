class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy]

  def show
    if @link
      redirect_to @link.url
    else
      redirect_to '/'
    end
  end

  def new
    @link = Link.new
  end

  def create
    # Try to find a link for that url, or create it:
    @link = Link.for_url(params[:link][:url]).first || Link.new(link_params)

    respond_to do |format|
      if @link.save
        format.html { render :display_link }
      else
        format.html { render :new }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.for_key(params[:key]).first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params[:link].permit(:url)
    end
end

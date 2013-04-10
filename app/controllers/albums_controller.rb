class AlbumsController < ApplicationController
  before_filter :find_album

  def index
    @albums = Album.all
  end

  def show
    @album = Album.find(params[:id])
  end

  def create
    @album = Album.new(params[:album])

    respond_to do |format|
      if @album.save
        format.html { redirect_to root_path, :notice => 'Album created' }
      else
        format.html { render action: :new, :error => @album.errors.full_messages.to_sentence }
      end
    end
  end

  def update
    respond_to do |format|
      if @album.update_attributes(params[:photos])
        format.html { redirect_to album_path(@album), :notice => 'Photos added to album' }
      else
        format.html { render action: :new, :error => @photo.errors.full_messages.to_sentence }
      end
    end
  end

  private

  def find_album
    @album = Album.find(params[:id])
  end
end

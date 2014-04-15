require 'sinatra/base'
require 'pickled_shark'

class Artsy < Sinatra::Base
  use Rack::Static, :urls => ["/css"], :root => "public"

  get "/galleries" do
    @galleries = PickledShark::Gallery.all
    erb :galleries
  end

  get "/galleries/:id" do
    @gallery = PickledShark::Gallery.get_gallery(params[:id])
    erb :gallery
  end

  get "/galleries/:id/exhibitions" do
    @exhibition = PickledShark::Exhibition.get_exhibitions_for_gallery(params[:id])
    erb :gallery_exhibition
  end

  get "/exhibitions" do
    @exhibitions = PickledShark::Exhibition.all
    erb :exhibitions
  end

  get "/exhibitions/:id", layout: "layout.erb" do
    @exhibition = PickledShark::Exhibition.get_exhibitions_for_gallery(params[:id])
    erb :exhibition
  end

  post "/tickets/" do

  end

  delete "/tickets/:id" do
    @request = PickledShark::Ticket.delete(params[:id])
    erb :ticket_delete
  end
end
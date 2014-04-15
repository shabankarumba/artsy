require 'sinatra/base'
require 'pickled_shark'

class Artsy < Sinatra::Base
  use Rack::Static, :urls => ["/css"], :root => "public"

  get "/galleries", layout: "layout.erb" do
    @galleries = PickledShark::Gallery.all
    erb :galleries
  end

  get "/galleries/:id", layout: "layout.erb" do
    @gallery = PickledShark::Gallery.get_gallery(params[:id])
    erb :gallery
  end

  get "/galleries/:id/exhibitions", layout: "layout.erb" do
    @exhibition = PickledShark::Exhibition.get_exhibitions_for_gallery(params[:id])
    erb :gallery_exhibition
  end

  get "/exhibitions", layout: "layout.erb" do
    @exhibitions = PickledShark::Exhibition.all
    erb :exhibitions
  end

  get "/exhibitions/:id", layout: "layout.erb" do
    @exhibition = PickledShark::Exhibition.get_exhibitions_for_gallery(params[:id])
    erb :exhibition
  end

  post "/tickets/",layout: "layout.erb" do

  end

  delete "/tickets/:id", layout: "layout.erb" do
    @request = PickledShark::Ticket.delete(params[:id])
    erb :ticket_delete
  end
end
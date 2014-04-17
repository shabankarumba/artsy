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
    erb :exhibition
  end

  get "/exhibitions" do
    @exhibitions = PickledShark::Exhibition.all
    erb :exhibitions
  end

  get "/exhibitions/:id" do
    @exhibition = PickledShark::Exhibition.get_exhibitions_for_gallery(params[:id])
    erb :exhibition
  end

  get "/tickets" do
    erb :ticket_create
  end

  post "/tickets/new",layout: "layout.erb" do
    ticket =  { name: params["name"], exhibition_id: params["id"], entry_at: params["entry_at"] }
    @response = PickledShark::Ticket.create(ticket)
    if @response.nil?
      redirect '/ticket_success'
    else
      redirect "/tickets"
    end
  end

  get "/tickets/success" do
    erb :ticket_success
  end

  post "/tickets/:id" do
    @request = PickledShark::Ticket.delete(params[:id])
    erb :ticket_delete
  end
end
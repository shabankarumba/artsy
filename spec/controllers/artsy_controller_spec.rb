require 'spec_helper'

describe Artsy do
  let(:gallery) { {"id" => 1,"name" => "Hayward Gallery","description" => "Hayward Gallery"}}
  let(:exhibition) {  {"id" => 1,"name" => "Futurism Then And Now", "entry_fee" => "£15.00"} }
  let(:exhibitions) do
     [{"name" => "Futurism Then And Now","gallery_name" => "Hayward Gallery",
    "url" => "/exhibitions/1","gallery_url" => "/galleries/1"}]
  end
  let(:ticket) { { ticket: {name: "Helene Martin", id: 2, entry_at: '23/5/2014 10:00'}} }
  let(:response) { double("Deleted ticket")}

  it "views galleries page" do
    get "/galleries"
    last_response.should be_ok
  end

  it "views individual gallery page" do
    PickledShark::Gallery.should_receive(:get_gallery).with("1").and_return(gallery)
    get "galleries/1"
    last_response.should be_ok
  end

  it "views the gallery exhibition" do
    PickledShark::Exhibition.should_receive(:get_exhibitions_for_gallery).with("1").and_return(exhibition)
    get "galleries/1/exhibitions"
    last_response.should be_ok
  end

  it "views all the exhibitions" do
    PickledShark::Exhibition.should_receive(:all).and_return(exhibitions)
    get "/exhibitions"
    last_response.should be_ok
  end

  it "can create at ticket" do
    PickledShark::Ticket.should_receive(:create_a_ticket).with(ticket).and_return("Created a ticket")
    post "/tickets", ticket
    last_response.should be_ok
  end

  it "can delete a ticket" do
    PickledShark::Ticket.should_receive(:delete).with("1").and_return(response)
    delete "/tickets/1"
    last_response.should be_ok
    last_response.body eq response
  end
end
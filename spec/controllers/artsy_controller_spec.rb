require 'spec_helper'

describe Artsy do
  let(:gallery) { {"id" => 1,"name" => "Hayward Gallery","description" => "Hayward Gallery"}}
  let(:exhibition) {  {"id" => 1,"name" => "Futurism Then And Now", "entry_fee" => "£15.00"} }
  let(:exhibitions) do
     {"exhibitions" => [{"name" => "Futurism Then And Now","gallery_name" => "Hayward Gallery",
    "url" => "/exhibitions/1","gallery_url" => "/galleries/1"}]}
  end

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
end
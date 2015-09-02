module TrafficSpy

  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    get "/sources" do
      erb :sources
    end

    post "/sources" do
      TrafficSpy.create(params[:identifier], params[:rootUrl])
      redirect "/sources"
    end

    not_found do
      erb :error
    end
  end

end

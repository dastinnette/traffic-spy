

module TrafficSpy

  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    get "/sources" do
      erb :sources
    end

    post "/sources" do
      client = Client.new(indentifier: params[:indentifier], root_url: params[:rootUrl])
      if client.save
        body "success"
      else
        body client.errors.full_messages.first
        status 400
      end
      body "success" if redirect "/sources"
    end

    not_found do
      erb :error
    end
  end

end

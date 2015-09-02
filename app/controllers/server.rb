module TrafficSpy

  class Server < Sinatra::Base

    get '/' do
      erb :index
    end

    get "/sources" do
      erb :sources
    end

    post "/sources" do
      @client = Client.new(params)
      if @client.save
        body json_converter
      else
        body @client.errors.full_messages.first
        status 400
      end
    end

    not_found do
      erb :error
    end

    def json_converter
      @client.attributes.select do |k|
        k == "identifier"
      end.to_json
    end
  end

end

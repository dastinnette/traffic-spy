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
      if Client.find_by(identifier: params[:identifier])
        status 403
        body @client.errors.full_messages.first
      elsif @client.save
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
      client_identifier_hash.to_json
    end

    def client_identifier_hash
      @client.attributes.select do |k|
        k == "identifier"
      end
    end
  end

end

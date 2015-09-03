module TrafficSpy

  class Server < Sinatra::Base

    get '/' do
      erb :index
    end

    get "/sources" do
      @sources = Source.all
      erb :sources
    end

    get "/sources/:identifier" do
      @identifier = Source.find_by(identifier: params[:identifier])
      if @identifier
        erb :identifier
      else
        erb :error
      end
    end

    post "/sources" do
      @source = Source.new(identifier: params[:identifier], root_url: params[:rootUrl])
      if Source.find_by(identifier: params[:identifier])
        status 403
        body @source.errors.full_messages.first
      elsif @source.save
        body json_converter
      else
        body @source.errors.full_messages.first
        status 400
      end
    end

    post "/sources/:identifier/data" do
      payload_data = JSON.parse(params["payload"])
      Payload.create(url: payload_data["url"])
    end

    not_found do
      erb :error
    end

    def json_converter
      source_identifier_hash.to_json
    end

    def source_identifier_hash
      @source.attributes.select do |k|
        k == "identifier"
      end
    end
  end

end

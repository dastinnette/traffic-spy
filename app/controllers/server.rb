require_relative 'helper_methods'

module TrafficSpy

  class Server < Sinatra::Base
    include HelperMethods

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
      @source = Source.new(identifier: params[:identifier],
                           root_url: params[:rootUrl])
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

    # get "/sources/:identifier/urls/*" do |identifier|
    #   url = params[:splat]

    post "/sources/:identifier/data" do |identifier|
      if params["payload"] == "{}" || params["payload"] == nil
        body "Invalid payload data"
        status 400
      elsif Payload.find_by(hashed: Digest::SHA1.hexdigest(params["payload"]))
        status 403
      elsif Source.find_by(identifier: identifier) == nil
        status 403
      else
        payload_hash = Digest::SHA1.hexdigest(params["payload"])
        payload_data = JSON.parse(params["payload"])
        resolution = Resolution.find_or_create_by(width: payload_data["resolutionWidth"],
                                                  height: payload_data["resolutionHeight"])
        payload = Payload.create(url: payload_data["url"],
                                 hashed: payload_hash,
                                 user_agent_string: payload_data["userAgent"],
                                 responded_in: payload_data["respondedIn"])
        user_source = Source.find_by(identifier: identifier)
        user_source.payloads << payload
        resolution.payloads << payload
        body "Awesome"
      end
    end

    get "/sources/:identifier/urls/:relative/:path" do
      erb :url_stats
    end

    not_found do
      erb :error
    end

  end

end

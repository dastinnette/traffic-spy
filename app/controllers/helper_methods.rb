module HelperMethods

  def json_converter
    source_identifier_hash.to_json
  end

  def source_identifier_hash
    @source.attributes.select do |k|
      k == "identifier"
    end
  end

  def resolution_dimensions
    Resolution.all.map do |resolution|
      "#{resolution.height} x #{resolution.width}"
    end.uniq.join
  end

  def operating_system_report
    @identifier.payloads.map do |payload|
      platform_output(payload.user_agent_string)
    end.uniq.join
  end

  def web_browser_report
    @identifier.payloads.map do |payload|
      browser_output(payload.user_agent_string)
    end.uniq.join
  end

  def sort_url_requests
    url_list = []
    @identifier.payloads.map do |payload|
      url_list << payload.url
      url_list
    end
    count_of_urls = url_list.inject(Hash.new(0)) {|total, e| total[e] += 1 ;total}.sort_by {|key, value| -value}
  end

end

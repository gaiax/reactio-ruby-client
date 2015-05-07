require 'uri'
require 'faraday'

module Reactio
  class Client
    USER_AGENT = "Reactio ruby v#{VERSION}".freeze

    attr_reader :api_key, :organization

    def initialize(options)
      set_api_key(options[:api_key])
      set_organization(options[:organization])
      @http = Faraday.new(url: base_url.to_s)
    end

    def describe_incident(incident_id)
      res = @http.get("/api/v1/incidents/#{incident_id}") do |req|
        req.headers['Accept'] = 'application/json'
        req.headers['Content-Type'] = 'application/json'
        req.headers['X-Api-Key'] = api_key
        req.headers['User-Agent'] = USER_AGENT
      end
    end

    private

      def set_api_key(an_api_key)
        raise ArgumentError unless an_api_key
        @api_key = an_api_key.to_s
      end

      def set_organization(an_organization)
        raise ArgumentError unless an_organization
        @organization = an_organization.to_s
      end

      def base_url
        @base_url ||= URI::HTTPS.build(host: "#{organization}.#{Reactio::DOMAIN}")
      end
  end
end

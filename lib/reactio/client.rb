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

    def list_incidents(options = {})
      body = {}
      body[:from] = options[:from].to_i if options[:from]
      body[:to] = options[:to].to_i if options[:to]
      body[:status] = options[:status].to_s if options[:status]
      body[:page] = options[:page] if options[:page]
      body[:per_page] = options[:per_page] if options[:per_page]

      res = @http.get("/api/v1/incidents") do |req|
        req.headers['Accept'] = 'application/json'
        req.headers['Content-Type'] = 'application/json'
        req.headers['X-Api-Key'] = api_key
        req.headers['User-Agent'] = USER_AGENT
        req.body = body.to_json
      end
    end

    def notify_incident(incident_id, options = {})
      body = { incident_id: incident_id }
      body[:text] = options[:text] if options[:text]
      body[:call] = options[:call] unless options[:call].nil?

      res = @http.post("/api/v1/notifications") do |req|
        req.headers['Accept'] = 'application/json'
        req.headers['Content-Type'] = 'application/json'
        req.headers['X-Api-Key'] = api_key
        req.headers['User-Agent'] = USER_AGENT
        req.body = body.to_json
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

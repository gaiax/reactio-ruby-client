require 'uri'
require 'faraday'

module Reactio
  class Client
    include Utils

    USER_AGENT = "Reactio ruby v#{VERSION}".freeze

    attr_reader :api_key, :organization

    def initialize(options)
      set_api_key(options[:api_key])
      set_organization(options[:organization])
      @http = Faraday.new(url: base_url.to_s)
    end

    def create_incident(name, options = {})
      body = { name: name }
      body[:status] = options[:status] if options[:status]
      body[:detection] = to_option_string(options[:detection]) if options.key?(:detection)
      body[:cause] = to_option_string(options[:cause]) if options.key?(:cause)
      body[:cause_supplement] = options[:cause_supplement] if options[:cause_supplement]
      body[:point] = to_option_string(options[:point]) if options.key?(:point)
      body[:scale] = to_option_string(options[:scale]) if options.key?(:scale)
      body[:pend_text] = options[:pend_text] if options[:pend_text]
      body[:close_text] = options[:close_text] if options[:close_text]
      body[:topics] = options[:topics] if options[:topics]
      body[:notification_text] = options[:notification_text] if options[:notification_text]
      body[:notification_call] = options[:notification_call] if options.key?(:notification_call)

      res = @http.post("/api/v1/incidents") do |req|
        req.headers['Accept'] = 'application/json'
        req.headers['Content-Type'] = 'application/json'
        req.headers['X-Api-Key'] = api_key
        req.headers['User-Agent'] = USER_AGENT
        req.body = body.to_json
      end
    end

    def describe_incident(incident_id)
      res = @http.get("/api/v1/incidents/#{incident_id}") do |req|
        req.headers['Accept'] = 'application/json'
        req.headers['Content-Type'] = 'application/json'
        req.headers['X-Api-Key'] = api_key
        req.headers['User-Agent'] = USER_AGENT
      end
      JSON.parse(res.body)
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

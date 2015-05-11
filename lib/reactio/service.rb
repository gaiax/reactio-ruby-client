require 'reactio/api_endpoint'
require 'reactio/api_client'

module Reactio
  class Service
    include Utils

    attr_reader :api_key, :organization

    def initialize(options)
      set_api_key(options[:api_key])
      set_organization(options[:organization])
      @api = APIClient.new(api_key, APIEndpoint.new(organization))
    end

    def create_incident(name, options = {})
      payload = { name: name }.tap do |me|
        me[:detection] = to_option_string(options.delete(:detection)) if options.key?(:detection)
        me[:cause] = to_option_string(options.delete(:cause)) if options.key?(:cause)
        me[:point] = to_option_string(options.delete(:point)) if options.key?(:point)
        me[:scale] = to_option_string(options.delete(:scale)) if options.key?(:scale)
      end
        .merge!(options)
      @api.request(:post, "/api/v1/incidents", body: payload)
    end

    def describe_incident(incident_id)
      @api.request(:get, "/api/v1/incidents/#{incident_id}")
    end

    def list_incidents(options = {})
      payload = {}.tap do |me|
        me[:from] = options.delete(:from).to_i if options[:from]
        me[:to] = options.delete(:to).to_i if options[:to]
        me[:status] = options.delete(:status).to_s if options[:status]
      end
        .merge!(options)
      @api.request(:get, "/api/v1/incidents", body: payload)
    end

    def notify_incident(incident_id, options = {})
      @api.request(
        :post, "/api/v1/notifications",
        body: { incident_id: incident_id }.merge(options)
      )
    end

    private

      def set_api_key(an_api_key = nil)
        raise ArgumentError, 'api_key is required' unless an_api_key
        @api_key = an_api_key.to_s
      end

      def set_organization(an_organization = nil)
        raise ArgumentError, 'organization is required' unless an_organization
        @organization = an_organization.to_s
      end
  end
end

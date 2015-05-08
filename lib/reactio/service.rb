require 'uri'
require 'reactio/api_client'

module Reactio
  class Service
    include Utils

    def initialize(options)
      @api = APIClient.new(
        options[:api_key],
        options[:organization]
      )
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

      @api.request(:post, "/api/v1/incidents", body: body)
    end

    def describe_incident(incident_id)
      @api.request(:get, "/api/v1/incidents/#{incident_id}")
    end

    def list_incidents(options = {})
      body = {}
      body[:from] = options[:from].to_i if options[:from]
      body[:to] = options[:to].to_i if options[:to]
      body[:status] = options[:status].to_s if options[:status]
      body[:page] = options[:page] if options[:page]
      body[:per_page] = options[:per_page] if options[:per_page]

      @api.request(:get, "/api/v1/incidents", body: body)
    end

    def notify_incident(incident_id, options = {})
      body = { incident_id: incident_id }
      body[:text] = options[:text] if options[:text]
      body[:call] = options[:call] unless options[:call].nil?

      @api.request(:post, "/api/v1/notifications", body: body)
    end
  end
end

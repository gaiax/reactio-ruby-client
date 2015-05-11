require 'faraday'
require 'reactio/api_endpoint'
require 'reactio/faraday_engine'

module Reactio
  class APIClient

    def self.build(api_key, organization)
      raise ArgumentError, 'api_key is required' unless api_key
      raise ArgumentError, 'organization is required' unless organization
      new(api_key, APIEndpoint.new(organization))
    end

    def initialize(api_key, api_endpoint)
      @http = build_http_client(api_key, api_endpoint)
    end

    def request(method, path, env = {})
      @http
        .send(method, path) {|r| r.body = env[:body] if env.key?(:body) }
        .body
    end

    private

      def build_http_client(api_key, api_endpoint)
        Faraday.new(url: api_endpoint.base_url) do |faraday|
          faraday.use :reactio, api_key
          faraday.request :url_encoded
          faraday.adapter Faraday.default_adapter
        end
      end
  end
end

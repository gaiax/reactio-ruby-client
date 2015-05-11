require 'faraday'
require 'reactio/api_server'
require 'reactio/faraday_engine'

module Reactio
  class APIClient
    attr_reader :api_key, :api_server

    def initialize(an_api_key, an_organization)
      set_api_key(an_api_key)
      set_api_server(an_organization)
      @http = build_http_client
    end

    def request(method, path, env = {})
      @http
        .send(method, path) {|r| r.body = env[:body] if env.key?(:body) }
        .body
    end

    private

      def set_api_key(an_api_key = nil)
        raise ArgumentError, 'api_key is required' unless an_api_key
        @api_key = an_api_key.to_s
      end

      def set_api_server(an_organization)
        raise ArgumentError, 'organization is required' unless an_organization
        @api_server = APIServer.new(an_organization)
      end

      def build_http_client
        Faraday.new(url: api_server.base_url) do |faraday|
          faraday.use :reactio, api_key
          faraday.request :url_encoded
          faraday.adapter Faraday.default_adapter
        end
      end
  end
end

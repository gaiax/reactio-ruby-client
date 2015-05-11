require 'faraday'
require 'reactio/api_endpoint'
require 'reactio/faraday_engine'

module Reactio
  class APIClient

    class << self

      def build(api_key, organization)
        raise ArgumentError, 'api_key is required' unless api_key
        raise ArgumentError, 'organization is required' unless organization
        http_client = build_http_client(
          api_key,
          APIEndpoint.new(organization)
        )
        new(http_client)
      end

      def build_http_client(api_key, api_endpoint)
        Faraday.new(url: api_endpoint.base_url) do |faraday|
          faraday.use :reactio, api_key
          faraday.request :url_encoded
          faraday.adapter Faraday.default_adapter
        end
      end
    end

    def initialize(http_client)
      @http = http_client
    end

    def request(method, path, env = {})
      response = @http.send(method, path, env[:body])
      handle_api_response(response)
    end

    private

      def handle_api_response(res)
        case res.status
        when 200..299
          res.body
        when 401
          raise Reactio::AuthenticationError, res.body.inspect
        when 400..499
          raise Reactio::BadRequest, res.body.inspect
        when 500..599
          raise Reactio::ServerError, res.body.inspect
        end
      end
  end
end

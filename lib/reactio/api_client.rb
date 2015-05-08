require 'faraday'
require 'reactio/faraday_engine'

module Reactio
  class APIClient
    attr_reader :api_key, :organization

    def initialize(an_api_key, an_organization)
      set_api_key(an_api_key)
      set_organization(an_organization)
      @http = build_http_client
    end

    def request(method, path, env = {})
      @http
        .send(method, path) {|r| r.body = env[:body] if env.key?(:body) }
        .body
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

      def build_http_client
        base_url = URI::HTTPS.build(host: "#{organization}.#{Reactio::DOMAIN}")
        Faraday.new(url: base_url.to_s) do |faraday|
          faraday.use :reactio, api_key
          faraday.request :url_encoded
          faraday.adapter Faraday.default_adapter
        end
      end
  end
end

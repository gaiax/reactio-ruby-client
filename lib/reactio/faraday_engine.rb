require 'faraday'
require 'json'

module Reactio
  class FaradayEngine < Faraday::Middleware
    USER_AGENT = "Reactio ruby v#{VERSION}".freeze
    MIME_TYPE = 'application/json'.freeze

    def initialize(app, api_key)
      super(app)
      @api_key = api_key
    end

    def call(request_env)
      set_request_header(request_env)
      encode_body(request_env)
      @app.call(request_env).on_complete do |response_env|
        decode_body(response_env)
      end
    end

    private

      def set_request_header(env)
        env[:request_headers].merge!(
          'Accept'        => MIME_TYPE,
          'Content-Type'  => MIME_TYPE,
          'X-Api-Key'     => @api_key,
          'User-Agent'    => USER_AGENT
        )
      end

      def encode_body(env)
        env[:body] = JSON.dump(env[:body])
      end

      def decode_body(env)
        env[:body] = JSON.parse(env[:body], symbolize_names: true)
      end
  end
end

Faraday::Middleware.register_middleware reactio: Reactio::FaradayEngine

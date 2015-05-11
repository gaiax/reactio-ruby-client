require 'uri'

module Reactio
  class APIServer
    DOMAIN = 'reactio.jp'.freeze

    attr_reader :organization

    def initialize(organization)
      @organization = organization
      @base_url = URI::HTTPS.build(host: "#{organization}.#{DOMAIN}")
    end

    def base_url
      @base_url.to_s
    end

    def ==(other)
      other.instance_of?(self.class) &&
        self.organization == other.organization
    end
  end
end

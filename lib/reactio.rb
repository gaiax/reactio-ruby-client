require 'reactio/version'
require 'reactio/utils'
require 'reactio/service'

module Reactio

  def self.included(base)
    base.class_eval do
      include InstanceMethods
    end
  end

  module InstanceMethods

    def reactio
      @reactio ||= create_service
    end

    private

      def create_service
        Service.new(
          api_key: ENV['REACTIO_API_KEY'],
          organization: ENV['REACTIO_ORGANIZATION']
        )
      end
  end
end

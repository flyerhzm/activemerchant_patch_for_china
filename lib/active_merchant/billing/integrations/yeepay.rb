require File.dirname(__FILE__) + '/yeepay/helper.rb'
require File.dirname(__FILE__) + '/yeepay/notification.rb'
require File.dirname(__FILE__) + '/yeepay/return.rb'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Yeepay

        mattr_accessor :test_url
        self.test_url = 'http://tech.yeepay.com:8080/robot/debug.action'

        mattr_accessor :production_url
        self.production_url = 'https://www.yeepay.com/app-merchant-proxy/node'
        
        def self.service_url
          mode = ActiveMerchant::Billing::Base.integration_mode
          case mode
          when :production
            self.production_url
          when :test
            self.test_url
          else
            raise StandardError, "Integration mode set to an invalid value: #{mode}"
          end
        end
      end
    end
  end
end

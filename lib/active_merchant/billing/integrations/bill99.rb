require File.dirname(__FILE__) + '/bill99/helper.rb'
require File.dirname(__FILE__) + '/bill99/return.rb'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Bill99

        mattr_accessor :service_url
        self.service_url = 'https://www.99bill.com/gateway/receiveMerchantInfoAction.do'

        def self.notification(post)
          Notification.new(post)
        end

        def self.return(query_string)
          Return.new(query_string)
        end
      end
    end
  end
end

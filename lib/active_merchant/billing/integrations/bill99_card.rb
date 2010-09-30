require File.dirname(__FILE__) + '/bill99_card/helper.rb'
require File.dirname(__FILE__) + '/bill99_card/return.rb'
require File.dirname(__FILE__) + '/bill99_card/notification.rb'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Bill99Card

        mattr_accessor :service_url
        self.service_url = 'https://www.99bill.com/szxgateway/recvMerchantInfoAction.htm'

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

require File.dirname(__FILE__) + '/pay19/helper.rb'
require File.dirname(__FILE__) + '/pay19/return.rb'
require File.dirname(__FILE__) + '/pay19/notification.rb'
module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Pay19
        mattr_accessor :service_url
        self.service_url = 'https://pay.19pay.com/page/bussOrder.do'

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

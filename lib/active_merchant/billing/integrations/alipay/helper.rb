require 'cgi'
require 'digest/md5'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Alipay
        class Helper < ActiveMerchant::Billing::Integrations::Helper
          mapping :account, 'partner'
          mapping :amount, 'total_fee'

          mapping :order, 'out_trade_no'

          mapping :seller, :email => 'seller_email'

          mapping :notify_url, 'notify_url'
          mapping :return_url, 'return_url'
          mapping :show_url, 'show_url'
          mapping :description, 'body'

          mapping :charset, '_input_charset'
          mapping :service, 'service'
          mapping :payment_type, 'payment_type'
          mapping :subject, 'subject'

          def initialize(order, account, options = {})
            super
          end

          def sign
            add_field('sign',
                      Digest::MD5.hexdigest((@fields.sort.collect{|s|s[0]+"="+CGI.unescape(s[1])}).join("&")+KEY)
                     )
            add_field('sign_type', 'MD5')
          end

        end
      end
    end
  end
end

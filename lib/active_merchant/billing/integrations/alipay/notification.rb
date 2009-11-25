require 'net/http'
require 'active_merchant/billing/integrations/alipay/sign'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Alipay
        class Notification < ActiveMerchant::Billing::Integrations::Notification
          include Sign

          def complete?
            if trade_status != "TRADE_FINISHED"
              return false
            end

            unless verify_sign
              @message = "Alipay Error: ILLEGAL_SIGN"
              return false
            end

            true
          end

          def message
            @message
          end
          
          def notify_type
            params['notify_type']
          end

          def notify_id
            params['notify_id']
          end
          
          def notify_time
            Time.parse params['notify_time']
          end

          def out_trade_no
            params['out_trade_no']
          end

          def trade_no
            params['trade_no']
          end
          
          def payment_type
            params['payment_type']
          end
          
          def subject
            params['subject']
          end
          
          def body
            params['body']
          end

          def price
            params['price']
          end
          
          def quantity
            params['quantity']
          end

          def total_fee
            params["total_fee"]
          end

          def trade_status
            params['trade_status']
          end
          
          def refund_status
            params['refund_status']
          end
          
          def seller_email
            params['seller_email']
          end
          
          def seller_id
            params['seller_id']
          end

          def buyer_email
            params['buyer_email']
          end

          def buyer_id
            params['buyer_id']
          end
          
          def gmt_create
            Time.parse params['gmt_create']
          end
          
          def gmt_payment
            Time.parse params['gmt_payment']
          end
          
          def gmt_close
            Time.parse params['gmt_close']
          end
          
          def gmt_refund
            Time.parse params['gmt_reund']
          end
          
          private

          # Take the posted data and move the relevant data into a hash
          def parse(post)
            @raw = post
            for line in post.split('&')
              key, value = *line.scan( %r{^(\w+)\=(.*)$} ).flatten
              params[key] = value
            end
          end
        end
      end
    end
  end
end

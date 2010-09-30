require 'net/http'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Bill99Card
        class Notification < ActiveMerchant::Billing::Integrations::Notification
          def complete?
            "10" == params["payResult"]
          end

          def received_at
            Time.parse params['dealTime']
          end

          def status

          end

          def transaction_id
            params['dealId']
          end

          def type
          end

          def gross
            params['payAmount']
          end

          def fee
            params['fee']
          end

          def currency
          end

          def item_id
            params['orderId']
          end

          def invoice

          end

          def test?

          end

          def account
            params['merchantAccId']
          end

          def acknowledge
            verify_payment == params['signMsg']
          end

          def acknowledge_response
            "<result>1</result><redirecturl>#{REDIRECT_URL}</redirecturl>"
          end

          private
          def verify_payment
            Digest::MD5.hexdigest(%w(merchantAcctId version language payType cardNumber cardPwd orderId orderAmount dealId orderTime ext1 ext2 payAmount billOrderTime payResult signType bossType receiveBossType receiverAcctId).collect{
                |name| "#{name}=#{params[name]}" unless params[name].blank?
              }.select{|s| !s.blank? }.join('&') + "&key=#{KEY[params['bossType']]}").upcase
          end
        end
      end
    end
  end
end

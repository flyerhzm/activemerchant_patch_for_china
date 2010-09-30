require 'digest/md5'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Bill99Card
        class Return < ActiveMerchant::Billing::Integrations::Return

          def account
            params["merchantAcctId"]
          end

          def order
            params["orderid"]
          end

          def amount
            params['payAmount']
          end

          def sign
            params['signMsg']
          end

          def success?
            unless params['payResult'] == "10"
              @message = "Bill99 Error: FALSE_RETURN"
              return false
            end
#            unless verify_sign == sign.upcase
#              @message = "Bill99 Error: ILLEGAL_SIGN"
#              return false
#            end

            return true
          end

          def message
            @message
          end

          private
          def verify_sign
            Digest::MD5.hexdigest(%w(merchantAcctId version language payType cardNumber cardPwd orderId orderAmount dealId orderTime ext1 ext2 payAmount billOrderTime payResult signType bossType receiveBossType receiverAcctId).collect{
              |name| "#{name}=#{params[name]}" unless params[name].blank?
              }.select{|s| !s.blank? }.join('&') + "&key=#{KEY[params['bossType']]}").upcase
          end
        end
      end
    end
  end
end

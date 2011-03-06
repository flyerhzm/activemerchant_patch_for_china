require 'digest/md5'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Bill99
        class Return < ActiveMerchant::Billing::Integrations::Return

          def account
            @params["merchant_id"]
          end

          def order
            @params["orderid"]
          end

          def amount
            @params['amount']
          end

          def sign
            @params['mac']
          end

          def success?
            unless @params['succeed'] == "Y"
              @message = "Bill99 Error: FALSE_RETURN"
              return false
            end
            unless account == ACCOUNT
              @message = "Bill99 Error: INCORRECT_ACCOUNT"
              return false
            end

            hash_keys = %w(merchant_id orderid amount date succeed)

            md5_string = hash_keys.inject([]){|array, key| array << "#{key}=#{@params[key]}"}.join("&")

            unless Digest::MD5.hexdigest(md5_string+"&merchant_key=#{KEY}") == sign.downcase
              @message = "Bill99 Error: ILLEGAL_SIGN"
              return false
            end

            return true
          end

          def message
            @message
          end

        end
      end
    end
  end
end

require 'digest/md5'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Pay19
        class Return < ActiveMerchant::Billing::Integrations::Return

          def account
            @params["merchant_id"]
          end

          def order
            @params["order_id"]
          end

          def amount
            @params['amount']
          end

          def sign
            @params['verifystring']
          end

          def item_id
            @params['order_id']
          end

          def gross
            @params['amount']
          end
          
          def success?

            if @params['result'] == "N"
              @message = "19Pay Error: PAYMENT_FAILED"
              return false
            end

            unless @params['result'] == "Y"
              @message = "19Pay message: transaction is processing.. code:#{@params['result']}"
              return false
            end

            hash_keys = %w(version_id merchant_id order_date order_id amount
              currency pay_sq pay_date pc_id result)

            md5_string = hash_keys.inject([]){|array, key| array << "#{key}=#{@params[key]}"}.join("&")
            unless Digest::MD5.hexdigest(md5_string+"&merchant_key=#{KEY}") == sign.downcase
              @message = "19Pay Error: ILLEGAL_SIGN"
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

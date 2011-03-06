require 'digest/md5'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Tenpay
        class Return < ActiveMerchant::Billing::Integrations::Return

          def account
            @params["bargainor_id"]
          end

          def order
            @params["sp_billno"]
          end

          def amount
            @params["total_fee"]
          end

          def success?
            return false unless @params["pay_info"] == "OK" && @params["pay_result"] == "0"
            unless account == ACCOUNT
              @message = "Tenpay Error: INCORRECT_ACCOUNT"
              return false
            end

            hash_keys = %w(cmdno pay_result date transaction_id sp_billno total_fee fee_type attach)

            md5_string = hash_keys.inject([]){|array, key| array << "#{key}=#{@params[key]}"}.join("&")

            unless Digest::MD5.hexdigest(md5_string+"&key=#{KEY}") == @params["sign"].downcase
              @message = "Tenpay Error: ILLEGAL_SIGN"
              return false
            end

            return true
          end

          def message
            @message || @params['pay_info']
          end

        end
      end
    end
  end
end

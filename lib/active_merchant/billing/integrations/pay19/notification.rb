require 'net/http'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Pay19
        class Notification < ActiveMerchant::Billing::Integrations::Notification
          def complete?
            "Y" == params["result"]
          end

          def received_at
            Time.parse params['pay_date']
          end

          def status

          end

          def transaction_id
            params['pay_sq']
          end

          def type
            params['pm_id']
          end

          def gross
            params['amount']
          end

          def fee
          end

          def currency
            params['currency']
          end

          def item_id
            params['order_id']
          end

          def invoice

          end

          def test?

          end

          def account
            params['merchant_id']
          end

          def acknowledge
            verify_payment == params['verifystring']
          end

          def acknowledge_response
            "Y"
          end

          private
          def verify_payment
            Digest::MD5.hexdigest(%w(version_id merchant_id order_id result
              order_date amount currency pay_sq pay_date pc_id).collect{
                |name| "#{name}=#{params[name]}"
              }.join('&') + "&merchant_key=#{KEY}")
          end
        end
      end
    end
  end
end

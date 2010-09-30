module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Yeepay
        class Notification < ActiveMerchant::Billing::Integrations::Notification
          def complete?
            "1" == params["r1_Code"]
          end

          def received_at
            Time.parse params['ru_Trxtime']
          end

          def status
            
          end

          def transaction_id
            params['r2_TrxId']
          end

          def type
            params['r0_Cmd']
          end

          def gross
            params['r3_Amt']
          end

          def fee

          end

          def currency
            params['r4_Cur']
          end

          def item_id
            params['r6_Order']
          end

          def invoice
            
          end   

          def test?

          end
          
          def account
            params['p1_MerId']
          end

          def acknowledge
            hmac_md5_hexdigest == params['hmac']
          end

          def acknowledge_response
            "success"
          end

          private
          def hmac_md5_hexdigest
            HMAC::MD5.hexdigest(KEY, %w(p1_MerId r0_Cmd r1_Code r2_TrxId r3_Amt r4_Cur r5_Pid r6_Order r7_Uid r8_MP r9_BType).collect{|name| params[name]}.join)
          end
        end
      end
    end
  end
end
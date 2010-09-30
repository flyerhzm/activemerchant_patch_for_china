module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Yeepay
        class Return < ActiveMerchant::Billing::Integrations::Return
          def success?
            hmac_md5_hexdigest == params['hmac']
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

require 'hmac-md5'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Yeepay
        class Helper < ActiveMerchant::Billing::Integrations::Helper
          mapping :account, 'p1_MerId'       
          mapping :order, 'p2_Order'
          mapping :amount, 'p3_Amt'
          mapping :currency, 'p4_Cur'
          
          mapping :description, 'p5_Pid'
          mapping :return_url, 'p8_Url'
          mapping :channel, 'pd_FrpId'

          def initialize(order, account, options = {})
            super(order, ACCOUNT, options)
            add_field('p0_Cmd', 'Buy')
          end

          def form_fields
            @fields.merge('hmac' => hmac_md5_hexdigest)
          end

          def hmac_md5_hexdigest
            HMAC::MD5.hexdigest(KEY, @fields.sort.collect{|s| s[1]}.join)
          end
        end
      end
    end
  end
end

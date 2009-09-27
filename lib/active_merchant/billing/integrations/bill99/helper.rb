require 'digest/md5'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Bill99
        class Helper < ActiveMerchant::Billing::Integrations::Helper
          mapping :account, 'merchant_id'
          mapping :amount, 'amount'
          mapping :currency, 'currency'

          mapping :order, 'orderid'

          mapping :customer, :name       => 'pname',
                             :email      => 'pemail'
          mapping :pid, 'pid'

          mapping :return_url, 'merchant_url'
          mapping :description, 'commodity_info'
          mapping :support_des, 'isSupportDES'
          mapping :attach, 'merchant_param'

          def sign
            add_field('mac',
                      Digest::MD5.hexdigest("merchant_id=#{ACCOUNT}&orderid=#{order}&amount=#{amount}&merchant_url=#{return_url}" +
                      "&merchant_key=#{KEY}").upcase
                     )
          end

        end
      end
    end
  end
end

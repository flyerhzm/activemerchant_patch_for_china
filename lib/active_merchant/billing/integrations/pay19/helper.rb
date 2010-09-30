require 'digest/md5'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Pay19
        class Helper < ActiveMerchant::Billing::Integrations::Helper
          mapping :account, 'merchant_id'
          mapping :amount, 'amount'
          mapping :currency, 'currency'
          mapping :order, 'order_id'
          mapping :return_url, 'returl'
          mapping :notify_url, 'notify_url'
          mapping :description, 'order_pname'
          mapping :channel, 'pm_id'

          def initialize(order, account, options = {})
            super(order, ACCOUNT, options)
            add_field('version_id', '2.00')
            add_field('order_date', DateTime.now.strftime("%Y%m%d"))
            add_field('pc_id', '') # Keep empty if pm_id is empty
          end

          def form_fields
            @fields.merge('verifystring' => sign)
          end

          def sign
            Digest::MD5.hexdigest(%w(version_id merchant_id order_date order_id
              amount currency returl pm_id pc_id).collect{
                |name| "#{name}=#{@fields[name]}"
              }.join('&') + "&merchant_key=#{KEY}")
          end

        end
      end
    end
  end
end

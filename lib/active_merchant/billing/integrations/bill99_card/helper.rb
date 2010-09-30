require 'digest/md5'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Bill99Card
        class Helper < ActiveMerchant::Billing::Integrations::Helper
          mapping :account, 'merchantAcctId'
          mapping :amount, 'orderAmount'
          mapping :order, 'orderId'
          mapping :return_url, 'pageUrl'
          mapping :notify_url, 'bgUrl'
          mapping :description, 'productName'
          mapping :channel, 'bossType'

          def initialize(order, account, options = {})
            options[:amount] = (options[:amount] * 100).to_i
            super(order, account, options)
            add_field('version', 'v2.0')
            add_field('language', '1')
            add_field('signType', '1')
            add_field('payType', '42')
            add_field('fullAmountFlag', '0')
            add_field('orderTime', DateTime.now.strftime("%Y%m%d%H%M%S"))
          end

          def form_fields
            @fields.merge('signMsg' => sign)
          end

          def sign
            Digest::MD5.hexdigest(%w(inputCharset bgUrl pageUrl version language signType merchantAcctId payerName payerContactType payerContact
                 orderId orderAmount payType fullAmountFlag orderTime productName productNum productId productDesc ext1 ext2 bossType).collect{
                |name| @fields[name].blank? ? "" : "#{name}=#{@fields[name]}"
              }.select{|s| !s.blank? }.join('&') + "&key=#{KEY[@fields['bossType']]}").upcase
          end

        end
      end
    end
  end
end

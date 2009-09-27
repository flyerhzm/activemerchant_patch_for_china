require 'digest/md5'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Tenpay
        class Helper < ActiveMerchant::Billing::Integrations::Helper
          # Replace with the real mapping
          mapping :account, 'bargainor_id'
          mapping :amount, 'total_fee'

          mapping :order, 'sp_billno'

          mapping :cmdno, 'cmdno'
          mapping :return_url, 'return_url'
          mapping :description, 'desc'
          mapping :attach, 'attach'
          mapping :date, 'date'
          mapping :currency, 'fee_type'
          mapping :transaction_id, 'transaction_id'

          def initialize(order, account, options = {})
            super
            add_field('bank_type', 0)
          end

          def sign
            add_field('sign',
                      Digest::MD5.hexdigest("cmdno=#{cmdno}&date=#{date}&bargainor_id=#{account}" +
                      "&transaction_id=#{transaction_id}&sp_billno=#{order}&total_fee=#{amount}" +
                      "&fee_type=#{currency}&return_url=#{return_url}&attach=#{attach}&key=#{KEY}"))
          end

        end
      end
    end
  end
end

module Spree
  module UserExtensions

    def self.prepended(base)
      base.has_many :subscriptions
      base.has_many :subscription_skip_links, class_name: 'Spree::SubscriptionSkipLink'
    end

    def subscription_orders
      orders.joins(:subscription)
    end

    def subscription_addresses
      ::Spree::SubscriptionAddress.where(user: self)
    end
  end
end

::Spree::User.prepend Spree::UserExtensions

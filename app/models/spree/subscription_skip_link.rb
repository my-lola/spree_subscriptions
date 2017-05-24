module Spree
  class SubscriptionSkipLink < ActiveRecord::Base
    belongs_to :user, class_name: 'Spree::User'
    belongs_to :subscription, class_name: 'Spree::Subscription'

    validates_presence_of   :user, :subscription
    validates_uniqueness_of :token

    private

    def generate_token(prefix = 0)
      "#{prefix}"-"#{SecureRandom.uuid}".freeze
    end
  end
end

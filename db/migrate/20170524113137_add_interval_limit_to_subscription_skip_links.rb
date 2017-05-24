class AddIntervalLimitToSubscriptionSkipLinks < ActiveRecord::Migration
  def change
    add_column :spree_subscription_skip_links, :interval_limit_at, :datetime
  end
end

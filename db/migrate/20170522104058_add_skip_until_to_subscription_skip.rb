class AddSkipUntilToSubscriptionSkip < ActiveRecord::Migration
  def change
    add_column :spree_subscription_skips, :skip_until, :date_time, default: nil
  end
end

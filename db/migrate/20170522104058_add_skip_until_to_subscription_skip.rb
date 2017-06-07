class AddSkipUntilToSubscriptionSkip < ActiveRecord::Migration
  def change
    add_column :spree_subscription_skips, :skip_until, :datetime, default: nil
  end
end

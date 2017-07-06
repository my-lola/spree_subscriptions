class CreateSubscriptionSkipLinks < ActiveRecord::Migration
  def change
    create_table :spree_subscription_skip_links do |t|
      t.references :user
      t.references :subscription

      t.string :token, default: nil
      t.boolean :used, default: false
      t.datetime :expires_at
      t.timestamp
    end

    add_index :spree_subscription_skip_links, [:user_id, :subscription_id], name: 'subscription_skip_user_idx'
  end
end

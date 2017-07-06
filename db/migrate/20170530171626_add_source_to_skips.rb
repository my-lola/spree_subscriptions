class AddSourceToSkips < ActiveRecord::Migration
  def change
    add_column :spree_subscription_skips, :source, :string, default: nil
  end
end

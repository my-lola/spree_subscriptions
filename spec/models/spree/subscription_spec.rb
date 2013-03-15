require 'spec_helper'

describe Spree::Subscription do
  let(:user) { stub_model(Spree::User, email: "spree@example.com") }
  let(:order) {
    FactoryGirl.create(:order, user: user, ship_address: FactoryGirl.create(:address))
  }
  let(:line_items) {[
    FactoryGirl.create(:line_item, interval: nil),
    FactoryGirl.create(:line_item, variant: FactoryGirl.create(:subscribable_variant), interval: 2)
  ]}


  it { should have_many(:orders) }
  it { should belong_to(:user) }


  context "#products" do
    before do
      order.line_items << line_items
    end
    it 'should return a collection of products' do
      order.finalize!
      order.subscription.products.map(&:subscribable).all?.should be_true 
    end

  end

  context "shipment dates" do

    let(:subscription) { stub('Spree::Subscription') }
    let(:interval) { 4 }

    let(:line_items) {[
      FactoryGirl.create(:line_item, interval: nil),
      FactoryGirl.create(:line_item, interval: interval)
    ]}

    before do
      order.line_items << line_items
      order.stub :shipping_method => mock_model(Spree::ShippingMethod, :create_adjustment => true, :adjustment_label => "Shipping")
      order.create_shipment!
      order.stub(:paid? => true, :complete? => true)
      order.finalize!
      order.shipment.shipping_method = order.shipping_method
      order.shipment.ship!
    end

    it "should return the shipment date of the last order" do
      order.subscription.last_shipment_date.to_i.should == Time.now.to_i
    end

    it "should be able to calculate the date of the next shipment" do
      order.subscription.next_shipment_date.to_i.should == 4.weeks.from_now.to_i
    end
  end

end

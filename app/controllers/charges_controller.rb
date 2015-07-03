class ChargesController < ApplicationController
  def create
 
  customer = Stripe::Customer.create(
    email: current_user.email,
    card: params[:stripeToken]
  )

  charge = Stripe::Charge.create(
    customer: customer.id,
    amount: Amount.default,
    description: "Upgrade: #{current_user.email}",
    currency: 'usd'
  )

  current_user.update_attribute(:role, 'premium')

  flash[:success] = "Thank you, #{current_user.email}! Enjoy your premium membership."
  redirect_to wikis_path

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  def new
  @stripe_btn_data = {
    key: "#{ Rails.configuration.stripe[:publishable_key] }",
    description: "Upgrade: #{current_user.name}",
    amount: Amount.default
  }
  end

  def update
    downgrade
  end

  private

  class Amount
    def self.default
      15_00
    end
  end
end

class Admin::ShopsController < ApplicationController
  def show
    @shop = Shop.find(params[:id])

    render json: shop.as_json.slice('id', 'shopify_domain', 'created_at')
  end
end

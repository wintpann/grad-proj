module ProductsHelper

  def active_product!
    if !Product.find(params[:id].to_i).active?
      flash[:danger]="Denied. Restore product first"
      redirect_to root_path
    end
  end

  def constrain_restore!
    product=Product.find(params[:id])
    if !product.active?
      if !product.supplier.active?
        flash[:danger]="Denied. Its supplier is deleted"
        redirect_to root_path
      end
    end
  end

end

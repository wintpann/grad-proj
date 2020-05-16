module SuppliersHelper

  def active_supplier!
    if !Supplier.find(params[:id].to_i).active?
      flash[:danger]="Denied. Restore supplier first"
      redirect_to root_path
    end
  end

  def constrain_destroy!
    supplier=Supplier.find(params[:id])
    if supplier.active?
      if supplier.products.active.any?
        flash[:danger]="Denied. Supplier is attached to < #{supplier.products.active.codes.join(', ')} >"
        redirect_to root_path
      end
    end
  end

end

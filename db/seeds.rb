include ActionsHelper
include ApplicationHelper
include ProductsHelper
include SessionsHelper
include SuppliersHelper
include UsersHelper

password=BCrypt::Password.create('asdfasdf', cost: BCrypt::Engine.cost)

admin=User.create!(identifier: 'admin',
name: 'John',
lastname: 'Koff',
password_digest: password,
role: 'root')
save_user_create_event(user: admin)
from=User.last
admin.update_attribute(:lastname, 'Kirari')
save_user_edit_event(user_to: admin, user_from: from, editor: admin)
save_user_delete_event(user: admin, editor: admin)
save_user_restore_event(user: admin, editor: admin)

llc_freedom=Supplier.create!(name: 'LLC Freedom',
phone: '8-900-2535',
address: '9367 Willow Rd. Northbrook, IL 60062')
save_supplier_create_event(supplier: llc_freedom, editor: admin)

ltd_sofa=Supplier.create!(name: 'LTD Sofa',
phone: '8-752-8262',
address: '65 3rd Ave. Livingston, NJ 07039')
save_supplier_create_event(supplier: ltd_sofa, editor: admin)

co_colonel=Supplier.create!(name: 'CO Colonel',
phone: '8-823-2652',
address: '3 Shore Street Clarksburg, WV 26301')
save_supplier_create_event(supplier: co_colonel, editor: admin)
from=Supplier.last
co_colonel.update_attribute(:address, '65 3rd Ave. Livingston, NJ 07039')
save_supplier_edit_event(snap_from: from, snap_to: co_colonel, editor: admin)
save_supplier_delete_event(supplier: co_colonel, editor: admin)
save_supplier_restore_event(supplier: co_colonel, editor: admin)

armchair=Product.create!(code: 'armchair_01',
name: 'Armchair wide',
unit: 'pcs',
description: 'Just great armchair',
supplier_id: co_colonel.id,
price_in: 200.15,
price_out: 400.4)
save_create_product_event(product: armchair, editor: admin)

cabinet=Product.create!(code: 'cabinet_02',
name: 'Cabinet white',
unit: 'pcs',
description: 'Amazing cabinet',
supplier_id: co_colonel.id,
price_in: 250.15,
price_out: 480.9)
save_create_product_event(product: cabinet, editor: admin)

carpet=Product.create!(code: 'carpet_03',
name: 'Woolen carpet',
unit: 'pcs',
description: 'Wonderful carpet',
supplier_id: ltd_sofa.id,
price_in: 150.75,
price_out: 200.1)
save_create_product_event(product: carpet, editor: admin)

shelf=Product.create!(code: 'shelf_43',
name: 'Modern shelf',
unit: 'pcs',
description: 'Modern black hi-tech shelf',
supplier_id: ltd_sofa.id,
price_in: 50.75,
price_out: 80.1)
save_create_product_event(product: shelf, editor: admin)
from=Product.last
shelf.update_attribute(:name, 'Edited shelf')
save_product_edit_event(snap_from: from, snap_to: shelf, editor: admin)
save_product_delete_event(product: shelf, editor: admin)
save_product_restore_event(product: shelf, editor: admin)

save_arrival(params: {'1'=>'20.4', '2'=>'25.5', '3'=>'30.6'}, editor: admin)
save_realizatioin(params: {'1'=>'1.4', '2'=>'2.5', '3'=>'3.6'}, editor: admin)
save_refund(params: {'1'=>'5.4', '2'=>'3.5', '3'=>'2.6'}, editor: admin)
save_write_off(params: {'1'=>'2.5', '2'=>'7.3', '3'=>'3.1'}, editor: admin)

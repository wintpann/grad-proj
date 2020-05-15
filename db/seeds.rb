password=BCrypt::Password.create('asdfasdf', cost: BCrypt::Engine.cost)

admin=User.create!(identifier: 'admin',
name: 'John',
lastname: 'Koff',
password_digest: password,
role: 'root',
active: true)

llc_freedom=Supplier.create!(name: 'LLC Freedom',
phone: '8-900-2535',
address: '9367 Willow Rd. Northbrook, IL 60062',
active: false)

ltd_sofa=Supplier.create!(name: 'LTD Sofa',
phone: '8-752-8262',
address: '65 3rd Ave. Livingston, NJ 07039')

co_colonel=Supplier.create!(name: 'CO Colonel',
phone: '8-823-2652',
address: '3 Shore Street Clarksburg, WV 26301')

armchair=Product.create!(code: 'armchair_01',
name: 'Armchair wide',
unit: 'pcs',
description: 'Just great armchair',
supplier_id: co_colonel.id,
price_in: 200.15,
price_out: 400.4)

cabinet=Product.create!(code: 'cabinet_02',
name: 'Cabinet white',
unit: 'pcs',
description: 'Amazing cabinet',
supplier_id: co_colonel.id,
price_in: 250.15,
price_out: 480.9)

carpet=Product.create!(code: 'carpet_03',
name: 'Woolen carpet',
unit: 'pcs',
description: 'Wonderful carpet',
supplier_id: ltd_sofa.id,
price_in: 150.75,
price_out: 200.1)

shelf=Product.create!(code: 'shelf_43',
name: 'Modern shelf',
unit: 'pcs',
description: 'Modern black hi-tech shelf',
supplier_id: ltd_sofa.id,
price_in: 50.75,
price_out: 80.1,
active: false)

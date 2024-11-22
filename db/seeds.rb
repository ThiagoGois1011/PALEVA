# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

owner = Owner.create!(name: 'João', last_name: 'Silva Lopes', cpf: '44749124621', email: 'joao@email.com', password: 'password5498')

establishment = Establishment.create!(corporate_name: 'Distribuidora Alimentícia Ifood', brand_name: 'Ifood', 
                                      restration_number: '66500520000171', full_address: 'Av Presindete Cabral', 
                                      phone_number: '11981545874', email: 'contato@ifood.com', user: owner)

Employee.create!(name: 'Andre', last_name: 'Almeida', cpf: '09094018020', email: 'andre@email.com', password: 'password9999' 
                         pre_registration_status: :registration_complete, establishment: establishment)

pre_registration = Employee.new(email: 'juninho@gmail.com', cpf: '99621154006', establishment: establishment)
pre_registration.configurate_employee
pre_registration.save!

7.times do |day| 
  OpeningHour.create!(establishment: establishment, open_hour: '08:00', close_hour: '18:00', day_of_week: day)               
end

marker_1 = Marker.create!(description: 'Alto em sódio', establishment: establishment)
marker_2 = Marker.create!(description: 'Contém Lactose', establishment: establishment)

dish_1 = Dish.create!(name: 'Espaguete', description: 'Macarrão ao molho com pedaços de carne moída', establishment: establishment, marker: marker_1)
dish_2 = Dish.create!(name: 'Estrogonofe', description: 'Frango cortado em cubos ao molho', establishment: establishment, marker: marker_2)
dish_3 = Dish.create!(name: 'Bife Grelhado', description: 'Carne bovina grelhada', establishment: establishment)

beverage_1 = Beverage.create!(name: 'Suco de Laranja', description: 'Feito com laranjas orgânicas', establishment: establishment)
beverage_2 = Beverage.create!(name: 'Coca Cola', description: 'Refrigerante', establishment: establishment)
beverage_3 = Beverage.create!(name: 'Suco de Maracujá', description: 'Feito com \'maracujá do mato\'', establishment: establishment)

menu_1 = Menu.create!(name: 'Café da Manhã', establishment: establishment)
menu_2 = Menu.create!(name: 'Almoço', establishment: establishment)
menu_3 = Menu.create!(name: 'Jantar', establishment: establishment)

menu_1.menu_items.create(item: dish_1)
menu_1.menu_items.create(item: beverage_1)
menu_2.menu_items.create(item: dish_1)
menu_2.menu_items.create(item: dish_2)
menu_2.menu_items.create(item: beverage_1)
menu_2.menu_items.create(item: beverage_2)
menu_3.menu_items.create(item: dish_1)
menu_3.menu_items.create(item: dish_2)
menu_3.menu_items.create(item: dish_3)
menu_3.menu_items.create(item: beverage_1)
menu_3.menu_items.create(item: beverage_2)
menu_3.menu_items.create(item: beverage_3)


portions = []
portions << dish_1.portions.create(description: '100g', price: 5.5)
portions << dish_1.portions.create(description: '300g', price: 12)
portions << dish_1.portions.create(description: '500g', price: 20.9)
portions << dish_2.portions.create(description: '100g', price: 15)
portions << dish_2.portions.create(description: '300g', price: 20)
portions << dish_2.portions.create(description: '500g', price: 30)
portions << dish_3.portions.create(description: '1kg', price: 60.99)
portions << dish_3.portions.create(description: '2kg', price: 110)
portions << dish_3.portions.create(description: '3kg', price: 150)

portions << beverage_1.portions.create(description: '250ml', price: 4)
portions << beverage_1.portions.create(description: '500ml', price: 7)
portions << beverage_1.portions.create(description: '800ml', price: 10)
portions << beverage_2.portions.create(description: 'Lata', price: 3.5)
portions << beverage_2.portions.create(description: '1l', price: 6)
portions << beverage_2.portions.create(description: '2l', price: 9.5)
portions << beverage_3.portions.create(description: '250ml', price: 5.5)
portions << beverage_3.portions.create(description: '500ml', price: 9)
portions << beverage_3.portions.create(description: '800ml', price: 13.5)

discount = Discount.create!(establishment: establishment, name: 'Semana do Macarrão', start_date: Date.today, end_date: 7.days.from_now.to_date,
                            discount_percentage: 10, limit: 7)
discount.portion_discounts.create(portion: portions[0])
discount.portion_discounts.create(portion: portions[1])
discount.portion_discounts.create(portion: portions[3])

order_thiago = Order.create!(name: 'Thiago', phone_number: '11987759974', email: 'thiago@email.com', 
              cpf: '81296399044', establishment: establishment, code: Order.generate_code, 
              status: :in_preparation, creation_date:  DateTime.new(2024, 11, 16, 11, 0, 0))
3.times do |index_portion| 
  order_thiago.order_items.create(portion: portions[index_portion], observation: 'Não coloca muito sal')
end
order_matheus = Order.create!(name: 'Matheus', email: 'matheus@email.com', establishment: establishment, code: Order.generate_code, 
              status: :in_preparation, creation_date:  DateTime.new(2024, 11, 15, 12, 0, 0))
4.times do |index_portion| 
  order_matheus.order_items.create(portion: portions[index_portion], observation: 'Não coloca muito Açúcar')
end
order_joao = Order.create!(name: 'João', email: 'joao@email.com', cpf: CPF.generate establishment: establishment, 
                              code: Order.generate_code,status: :waiting_for_confirmation, creation_date:  DateTime.new(2024, 11, 18, 14, 0, 0))
5.times do |index_portion| 
  order_joao.order_items.create(portion: portions[index_portion])
end
order_pedro = Order.create!(name: 'Pedro', email: 'pedro@email.com', cpf: CPF.generate establishment: establishment, 
                              code: Order.generate_code,status: :waiting_for_confirmation, creation_date:  DateTime.new(2024, 11, 18, 11, 0, 0))
4.times do |index_portion| 
  order_pedro.order_items.create(portion: portions[index_portion])
end
order_william = Order.create!(name: 'William', email: 'wiliam@email.com', cpf: CPF.generate establishment: establishment, 
                              code: Order.generate_code,status: :ready, creation_date:  DateTime.new(2024, 11, 19, 15, 0, 0))
6.times do |index_portion| 
  order_william.order_items.create(portion: portions[index_portion])
end
order_jose = Order.create!(name: 'José', email: 'jose@email.com', cpf: CPF.generate establishment: establishment, 
                              code: Order.generate_code,status: :ready, creation_date:  DateTime.new(2024, 11, 18, 20, 0, 0))
6.times do |index_portion| 
  order_jose.order_items.create(portion: portions[index_portion])
end

discount.order_discounts.create(order: order_thiago)
discount.order_discounts.create(order: order_matheus)
discount.order_discounts.create(order: order_joao)
discount.order_discounts.create(order: order_pedro)
discount.order_discounts.create(order: order_william)
discount.order_discounts.create(order: order_jose)




  

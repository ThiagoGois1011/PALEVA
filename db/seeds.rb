# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

owner = Owner.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')

establishment = Establishment.create!(corporate_name: 'Distribuidora Alimentícia Ifood', brand_name: 'Ifood', 
                                      restration_number: '66500520000171', full_address: 'Av Presindete Cabral', 
                                      phone_number: '11981545874', email: 'contato@ifood.com', user: owner)

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

portions = []
portions << dish_1.portions.create(description: '500g', price: 15)
portions << dish_2.portions.create(description: '300g', price: 20)
portions << dish_3.portions.create(description: '1kg', price: 60)

portions << beverage_1.portions.create(description: '250ml', price: 4)
portions << beverage_2.portions.create(description: 'Lata', price: 3.5)
portions << beverage_3.portions.create(description: '500ml', price: 10)

5.downto(0) do |index|
  order = Order.create!(name: 'Thiago', phone_number: '11987759974', email: 'thiago@email.com', 
                           cpf: '81296399044', establishment: establishment,
                           code: Order.generate_code, status: :in_preparation, creation_date:  DateTime.new(2024, 11, 16, index, 0, 0))
  6.times do |index_portion| 
    order.order_items.create(portion: portions[index_portion], observation: 'Sem açúcar adicional')
  end
end

5.downto(0) do |index|
  order = Order.create!(name: 'Matheus', phone_number: '11988254174', email: 'matheus@email.com', 
                           cpf: '97168422014', establishment: establishment,
                           code: Order.generate_code, status: :waiting_for_confirmation, creation_date: DateTime.new(2024, 11, 14, index, 0, 0))

  3.times do |index_portion| 
    order.order_items.create(portion: portions[index_portion], observation: 'Sem alho')
  end
end

5.downto(0) do |index|
  order = Order.create!(name: 'André', phone_number: '11987754174', email: 'andre@email.com', 
                           cpf: '39421497023', establishment: establishment, 
                           code: Order.generate_code, status: :in_preparation, creation_date:  DateTime.new(2024, 11, 15, index, 0, 0))
  4.times do |index_portion| 
    order.order_items.create(portion: portions[index_portion], observation: 'Sem glúten  ')
  end
end

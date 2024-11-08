def create_owner(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
  Owner.create!(name: name, last_name: last_name, cpf: cpf, email: email, password: password)
end

def create_secondary_owner(name: 'Thiago', last_name: 'Gois', cpf: '31674941072', email: 'thiago@email.com', password: 'password1234')
  Owner.create!(name: name, last_name: last_name, cpf: cpf, email: email, password: password)
end

def create_establishment(owner, corporate_name: 'Distribuidora Alimentícia Ifood', brand_name: 'Ifood', 
                        restration_number: '66500520000171', full_address: 'Av Presindete Cabral', 
                        phone_number: '11981545874', email: 'contato@ifood.com')

  establishment = Establishment.create!(corporate_name: corporate_name, brand_name: brand_name, 
                                        restration_number: restration_number, full_address: full_address, 
                                        phone_number: phone_number, email: email, user: owner)

end

def create_establishment_and_opening_hour(owner, corporate_name: 'Distribuidora Alimentícia Ifood', brand_name: 'Ifood', 
                                          restration_number: '66500520000171', full_address: 'Av Presindete Cabral', 
                                          phone_number: '11981545874', email: 'contato@ifood.com', open_hour: '08:00', close_hour: '18:00')

  establishment = Establishment.create!(corporate_name: corporate_name, brand_name: brand_name, 
                                        restration_number: restration_number, full_address: full_address, 
                                        phone_number: phone_number, email: email, user: owner)
  7.times do |day| 
    OpeningHour.create!(establishment: establishment, open_hour: open_hour, 
                        close_hour: close_hour, day_of_week: day)               
  end

  establishment
end

def create_secondary_establishment_and_opening_hour(owner, corporate_name: 'Distribuidora Mc lanches', brand_name: 'Mc lanches', 
                                                    restration_number: '62189559000169', full_address: 'Av João Pereira', 
                                                    phone_number: '11981575574', email: 'contato@mclanches.com', open_hour: '08:00', close_hour: '18:00')

  establishment = Establishment.create!(corporate_name: corporate_name, brand_name: brand_name, 
                                        restration_number: restration_number, full_address: full_address, 
                                        phone_number: phone_number, email: email, user: owner)
  7.times do |day| 
    OpeningHour.create!(establishment: establishment, open_hour: open_hour, 
                        close_hour: close_hour, day_of_week: day)               
  end

  establishment
end

def create_dishes(establishment, dish_1: {name: 'Espaguete', description: 'Macarrão ao molho com pedaços de carne moída'},                 
                  dish_2: {name: 'Estrogonofe', description: 'Frango cortado em cubos ao molho'},
                  dish_3: {name: 'Bife Grelhado', description: 'Carne bovina grelhada'})
  products = []
  
  products << Dish.create!(name: dish_1[:name], description: dish_1[:description], establishment: establishment)
  products << Dish.create!(name: dish_2[:name], description: dish_2[:description], establishment: establishment)
  products << Dish.create!(name: dish_3[:name], description: dish_3[:description], establishment: establishment)

  products
end

def create_beverages(establishment, beverage_1: {name: 'Suco de Laranja', description: 'Feito com laranjas orgânicas'},                 
                     beverage_2: {name: 'Coca Cola', description: 'Refrigerante'},
                     beverage_3: {name: 'Suco de Maracujá', description: 'Feito com \'maracujá do mato\''})

  products = []
  
  products << Beverage.create!(name: beverage_1[:name], description: beverage_1[:description], establishment: establishment)
  products << Beverage.create!(name: beverage_2[:name], description: beverage_2[:description], establishment: establishment)
  products << Beverage.create!(name: beverage_3[:name], description: beverage_3[:description], establishment: establishment)

  products
end

def create_dishes_with_portions(establishment, dish_1: {name: 'Espaguete', description: 'Macarrão ao molho com pedaços de carne moída'},                 
                                dish_2: {name: 'Estrogonofe', description: 'Frango cortado em cubos ao molho'},
                                dish_3: {name: 'Bife Grelhado', description: 'Carne bovina grelhada'})
  products = []
  
  products << Dish.create!(name: dish_1[:name], description: dish_1[:description], establishment: establishment)
  products << Dish.create!(name: dish_2[:name], description: dish_2[:description], establishment: establishment)
  products << Dish.create!(name: dish_3[:name], description: dish_3[:description], establishment: establishment)

  price_count = 1
  products.each do |product| 
    product.portions.create(description: 'Porção ' + product.name, price: price_count)
    price_count += 1
  end

  products
end

def create_beverages_with_portions(establishment, beverage_1: {name: 'Suco de Laranja', description: 'Feito com laranjas orgânicas'},                 
                                  beverage_2: {name: 'Coca Cola', description: 'Refrigerante'},
                                  beverage_3: {name: 'Suco de Maracujá', description: 'Feito com \'maracujá do mato\''})
  products = []
  
  products << Beverage.create!(name: beverage_1[:name], description: beverage_1[:description], establishment: establishment)
  products << Beverage.create!(name: beverage_2[:name], description: beverage_2[:description], establishment: establishment)
  products << Beverage.create!(name: beverage_3[:name], description: beverage_3[:description], establishment: establishment)

  price_count = 1
  products.each do |product| 
    product.portions.create(description: 'Porção ' + product.name, price: price_count)
    price_count += 1
  end
  
  products
end
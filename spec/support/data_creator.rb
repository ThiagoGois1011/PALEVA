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
  produtos = []
  
  produtos << Dish.create!(dish_1, establishment: establishment)
  produtos << Dish.create!(dish_2, establishment: establishment)
  produtos << Dish.create!(dish_3, establishment: establishment)

  produtos
end

def create_beverages(establishment)
  produtos = []
  
  produtos << Beverage.create!(name: 'Suco de Laranja', description: 'Feito com laranjas orgânicas', establishment: establishment)
  produtos << Beverage.create!(name: 'Coca Cola', description: 'Refrigerante', establishment: establishment)
  produtos << Beverage.create!(name: 'Suco de Maracujá', description: 'Feito com \'maracujá do mato\'', establishment: establishment)

  produtos
end

def create_dishes_and_beverages(establishment)
  dishes = create_dishes(establishment)
  beverages = create_beverages(establishment)

  dishes + beverages
end

def create_dishes_with_portion(establishment)
  products = []
  
  products << Dish.create!(name: 'Espaguete', description: 'Macarrão ao molho com pedaços de carne moída', establishment: establishment)
  products << Dish.create!(name: 'Estrogonofe', description: 'Frango cortado em cubos ao molho', establishment: establishment)
  products << Dish.create!(name: 'Bife Grelhado', description: 'Carne bovina grelhada', establishment: establishment)

  products.each do |product| 
    product.portions.create(description: 'Porção ' + product.name, price: 5.0)
  end

  products
end

def create_beverages_with_portion(establishment)
  products = []
  
  products << Beverage.create!(name: 'Suco de Laranja', description: 'Feito com laranjas orgânicas', establishment: establishment)
  products << Beverage.create!(name: 'Coca Cola', description: 'Refrigerante', establishment: establishment)
  products << Beverage.create!(name: 'Suco de Maracujá', description: 'Feito com \'maracujá do mato\'', establishment: establishment)
  
  price_count = 1
  products.each do |product| 
    product.portions.create(description: 'Porção ' + product.name, price: price_count)
    price_count += 1
  end
  
  products
end

def create_dishes_and_beverages(establishment)
  dishes = create_dishes(establishment)
  beverages = create_beverages(establishment)

  dishes + beverages
end

def create_dishes_and_beverages_with_portions(establishment)
  dishes = create_dishes_with_portion(establishment)
  beverages = create_beverages_with_portion(establishment)

  dishes + beverages
end
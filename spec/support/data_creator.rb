def create_user(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
  User.create!(name: name, last_name: last_name, cpf: cpf, email: email, password: password)
end

def create_secondary_user(name: 'Thiago', last_name: 'Gois', cpf: '31674941072', email: 'thiago@email.com', password: 'password1234')
  User.create!(name: name, last_name: last_name, cpf: cpf, email: email, password: password)
end

def create_establishment_and_opening_hour(user)
  establishment = Establishment.create!(corporate_name: 'Distribuidora Alimentícia Ifood', brand_name: 'Ifood', 
                        restration_number: '66500520000171', full_address: 'Av Presindete Cabral', 
                        phone_number: '11981545874', email: 'contato@ifood.com', user: user)
  7.times do |day| 
    OpeningHour.create!(establishment: establishment, open_hour: '08:00', 
                        close_hour: '18:00', day_of_week: day)               
  end

  establishment
end

def create_secondary_establishment_and_opening_hour(user)
  establishment = Establishment.create!(corporate_name: 'Distribuidora Mc lanches', brand_name: 'Mc lanches', 
                                        restration_number: CNPJ.generate, full_address: 'Av Presindete Cabral', 
                                        phone_number: '11981575574', email: 'contato@mclanches.com', user: user)
  7.times do |day| 
    OpeningHour.create!(establishment: establishment, open_hour: '08:00', 
                        close_hour: '18:00', day_of_week: day)               
  end

  establishment
end

def create_dishes(establishment)
  produtos = []
  
  produtos << Dish.create!(name: 'Espaguete', description: 'Macarrão ao molho com pedaços de carne moída', establishment: establishment)
  produtos << Dish.create!(name: 'Estrogonofe', description: 'Frango cortado em cubos ao molho', establishment: establishment)
  produtos << Dish.create!(name: 'Bife Grelhado', description: 'Carne bovina grelhada', establishment: establishment)

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
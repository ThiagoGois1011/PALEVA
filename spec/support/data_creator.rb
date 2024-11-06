def create_user
  User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: 44749124621, email: 'andre@email.com', password: 'password5498')
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

def create_dishes_and_beverages(establishment)
  produtos = []
  
  produtos << Dish.create!(name: 'Espaguete', description: 'Macarrão ao molho com pedaços de carne moída', establishment: establishment)
  produtos << Dish.create!(name: 'Estrogonofe', description: 'Frango cortado em cubos ao molho', establishment: establishment)
  produtos << Dish.create!(name: 'Bife Grelhado', description: 'Carne bovina grelhada', establishment: establishment)

  produtos << Beverage.create!(name: 'Suco de Laranja', description: 'Feito com laranjas orgânicas', establishment: establishment)
  produtos << Beverage.create!(name: 'Coca Cola', description: 'Refrigerante', establishment: establishment)
  produtos << Beverage.create!(name: 'Suco de Maracujá', description: 'Feito com \'maracujá do mato\'', establishment: establishment)

  produtos
end
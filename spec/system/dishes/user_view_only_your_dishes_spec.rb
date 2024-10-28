require 'rails_helper'

describe 'Usuário vê os seus pratos' do
  it 'e não vê o dos outros estabelecimento' do
    user_1 = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
    establishment_1 = Establishment.create!(corporate_name: 'Distribuidora Alimentícia Ifood', brand_name: 'Ifood', 
                                          restration_number: CNPJ.generate, full_address: 'Av Presindete Cabral', 
                                          phone_number: '11981545874', email: 'contato@ifood.com', user: user_1)
    7.times do |day| 
      OpeningHour.create!(establishment: establishment_1, open_hour: '08:00', 
                          close_hour: '18:00', day_of_week: day)               
    end
    user_2 = User.create!(name: 'Thiago', last_name: 'Gois', cpf: CPF.generate, email: 'thiago@email.com', password: 'password1234')
    establishment_2 = Establishment.create!(corporate_name: 'Distribuidora Alimentícia Ifood', brand_name: 'Ifood', 
                                          restration_number: CNPJ.generate, full_address: 'Av Presindete Cabral', 
                                          phone_number: '11981545274', email: 'vendas@ifood.com', user: user_2)
    7.times do |day| 
      OpeningHour.create!(establishment: establishment_2, open_hour: '08:00', 
                          close_hour: '18:00', day_of_week: day)               
    end
    Dish.create!(name: 'Miojo', description: 'Da Nissin', establishment: establishment_1)
    Dish.create!(name: 'Espaguete', description: 'Macarrão com muito molho', establishment: establishment_2)

    login_as user_1
    visit establishment_dishes_path(establishment_2.id)

    expect(page).to have_content('Você não tem permissão de ver essa página')
    expect(current_path).to eq(establishment_path(establishment_1))
  end
end
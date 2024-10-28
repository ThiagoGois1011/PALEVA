require 'rails_helper'

describe 'Usuário deleta uma bebida' do
  it 'com sucesso' do
    user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
    establishment = Establishment.create!(corporate_name: 'Distribuidora Alimentícia Ifood', brand_name: 'Ifood', 
                                          restration_number: CNPJ.generate, full_address: 'Av Presindete Cabral', 
                                          phone_number: '11981545874', email: 'contato@ifood.com', user: user)
    7.times do |day| 
      OpeningHour.create!(establishment: establishment, open_hour: '08:00', 
                          close_hour: '18:00', day_of_week: day)               
    end
    Beverage.create!(name: 'Suco de Laranja', description: 'Feito com laranjas orgânicas', calorie: 400, establishment: establishment)

    login_as user
    visit root_path
    click_on 'Estabelecimento'
    click_on 'Bebidas'
    click_on 'Suco de Laranja'
    click_on 'Deletar'

    expect(page).not_to have_content('Nome: Suco de Laranja')
    expect(page).not_to have_content('Descrição: Feito com laranjas orgânicas')
    expect(page).not_to have_content('Calorias: 400')
    expect(establishment.corporate_name).to include('Distribuidora Alimentícia Ifood')
  end
end
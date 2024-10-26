require 'rails_helper'

describe 'Usuário vê as suas bebidas' do
  it 'e não vê o dos outros estabelecimento' do
    user_1 = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
    establishment_1 = Establishment.create!(corporate_name: 'Distribuidora Alimentícia Ifood', brand_name: 'Ifood', 
                                          restration_number: CNPJ.generate, full_address: 'Av Presindete Cabral', 
                                          phone_number: '11981545874', email: 'contato@ifood.com', user: user_1)
    user_2 = User.create!(name: 'Thiago', last_name: 'Gois', cpf: CPF.generate, email: 'thiago@email.com', password: 'password1234')
    establishment_2 = Establishment.create!(corporate_name: 'Distribuidora Alimentícia Ifood', brand_name: 'Ifood', 
                                          restration_number: CNPJ.generate, full_address: 'Av Presindete Cabral', 
                                          phone_number: '11981545874', email: 'contato@ifood.com', user: user_2)
    Beverage.create!(name: 'Suco de Laranja', description: 'Feito com laranjas orgânicas', calorie: 400, establishment: establishment_1)
    Beverage.create!(name: 'Suco de Goiaba', description: 'Feito com goiabas orgânicas', calorie: 600, establishment: establishment_2)

    login_as user_1
    visit establishment_dishes_path(establishment_2.id)

    expect(page).to have_content('Você não tem permissão de ver essa página')
    expect(current_path).to eq(establishment_path(establishment_1))
  end
end
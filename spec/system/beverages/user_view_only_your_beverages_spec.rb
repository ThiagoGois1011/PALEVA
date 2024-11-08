require 'rails_helper'

describe 'Usuário vê as suas bebidas' do
  it 'e não vê o dos outros estabelecimento' do
    user_1 = create_owner(name: 'Andre')
    establishment_1 = create_establishment_and_opening_hour(user_1, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', 
                                                          close_hour: '18:00')
    user_2 = create_secondary_owner(name: 'Thiago')
    establishment_2 = create_secondary_establishment_and_opening_hour(user_2, corporate_name: 'Distribuidora MC Lanches', open_hour: '08:00', 
                                                          close_hour: '18:00')
    Beverage.create!(name: 'Suco de Laranja', description: 'Feito com laranjas orgânicas', calorie: 400, establishment: establishment_1)
    Beverage.create!(name: 'Suco de Goiaba', description: 'Feito com goiabas orgânicas', calorie: 600, establishment: establishment_2)

    login_as user_1
    visit establishment_dishes_path(establishment_2)

    expect(page).to have_content('Você não tem permissão de ver essa página')
    expect(current_path).to eq(establishment_path(establishment_1))
  end
end
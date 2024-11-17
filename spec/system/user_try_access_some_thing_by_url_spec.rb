require 'rails_helper'

describe 'Usuário tenta acessar algo pelo id da url' do
  it 'mas é redirecionado' do
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', 
                                                          close_hour: '18:00')
    random_id = 80

    login_as user 
    visit establishment_beverage_path(random_id)

    expect(current_path).to eq(establishment_menus_path)
    expect(page).to have_content('Objeto não encontrado.')
  end

  it 'e acerta em um id existente mas de outro estabelecimento' do
    user_1 = create_owner(name: 'Andre')
    establishment_1 = create_establishment_and_opening_hour(user_1, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', 
                                                          close_hour: '18:00')

    user_2 = create_secondary_owner(name: 'Thiago')
    establishment_2 = create_secondary_establishment_and_opening_hour(user_2, corporate_name: 'Distribuidora MC lanches', open_hour: '08:00', 
                                                          close_hour: '18:00')
    beverage = Beverage.create!(name: 'Suco de Laranja', description: 'Feito com laranjas orgânicas', establishment: establishment_2)


    login_as user_1 
    visit establishment_beverage_path(beverage)

    expect(current_path).to eq(establishment_menus_path)
    expect(page).to have_content('Objeto não encontrado.')
  end
end
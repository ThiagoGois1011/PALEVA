require 'rails_helper'

describe 'Usuário vê os seus pratos' do
  it 'e não vê o dos outros estabelecimento' do
    user_1 = create_owner(name: 'Andre')
    establishment_1 = create_establishment_and_opening_hour(user_1, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', 
                                                          close_hour: '18:00')
    user_2 = create_secondary_owner(name: 'Thiago')
    establishment_2 = create_secondary_establishment_and_opening_hour(user_2, corporate_name: 'Distribuidora MC Lanches', open_hour: '08:00', 
                                                          close_hour: '18:00')
    Dish.create!(name: 'Miojo', description: 'Da Nissin', establishment: establishment_1)
    Dish.create!(name: 'Espaguete', description: 'Macarrão com muito molho', establishment: establishment_2)

    login_as user_1
    visit establishment_dishes_path

    expect(page).not_to have_content('Espaguete')
  end
end
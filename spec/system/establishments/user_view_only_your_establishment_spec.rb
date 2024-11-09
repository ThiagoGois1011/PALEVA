require 'rails_helper'

describe 'Usuário vê o seu estabelecimento' do
  it 'e não vê outros' do
    user_1 = create_owner(name: 'Andre')
    establishment_1 = create_establishment_and_opening_hour(user_1, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', 
                                                          close_hour: '18:00')
    user_2 = create_secondary_owner(name: 'Thiago')
    establishment_2 = create_secondary_establishment_and_opening_hour(user_2, corporate_name: 'Distribuidora MC Lanches', brand_name: 'MC Lanches', 
                                                                      email: 'vendas@mclanche.com', open_hour: '08:00', close_hour: '18:00')

    login_as user_1
    visit establishment_path

    expect(page).not_to have_content('MC Lanches')
    expect(page).not_to have_content('vendas@mclanche.com')
    expect(current_path).to eq(establishment_path)
  end
end
require 'rails_helper'

describe 'Usuário deleta um prato' do
  it 'com sucesso' do
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', 
                                                          close_hour: '18:00')
    Dish.create!(name: 'Miojo', description: 'Da Nissin', calorie: 400, establishment: establishment)

    login_as user
    visit root_path
    click_on 'Pratos'
    click_on 'Miojo'
    click_on 'Deletar'

    expect(page).not_to have_content('Nome: Miojo')
    expect(page).not_to have_content('Descrição: Da Nissin')
    expect(page).not_to have_content('Calorias: 400')
    expect(establishment.corporate_name).to include('Distribuidora Alimentícia Ifood')
  end
end
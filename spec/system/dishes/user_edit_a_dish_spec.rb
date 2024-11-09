require 'rails_helper'

describe 'Usuário edita um prato' do
  it 'com sucesso' do
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', 
                                                          close_hour: '18:00')
    Dish.create!(name: 'Miojo', description: 'Da Nissin', establishment: establishment)

    login_as user
    visit root_path
    click_on 'Pratos'
    click_on 'Miojo'
    click_on 'Editar'
    fill_in 'Descrição', with: 'Do tipo Talharim'
    fill_in 'Calorias', with: '400'
    attach_file 'Foto do prato', Rails.root.join('spec', 'fixtures', 'miojo.jpg')
    click_on 'Salvar'

    expect(page).to have_content('Nome: Miojo')
    expect(page).to have_content('Descrição: Do tipo Talharim')
    expect(page).to have_content('Calorias: 400')
  end
end
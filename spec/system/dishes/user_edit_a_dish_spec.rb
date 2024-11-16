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
    click_on 'Ver detalhes'
    click_on 'Editar'
    fill_in 'Descrição', with: 'Do tipo Talharim'
    fill_in 'Calorias', with: '400'
    attach_file 'Foto do prato', Rails.root.join('spec', 'fixtures', 'miojo.jpg')
    click_on 'Salvar'

    expect(page).to have_content('Nome: Miojo')
    expect(page).to have_content('Descrição: Do tipo Talharim')
    expect(page).to have_content('Calorias: 400')
  end

  it 'com campos em branco' do
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', 
                                                          close_hour: '18:00')
    dish = Dish.create!(name: 'Miojo', description: 'Da Nissin', establishment: establishment)

    login_as user
    visit root_path
    click_on 'Pratos'
    click_on 'Ver detalhes'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Calorias', with: ''
    click_on 'Salvar'


    expect(page).to have_content('Prato não editado.')
    expect(current_path).to have_content(establishment_dish_path(dish))
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Descrição não pode ficar em branco')
  end
end
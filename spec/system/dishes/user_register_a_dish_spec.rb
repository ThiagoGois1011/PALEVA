require 'rails_helper'

describe 'Usuário cadastra um prato' do
  it 'com sucesso' do 
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', 
                                                          close_hour: '18:00')
                                          
    login_as user
    visit root_path
    click_on 'Pratos'
    click_on 'Cadastrar Prato'
    fill_in 'Nome', with: 'Miojo'
    fill_in 'Descrição', with: 'Feito da marca Nissin'
    fill_in 'Calorias', with: '400'
    attach_file 'Foto do prato', Rails.root.join('spec', 'fixtures', 'miojo.jpg')
    click_on "Salvar"

    expect(page).to have_content('Prato cadastrado com sucesso.')
    expect(page).to have_content('Nome: Miojo')
    expect(page).to have_content('Descrição: Feito da marca Nissin')
    expect(page).to have_content('Calorias: 400')
    expect(page).to have_content('Status: Ativo')
  end

  it 'com campos em branco' do 
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', 
                                                          close_hour: '18:00')
                                          
    login_as user
    visit root_path
    click_on 'Pratos'
    click_on 'Cadastrar Prato'
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Calorias', with: ''
    click_on "Salvar"

    expect(page).to have_content('Prato não cadastrado.')
    expect(current_path).to have_content(establishment_dishes_path)
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Descrição não pode ficar em branco')
  end
end
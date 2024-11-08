require 'rails_helper'

describe 'Usuário cadastra um estabelecimento' do
  it 'com sucesso' do
    user = create_owner(name: 'Andre')
    cnpj = CNPJ.generate

    login_as user
    visit root_path
    click_on 'Estabelecimento'
    fill_in 'Nome Fantasia', with: 'Distribuidora Alimentícia Ifood'
    fill_in 'Razão Social', with: 'Ifood'
    fill_in 'CNPJ', with:cnpj
    fill_in 'Endereço', with: 'av presindete cabral'
    fill_in 'Telefone', with: '11981545874'
    fill_in 'Email', with: 'contato@ifood.com'
    click_on 'Cadastrar Estabelecimento'

    establishment = Establishment.last
    expect(current_path).to eq(new_establishment_opening_hour_path(establishment.id))
    expect(establishment.brand_name).to have_content('Ifood')
    expect(establishment.restration_number).to have_content(cnpj)
    expect(establishment.email).to have_content('contato@ifood.com')
  end

  it 'e deixa os campos em branco' do 
    user = create_owner(name: 'Andre')

    login_as user
    visit root_path
    click_on 'Estabelecimento'
    fill_in 'Nome Fantasia', with: ''
    fill_in 'Razão Social', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: ''
    click_on 'Cadastrar Estabelecimento'
    
    expect(page).to have_content('O estabelecimento não foi cadastrado.')
    expect(page).to have_content('Nome Fantasia não pode ficar em branco')
    expect(page).to have_content('Razão Social não pode ficar em branco')
    expect(page).to have_content('CNPJ não pode ficar em branco')
    expect(page).to have_content('Endereço não pode ficar em branco')
  end

  it 'e tenta colocar informações que ja existe' do
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', 
                                                          close_hour: '18:00')
    user_2 = create_secondary_owner(name: 'Thiago')

    login_as user_2
    visit root_path
    click_on 'Estabelecimento'
    fill_in 'CNPJ', with: '66500520000171'
    fill_in 'Telefone', with: '11981545874'
    fill_in 'Email', with: 'contato@ifood.com'
    click_on 'Cadastrar Estabelecimento'
    
    expect(page).to have_content('O estabelecimento não foi cadastrado.')
    expect(page).to have_content('CNPJ já está em uso')
    expect(page).to have_content('Telefone já está em uso')
    expect(page).to have_content('Email já está em uso')
  end
end
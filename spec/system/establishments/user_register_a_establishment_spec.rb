require 'rails_helper'

describe 'Usuário cadastra um estabelecimento' do
  it 'com sucesso' do
    user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
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
    user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')

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
    user_1 = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
    establishment_1 = Establishment.create!(corporate_name: 'Distribuidora Alimentícia Ifood', brand_name: 'Ifood', 
                                            restration_number: '66500520000171', full_address: 'Av Presindete Cabral', 
                                            phone_number: '11981545874', email: 'contato@ifood.com', user: user_1)
    user_2 = User.create!(name: 'Thiago', last_name: 'Gois', cpf: CPF.generate, email: 'thiago@email.com', password: 'password1234')

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
require 'rails_helper'

describe 'Usuário cadastra um estabelecimento' do
  it 'com sucesso' do
    user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')

    login_as user
    visit root_path
    fill_in 'Nome Fantasia', with: 'Distribuidora Alimentícia Ifood'
    fill_in 'Razão Social', with: 'Ifood'
    fill_in 'CNPJ', with: CNPJ.generate
    fill_in 'Endereço', with: 'av presindete cabral'
    fill_in 'Telefone', with: '11981545874'
    fill_in 'Email', with: 'contato@ifood.com'
    click_on 'Cadastrar Estabelecimento'
    
    expect(page).to have_content('Restaurante cadastrado com sucesso.')
    expect(page).to have_content('Ifood')
    expect(page).to have_content('contato@ifood.com')
  end
end
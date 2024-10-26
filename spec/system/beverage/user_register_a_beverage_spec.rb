require 'rails_helper'

describe 'Usuário cadastra uma bebida' do
  it 'com sucesso' do 
    user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
    establishment = Establishment.create!(corporate_name: 'Distribuidora Alimentícia Ifood', brand_name: 'Ifood', 
                                          restration_number: CNPJ.generate, full_address: 'Av Presindete Cabral', 
                                          phone_number: '11981545874', email: 'contato@ifood.com', user: user)
                                          
    login_as user
    visit root_path
    click_on 'Estabelecimento'
    click_on 'Bebidas'
    click_on 'Cadastrar Bebida'
    fill_in 'Nome', with: 'Suco de Laranja'
    fill_in 'Descrição', with: 'Feito com laranjas orgânicas'
    fill_in 'Calorias', with: '400'
    attach_file 'Foto da bebida', Rails.root.join('spec', 'fixtures', 'suco de laranja.jpg')
    click_on "Cadastrar Bebida"

    expect(page).to have_content('Bebida cadastrada com sucesso.')
    expect(page).to have_content('Suco de Laranja')
    expect(page).to have_content('Feito com laranjas orgânicas')
  end
end
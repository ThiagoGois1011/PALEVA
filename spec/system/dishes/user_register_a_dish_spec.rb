require 'rails_helper'

describe 'Usuário cadastra um prato' do
  it 'com sucesso' do 
    user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
    establishment = Establishment.create!(corporate_name: 'Distribuidora Alimentícia Ifood', brand_name: 'Ifood', 
                                          restration_number: CNPJ.generate, full_address: 'Av Presindete Cabral', 
                                          phone_number: '11981545874', email: 'contato@ifood.com', user: user)
    7.times do |day| 
      OpeningHour.create!(establishment: establishment, open_hour: '08:00', 
                          close_hour: '18:00', day_of_week: day)               
    end
                                          
    login_as user
    visit root_path
    click_on 'Estabelecimento'
    click_on 'Pratos'
    click_on 'Cadastrar Prato'
    fill_in 'Nome', with: 'Miojo'
    fill_in 'Descrição', with: 'Feito da marca Nissin'
    fill_in 'Calorias', with: '400'
    attach_file 'Foto do prato', Rails.root.join('spec', 'fixtures', 'miojo.jpg')
    click_on "Cadastrar Prato"

    expect(page).to have_content('Prato cadastrado com sucesso.')
    expect(page).to have_content('Nome: Miojo')
    expect(page).to have_content('Descrição: Feito da marca Nissin')
    expect(page).to have_content('Status: Ativo')
  end
end
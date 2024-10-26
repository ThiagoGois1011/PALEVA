require 'rails_helper'

describe 'Usuário edita um prato' do
  it 'com sucesso' do
    user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
    establishment = Establishment.create!(corporate_name: 'Distribuidora Alimentícia Ifood', brand_name: 'Ifood', 
                                          restration_number: CNPJ.generate, full_address: 'Av Presindete Cabral', 
                                          phone_number: '11981545874', email: 'contato@ifood.com', user: user)
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
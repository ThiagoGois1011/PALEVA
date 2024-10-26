require 'rails_helper'

describe 'Usuário deleta um prato' do
  it 'com sucesso' do
    user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
    establishment = Establishment.create!(corporate_name: 'Distribuidora Alimentícia Ifood', brand_name: 'Ifood', 
                                          restration_number: CNPJ.generate, full_address: 'Av Presindete Cabral', 
                                          phone_number: '11981545874', email: 'contato@ifood.com', user: user)
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
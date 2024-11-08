require 'rails_helper'

describe 'Usuário deleta uma bebida' do
  it 'com sucesso' do
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', 
                                                          close_hour: '18:00')
    Beverage.create!(name: 'Suco de Laranja', description: 'Feito com laranjas orgânicas', calorie: 400, establishment: establishment)

    login_as user
    visit root_path
    click_on 'Estabelecimento'
    click_on 'Bebidas'
    click_on 'Suco de Laranja'
    click_on 'Deletar'

    expect(page).not_to have_content('Nome: Suco de Laranja')
    expect(page).not_to have_content('Descrição: Feito com laranjas orgânicas')
    expect(page).not_to have_content('Calorias: 400')
    expect(establishment.corporate_name).to include('Distribuidora Alimentícia Ifood')
  end
end
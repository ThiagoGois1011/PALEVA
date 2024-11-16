require 'rails_helper'

describe 'Usuário cadastra uma bebida' do
  it 'com sucesso' do 
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', 
                                                          close_hour: '18:00')
                                          
    login_as user
    visit root_path
    click_on 'Bebidas'
    click_on 'Cadastrar Bebida'
    fill_in 'Nome', with: 'Suco de Laranja'
    fill_in 'Descrição', with: 'Feito com laranjas orgânicas'
    fill_in 'Calorias', with: '400'
    attach_file 'Foto da bebida', Rails.root.join('spec', 'fixtures', 'suco de laranja.jpg')
    check 'Alcoólico?'
    click_on "Cadastrar Bebida"

    expect(page).to have_content('Bebida cadastrada com sucesso.')
    expect(page).to have_content('Suco de Laranja')
    expect(page).to have_content('Feito com laranjas orgânicas')
    
    beverage = Beverage.last
    expect(beverage.name).to eq('Suco de Laranja')
    expect(beverage.description).to eq('Feito com laranjas orgânicas')
    expect(beverage.calorie).to eq(400)
    expect(beverage.alcoholic).to eq(true)
  end
end
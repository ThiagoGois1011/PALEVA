require 'rails_helper'

describe 'Usuário edita uma bebida' do
  it 'com sucesso' do
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', 
                                                          close_hour: '18:00')
    Beverage.create!(name: 'Suco de Laranja', description: 'Feito com laranjas orgânicas', establishment: establishment)

    login_as user
    visit root_path
    click_on 'Bebidas'
    click_on 'Suco de Laranja'
    click_on 'Editar'
    fill_in 'Descrição', with: 'Feito com Tang de Laranja'
    fill_in 'Calorias', with: '400'
    attach_file 'Foto da bebida', Rails.root.join('spec', 'fixtures', 'suco de laranja.jpg')
    check 'Alcoólico?'
    click_on 'Salvar'


    expect(page).to have_content('Nome: Suco de Laranja')
    expect(page).to have_content('Descrição: Feito com Tang de Laranja')
    expect(page).to have_content('Calorias: 400')
    expect(page).to have_content('Alcoólico?: Sim')
  end
end
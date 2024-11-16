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
    click_on 'Ver detalhes'
    click_on 'Editar'
    fill_in 'Descrição', with: 'Feito com Tang de Laranja'
    fill_in 'Calorias', with: '400'
    attach_file 'Foto da bebida', Rails.root.join('spec', 'fixtures', 'suco de laranja.jpg')
    check 'Alcoólico?'
    click_on 'Salvar'


    expect(page).to have_content('Bebida editada com sucesso.')
    expect(page).to have_content('Nome: Suco de Laranja')
    expect(page).to have_content('Descrição: Feito com Tang de Laranja')
    expect(page).to have_content('Calorias: 400')
    expect(page).to have_content('Alcoólico?: Sim')
  end

  it 'com campos em branco' do
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', 
                                                          close_hour: '18:00')
    beverage = Beverage.create!(name: 'Suco de Laranja', description: 'Feito com laranjas orgânicas', establishment: establishment)

    login_as user
    visit root_path
    click_on 'Bebidas'
    click_on 'Ver detalhes'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Calorias', with: ''
    click_on 'Salvar'


    expect(page).to have_content('Bebida não editada.')
    expect(current_path).to have_content(establishment_beverage_path(beverage))
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Descrição não pode ficar em branco')
  end
end
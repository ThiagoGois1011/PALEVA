require 'rails_helper'

describe 'Usuário vê o status do prato' do
  it 'a partir da lista de pratos' do
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', 
                                                          close_hour: '18:00')
    Dish.create!(name: 'Miojo', description: 'Da Nissin', establishment: establishment)

    login_as user 
    visit establishment_dishes_path(establishment.id)

    expect(page).to have_content('Nome: Miojo')
    expect(page).to have_content('Status: Ativo')
  end

  it 'a partir da página do prato' do
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', 
                                                          close_hour: '18:00')
    Dish.create!(name: 'Miojo', description: 'Da Nissin', establishment: establishment)

    login_as user 
    visit establishment_dishes_path(establishment.id)
    click_on 'Miojo'

    expect(page).to have_content('Nome: Miojo')
    expect(page).to have_content('Status: Ativo')
  end

  it 'e edita para desativado' do
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', 
                                                          close_hour: '18:00')
    Dish.create!(name: 'Miojo', description: 'Da Nissin', establishment: establishment)

    login_as user 
    visit establishment_dishes_path(establishment.id)
    click_on 'Miojo'
    click_on 'Desativar'

    expect(page).to have_content('Nome: Miojo')
    expect(page).to have_content('Status: Desativado')
  end

  it 'e edita para ativado' do
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', 
                                                          close_hour: '18:00')
    Dish.create!(name: 'Miojo', description: 'Da Nissin', establishment: establishment, status: :disabled)

    login_as user 
    visit establishment_dishes_path(establishment.id)
    click_on 'Miojo'
    click_on 'Ativar'

    expect(page).to have_content('Nome: Miojo')
    expect(page).to have_content('Status: Ativo')
  end
end
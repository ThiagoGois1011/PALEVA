require 'rails_helper'

describe 'Usuário cadastra uma porção' do
  it 'a partir da lista de pratos' do
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', close_hour: '18:00')
    dish = Dish.create!(name: 'Miojo', description: 'Da Nissin', establishment: establishment)

    login_as user
    visit establishment_dishes_path
    click_on 'Ver detalhes'
    click_on 'Cadastrar uma porção'
    fill_in 'Descrição', with: '1kg'
    fill_in 'Preço', with: '20.00'
    click_on 'Salvar'

    expect(current_path).to eq(establishment_dish_path(dish)) 
    expect(page).to have_content('Porções')
    expect(page).to have_content('1kg')
    expect(page).to have_content('20.00')
  end

  it 'a partir da lista de bebidas' do
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', close_hour: '18:00')
    beverage = Beverage.create!(name: 'Suco de Laranja', description: 'com laranja orgânica', establishment: establishment)

    login_as user
    visit establishment_beverages_path
    click_on 'Ver detalhes'
    click_on 'Cadastrar uma porção'
    fill_in 'Descrição', with: '250ml'
    fill_in 'Preço', with: '5.00'
    click_on 'Salvar'

    expect(current_path).to eq(establishment_beverage_path(beverage)) 
    expect(page).to have_content('Porções')
    expect(page).to have_content('250ml')
    expect(page).to have_content('5.00')
  end
end
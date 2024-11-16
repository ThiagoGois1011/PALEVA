require 'rails_helper'

describe 'Usuário edita uma porção' do
  it 'a partir da lista de pratos' do
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', close_hour: '18:00')
    dish = Dish.create!(name: 'Miojo', description: 'Da Nissin', establishment: establishment)
    Portion.create!(description: '1kg', price: 20.0, portionable: dish )

    login_as user
    visit establishment_dishes_path
    click_on 'Miojo'
    within('table') do
      click_on 'Editar'
    end
    fill_in 'Preço', with: '30.00'
    click_on 'Salvar'

    expect(current_path).to eq(establishment_dish_path(dish)) 
    expect(page).to have_content('Porções')
    expect(page).to have_content('1kg')
    expect(page).to have_content('30.00')
  end

  it 'a partir da lista de bebidas' do
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', close_hour: '18:00')
    beverage = Beverage.create!(name: 'Suco de Laranja', description: 'com laranja orgânica', establishment: establishment)
    Portion.create!(description: '250ml', price: 5.0, portionable: beverage )

    login_as user
    visit establishment_beverages_path
    click_on 'Ver detalhes'
    within('table') do
      click_on 'Editar'
    end
    fill_in 'Preço', with: '7.00'
    click_on 'Salvar'

    expect(current_path).to eq(establishment_beverage_path(beverage)) 
    expect(page).to have_content('Porções')
    expect(page).to have_content('250ml')
    expect(page).to have_content('7.00')
  end
end
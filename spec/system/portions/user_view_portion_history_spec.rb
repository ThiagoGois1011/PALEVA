require 'rails_helper'

describe 'Usuário vê o histórico de uma porção' do
  it 'depois de editar a porção do prato várias vezes' do
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', close_hour: '18:00')
    dish = Dish.create!(name: 'Miojo', description: 'Da Nissin', establishment: establishment)
    portion = Portion.create!(description: '1kg', price: 20.0, portionable: dish )

    login_as user
    visit establishment_dishes_path
    click_on 'Miojo'
    within('table') do
      click_on 'Editar'
    end
    fill_in 'Preço', with: '30.00'
    click_on 'Salvar'
    within('table') do
      click_on 'Editar'
    end
    fill_in 'Preço', with: '40.00'
    click_on 'Salvar'
    within('table') do
      click_on 'Editar'
    end
    fill_in 'Preço', with: '50.00'
    click_on 'Salvar'
    click_on 'Ver Histórico'

    expect(current_path).to eq(establishment_dish_portion_historicals_path(dish, portion)) 
    expect(page).to have_content('30.00')
    expect(page).to have_content('40.00')
  end

  it 'depois de editar a porção da bebida várias vezes' do
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', close_hour: '18:00')
    beverage = Beverage.create!(name: 'Suco de Laranja', description: 'com laranja orgânica', establishment: establishment)
    portion = Portion.create!(description: '250ml', price: 5.0, portionable: beverage )

    login_as user
    visit establishment_beverages_path
    click_on 'Ver detalhes'
    within('table') do
      click_on 'Editar'
    end
    fill_in 'Preço', with: '30.00'
    click_on 'Salvar'
    within('table') do
      click_on 'Editar'
    end
    fill_in 'Preço', with: '40.00'
    click_on 'Salvar'
    within('table') do
      click_on 'Editar'
    end
    fill_in 'Preço', with: '50.00'
    click_on 'Salvar'
    click_on 'Ver Histórico'

    expect(current_path).to eq(establishment_beverage_portion_historicals_path(beverage, portion)) 
    expect(page).to have_content('30.00')
    expect(page).to have_content('40.00')
  end
end
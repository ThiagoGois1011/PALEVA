require 'rails_helper'

describe 'Usuário edita uma porção' do
  it 'a partir da lista de pratos' do
    user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
    establishment = Establishment.create!(corporate_name: 'Distribuidora Alimentícia Ifood', brand_name: 'Ifood', 
                                          restration_number: CNPJ.generate, full_address: 'Av Presindete Cabral', 
                                          phone_number: '11981545874', email: 'contato@ifood.com', user: user)
    7.times do |day| 
      OpeningHour.create!(establishment: establishment, open_hour: '08:00', 
                          close_hour: '18:00', day_of_week: day)               
    end
    dish = Dish.create!(name: 'Miojo', description: 'Da Nissin', establishment: establishment)
    Portion.create!(description: '1kg', price: 20.0, portionable: dish )

    login_as user
    visit establishment_dishes_path(establishment.id)
    click_on 'Miojo'
    within('table') do
      click_on 'Editar'
    end
    fill_in 'Preço', with: '30.00'
    click_on 'Salvar'

    expect(current_path).to eq(establishment_dish_path(establishment_id: establishment.id, id: dish.id)) 
    expect(page).to have_content('Porções')
    expect(page).to have_content('1kg')
    expect(page).to have_content('30.00')
  end

  it 'a partir da lista de bebidas' do
    user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
    establishment = Establishment.create!(corporate_name: 'Distribuidora Alimentícia Ifood', brand_name: 'Ifood', 
                                          restration_number: CNPJ.generate, full_address: 'Av Presindete Cabral', 
                                          phone_number: '11981545874', email: 'contato@ifood.com', user: user)
    7.times do |day| 
      OpeningHour.create!(establishment: establishment, open_hour: '08:00', 
                          close_hour: '18:00', day_of_week: day)               
    end
    beverage = Beverage.create!(name: 'Suco de Laranja', description: 'com laranja orgânica', establishment: establishment)
    Portion.create!(description: '250ml', price: 5.0, portionable: beverage )

    login_as user
    visit establishment_beverages_path(establishment.id)
    click_on 'Suco de Laranja'
    within('table') do
      click_on 'Editar'
    end
    fill_in 'Preço', with: '7.00'
    click_on 'Salvar'

    expect(current_path).to eq(establishment_beverage_path(establishment_id: establishment.id, id: beverage.id)) 
    expect(page).to have_content('Porções')
    expect(page).to have_content('250ml')
    expect(page).to have_content('7.00')
  end
end
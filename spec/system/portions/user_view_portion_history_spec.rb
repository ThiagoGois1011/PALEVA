require 'rails_helper'

describe 'Usuário vê o histórico de uma porção' do
  it 'depois de editar a porção várias vezes' do
    user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
    establishment = Establishment.create!(corporate_name: 'Distribuidora Alimentícia Ifood', brand_name: 'Ifood', 
                                          restration_number: CNPJ.generate, full_address: 'Av Presindete Cabral', 
                                          phone_number: '11981545874', email: 'contato@ifood.com', user: user)
    7.times do |day| 
      OpeningHour.create!(establishment: establishment, open_hour: '08:00', 
                          close_hour: '18:00', day_of_week: day)               
    end
    dish = Dish.create!(name: 'Miojo', description: 'Da Nissin', establishment: establishment)
    portion = Portion.create!(description: '1kg', price: 20.0, portionable: dish )

    login_as user
    visit establishment_dishes_path(establishment.id)
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

    expect(current_path).to eq(establishment_dish_portion_historicals_path(establishment_id: establishment.id, dish_id: dish.id, portion_id: portion.id)) 
    expect(page).to have_content('30.00')
    expect(page).to have_content('40.00')
  end
end
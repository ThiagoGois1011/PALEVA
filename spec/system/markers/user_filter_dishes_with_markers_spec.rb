require 'rails_helper'

describe 'Usuario filtra os pratos' do
  it 'e vê os pratos marcados' do
    user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
    establishment = Establishment.create!(corporate_name: 'Distribuidora Alimentícia Ifood', brand_name: 'Ifood', 
                                          restration_number: CNPJ.generate, full_address: 'Av Presindete Cabral', 
                                          phone_number: '11981545874', email: 'contato@ifood.com', user: user)
    7.times do |day| 
      OpeningHour.create!(establishment: establishment, open_hour: '08:00', 
                          close_hour: '18:00', day_of_week: day)               
    end
    marker = Marker.create!(description: 'Alto em sódio')
    Dish.create!(name: 'Miojo', description: 'Da Nissin', establishment: establishment, marker_id: marker.id)

    login_as user
    visit establishment_dishes_path(establishment_id: establishment.id)
    select 'Alto em sódio', from: 'Filtrar pelo marcador'
    click_on 'Filtrar'

    expect(page).to have_content('Nome: Miojo')
    expect(page).to have_content('Descrição: Da Nissin')
    expect(page).to have_content('Alto em sódio')
  end

  it 'e vê somente os pratos marcados' do
    user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
    establishment = Establishment.create!(corporate_name: 'Distribuidora Alimentícia Ifood', brand_name: 'Ifood', 
                                          restration_number: CNPJ.generate, full_address: 'Av Presindete Cabral', 
                                          phone_number: '11981545874', email: 'contato@ifood.com', user: user)
    7.times do |day| 
      OpeningHour.create!(establishment: establishment, open_hour: '08:00', 
                          close_hour: '18:00', day_of_week: day)               
    end
    marker1 = Marker.create!(description: 'Alto em sódio')
    marker2 = Marker.create!(description: 'Alto em açucar adicional')
    marker3 = Marker.create!(description: 'Alto em gordura')
    Dish.create!(name: 'Miojo', description: 'Da Nissin', establishment: establishment, marker_id: marker1.id)
    Dish.create!(name: 'Brigadeiro', description: 'Feito com cacau natural', establishment: establishment, marker_id: marker2.id)
    Dish.create!(name: 'Mocotó', description: 'prato feito a partir das patas do boi', establishment: establishment, marker_id: marker3.id)

    login_as user
    visit establishment_dishes_path(establishment_id: establishment.id)
    select 'Alto em gordura', from: 'Filtrar pelo marcador'
    click_on 'Filtrar'
    
    expect(page).to have_content('Nome: Mocotó')
    expect(page).to have_content('Descrição: prato feito a partir das patas do boi')
    expect(page).to have_content('Alto em gordura')
    expect(page).not_to have_content('Nome: Miojo')
    expect(page).not_to have_content('Nome: Brigadeiro')
  end

end
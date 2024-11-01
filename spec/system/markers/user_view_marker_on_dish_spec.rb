require 'rails_helper'

describe 'Usuario vê um marcador' do
  it 'que já foi criado' do
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

    expect(page).to have_content('Nome: Miojo')
    expect(page).to have_content('Descrição: Da Nissin')
    expect(page).to have_content('Alto em sódio')
  end

  it 'que foi selecionado ao criar o prato' do
    user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
    establishment = Establishment.create!(corporate_name: 'Distribuidora Alimentícia Ifood', brand_name: 'Ifood', 
                                          restration_number: CNPJ.generate, full_address: 'Av Presindete Cabral', 
                                          phone_number: '11981545874', email: 'contato@ifood.com', user: user)
    7.times do |day| 
      OpeningHour.create!(establishment: establishment, open_hour: '08:00', 
                          close_hour: '18:00', day_of_week: day)               
    end
    marker = Marker.create!(description: 'Alto em sódio')

    login_as user
    visit establishment_dishes_path(establishment_id: establishment.id)
    click_on 'Cadastrar Prato'
    fill_in 'Nome', with: 'Miojo'
    fill_in 'Descrição', with: 'Feito da marca Nissin'
    fill_in 'Calorias', with: '400'
    select 'Alto em sódio', from: 'Marcador'
    attach_file 'Foto do prato', Rails.root.join('spec', 'fixtures', 'miojo.jpg')
    click_on 'Cadastrar Prato'

    expect(page).to have_content('Alto em sódio')
  end

  it 'que foi criado junto com o prato' do
    user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
    establishment = Establishment.create!(corporate_name: 'Distribuidora Alimentícia Ifood', brand_name: 'Ifood', 
                                          restration_number: CNPJ.generate, full_address: 'Av Presindete Cabral', 
                                          phone_number: '11981545874', email: 'contato@ifood.com', user: user)
    7.times do |day| 
      OpeningHour.create!(establishment: establishment, open_hour: '08:00', 
                          close_hour: '18:00', day_of_week: day)               
    end
    marker = Marker.create!(description: 'Alto em sódio')

    login_as user
    visit establishment_dishes_path(establishment_id: establishment.id)
    click_on 'Cadastrar Prato'
    fill_in 'Nome', with: 'Miojo'
    fill_in 'Descrição', with: 'Feito da marca Nissin'
    fill_in 'Calorias', with: '400'
    fill_in 'Criar Marcador', with: 'Alto em sódio'
    attach_file 'Foto do prato', Rails.root.join('spec', 'fixtures', 'miojo.jpg')
    click_on 'Cadastrar Prato'

    expect(page).to have_content('Alto em sódio')
  end

  it 'que foi selecionado ao editar o prato' do
    user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
    establishment = Establishment.create!(corporate_name: 'Distribuidora Alimentícia Ifood', brand_name: 'Ifood', 
                                          restration_number: CNPJ.generate, full_address: 'Av Presindete Cabral', 
                                          phone_number: '11981545874', email: 'contato@ifood.com', user: user)
    7.times do |day| 
      OpeningHour.create!(establishment: establishment, open_hour: '08:00', 
                          close_hour: '18:00', day_of_week: day)               
    end
    marker = Marker.create!(description: 'Alto em sódio')
    Dish.create!(name: 'Miojo', description: 'Da Nissin', establishment: establishment)

    login_as user
    visit establishment_dishes_path(establishment_id: establishment.id)
    click_on 'Miojo'
    click_on 'Editar'
    fill_in 'Nome', with: 'Miojo premium'
    fill_in 'Descrição', with: 'Feito da marca talharim'
    select 'Alto em sódio', from: 'Marcador'
    attach_file 'Foto do prato', Rails.root.join('spec', 'fixtures', 'miojo.jpg')
    click_on 'Salvar'

    expect(page).to have_content('Alto em sódio')
  end

  it 'que foi criado ao editar o prato' do
    user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
    establishment = Establishment.create!(corporate_name: 'Distribuidora Alimentícia Ifood', brand_name: 'Ifood', 
                                          restration_number: CNPJ.generate, full_address: 'Av Presindete Cabral', 
                                          phone_number: '11981545874', email: 'contato@ifood.com', user: user)
    7.times do |day| 
      OpeningHour.create!(establishment: establishment, open_hour: '08:00', 
                          close_hour: '18:00', day_of_week: day)               
    end
    marker = Marker.create!(description: 'Alto em sódio')
    Dish.create!(name: 'Miojo', description: 'Da Nissin', establishment: establishment)

    login_as user
    visit establishment_dishes_path(establishment_id: establishment.id)
    click_on 'Miojo'
    click_on 'Editar'
    fill_in 'Nome', with: 'Miojo premium'
    fill_in 'Descrição', with: 'Feito da marca talharim'
    fill_in 'Criar Marcador', with: 'Alto em sódio'
    attach_file 'Foto do prato', Rails.root.join('spec', 'fixtures', 'miojo.jpg')
    click_on 'Salvar'

    expect(page).to have_content('Alto em sódio')
  end

  it 'que foi criado previamente' do
    user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
    establishment = Establishment.create!(corporate_name: 'Distribuidora Alimentícia Ifood', brand_name: 'Ifood', 
                                          restration_number: CNPJ.generate, full_address: 'Av Presindete Cabral', 
                                          phone_number: '11981545874', email: 'contato@ifood.com', user: user)
    7.times do |day| 
      OpeningHour.create!(establishment: establishment, open_hour: '08:00', 
                          close_hour: '18:00', day_of_week: day)               
    end

    login_as user
    visit establishment_dishes_path(establishment_id: establishment.id)
    click_on 'Cadastrar Marcador'
    fill_in 'Descrição', with: 'Alto em sódio'
    click_on 'Salvar'
    click_on 'Cadastrar Prato'
    fill_in 'Nome', with: 'Miojo'
    fill_in 'Descrição', with: 'Feito da marca Nissin'
    fill_in 'Calorias', with: '400'
    select 'Alto em sódio', from: 'Marcador'
    attach_file 'Foto do prato', Rails.root.join('spec', 'fixtures', 'miojo.jpg')
    click_on 'Cadastrar Prato'

    expect(page).to have_content('Alto em sódio')
  end
end
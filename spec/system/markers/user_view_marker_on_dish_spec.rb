require 'rails_helper'

describe 'Usuario vê um marcador' do
  it 'que já foi criado' do
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', 
                                                          close_hour: '18:00')
    marker = Marker.create!(description: 'Alto em sódio')
    Dish.create!(name: 'Miojo', description: 'Da Nissin', establishment: establishment, marker_id: marker.id)

    login_as user
    visit establishment_dishes_path

    expect(page).to have_content('Nome: Miojo')
    expect(page).to have_content('Descrição: Da Nissin')
    expect(page).to have_content('Alto em sódio')
  end

  it 'que foi selecionado ao criar o prato' do
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', 
                                                          close_hour: '18:00')
    marker = Marker.create!(description: 'Alto em sódio')

    login_as user
    visit establishment_dishes_path
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
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', 
                                                          close_hour: '18:00')
    marker = Marker.create!(description: 'Alto em sódio')

    login_as user
    visit establishment_dishes_path
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
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', 
                                                          close_hour: '18:00')
    marker = Marker.create!(description: 'Alto em sódio')
    Dish.create!(name: 'Miojo', description: 'Da Nissin', establishment: establishment)

    login_as user
    visit establishment_dishes_path
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
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', 
                                                          close_hour: '18:00')
    marker = Marker.create!(description: 'Alto em sódio')
    Dish.create!(name: 'Miojo', description: 'Da Nissin', establishment: establishment)

    login_as user
    visit establishment_dishes_path
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
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', 
                                                          close_hour: '18:00')

    login_as user
    visit establishment_dishes_path
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
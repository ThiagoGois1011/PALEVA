require 'rails_helper'

describe 'Usuario vê um marcador' do
  it 'que já foi criado' do
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', 
                                                          close_hour: '18:00')
    marker = Marker.create!(description: 'Alto em sódio', establishment: establishment)
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
    marker = Marker.create!(description: 'Alto em sódio', establishment: establishment)

    login_as user
    visit establishment_dishes_path
    click_on 'Cadastrar Prato'
    fill_in 'Nome', with: 'Miojo'
    fill_in 'Descrição', with: 'Feito da marca Nissin'
    fill_in 'Calorias', with: '400'
    select 'Alto em sódio', from: 'Marcador'
    attach_file 'Foto do prato', Rails.root.join('spec', 'fixtures', 'miojo.jpg')
    click_on 'Salvar'

    expect(page).to have_content('Alto em sódio')
  end

  it 'que foi criado junto com o prato' do
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', 
                                                          close_hour: '18:00')
    marker = Marker.create!(description: 'Alto em sódio', establishment: establishment)

    login_as user
    visit establishment_dishes_path
    click_on 'Cadastrar Prato'
    fill_in 'Nome', with: 'Miojo'
    fill_in 'Descrição', with: 'Feito da marca Nissin'
    fill_in 'Calorias', with: '400'
    check 'Criar Marcador'
    fill_in 'Criar Marcador', with: 'Alto em sódio'
    attach_file 'Foto do prato', Rails.root.join('spec', 'fixtures', 'miojo.jpg')
    click_on 'Salvar'

    expect(page).to have_content('Alto em sódio')
  end

  it 'que foi criado vazio, junto com o prato' do
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', 
                                                          close_hour: '18:00')
    marker = Marker.create!(description: 'Alto em sódio', establishment: establishment)

    login_as user
    visit establishment_dishes_path
    click_on 'Cadastrar Prato'
    fill_in 'Nome', with: 'Miojo'
    fill_in 'Descrição', with: 'Feito da marca Nissin'
    fill_in 'Calorias', with: '400'
    check 'Criar Marcador'
    fill_in 'Criar Marcador', with: ''
    attach_file 'Foto do prato', Rails.root.join('spec', 'fixtures', 'miojo.jpg')
    click_on 'Salvar'

    expect(page).to have_content('Prato não cadastrado.')
    expect(page).to have_content('Marcador: Descrição não pode ficar em branco')
  end

  it 'que foi selecionado ao editar o prato' do
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', 
                                                          close_hour: '18:00')
    marker = Marker.create!(description: 'Alto em sódio', establishment: establishment)
    Dish.create!(name: 'Miojo', description: 'Da Nissin', establishment: establishment)

    login_as user
    visit establishment_dishes_path
    click_on 'Ver detalhes'
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
    marker = Marker.create!(description: 'Alto em sódio', establishment: establishment)
    Dish.create!(name: 'Miojo', description: 'Da Nissin', establishment: establishment)

    login_as user
    visit establishment_dishes_path
    click_on 'Ver detalhes'
    click_on 'Editar'
    fill_in 'Nome', with: 'Miojo premium'
    fill_in 'Descrição', with: 'Feito da marca talharim'
    check 'Criar Marcador'
    fill_in 'Criar Marcador', with: 'Alto em sódio'
    attach_file 'Foto do prato', Rails.root.join('spec', 'fixtures', 'miojo.jpg')
    click_on 'Salvar'

    expect(page).to have_content('Alto em sódio')
  end

  it 'que foi criado ao editar o prato' do
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', 
                                                          close_hour: '18:00')
    marker = Marker.create!(description: 'Alto em sódio', establishment: establishment)
    Dish.create!(name: 'Miojo', description: 'Da Nissin', establishment: establishment)

    login_as user
    visit establishment_dishes_path
    click_on 'Ver detalhes'
    click_on 'Editar'
    fill_in 'Nome', with: 'Miojo premium'
    fill_in 'Descrição', with: 'Feito da marca talharim'
    check 'Criar Marcador'
    fill_in 'Criar Marcador', with: ''
    attach_file 'Foto do prato', Rails.root.join('spec', 'fixtures', 'miojo.jpg')
    click_on 'Salvar'

    expect(page).to have_content('Prato não foi editado.')
    expect(page).to have_content('Marcador: Descrição não pode ficar em branco')
  end

  it 'e não vê o dos outros estabelecimento' do
    user_1 = create_owner(name: 'Andre')
    establishment_1 = create_establishment_and_opening_hour(user_1, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', 
                                                          close_hour: '18:00')
    user_2 = create_secondary_owner(name: 'Thiago')
    establishment_2 = create_secondary_establishment_and_opening_hour(user_2, corporate_name: 'Distribuidora MC Lanches', open_hour: '08:00', 
                                                          close_hour: '18:00')
    marker = Marker.create!(description: 'Alto em sódio', establishment: establishment_2)

    login_as user_1
    visit establishment_dishes_path

    expect(page).not_to have_content('Alto em sódio')
  end
end
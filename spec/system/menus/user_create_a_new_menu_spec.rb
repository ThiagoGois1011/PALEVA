require 'rails_helper'

describe 'Usuário cria um menu' do
  it 'com sucesso', js: true do
    user = create_user
    establishment = create_establishment_and_opening_hour(user)
    produtos = create_dishes_and_beverages(establishment)

    login_as user
    visit root_path
    click_on 'Cardápios'
    click_on 'Criar novo cardápio'
    fill_in 'Nome', with: 'Almoço'
    click_on 'Adicionar Produto'
    select 'Espaguete', from: 'produto_1'
    click_on 'Adicionar Produto'
    select 'Bife Grelhado', from: 'produto_2'
    click_on 'Adicionar Produto'
    select 'Coca Cola', from: 'produto_3'
    click_on 'Criar Cardápio'

    expect(current_path).to eq(establishment_menu_path(establishment.id, Menu.last.id))
    expect(page).to have_content('Almoço')
    expect(page).to have_content('Espaguete')
    expect(page).to have_content('Bife Grelhado')
    expect(page).to have_content('Coca Cola')
  end

  it 'com o campo nome vazio', js: true do
    user = create_user
    establishment = create_establishment_and_opening_hour(user)
    produtos = create_dishes_and_beverages(establishment)

    login_as user
    visit root_path
    click_on 'Cardápios'
    click_on 'Criar novo cardápio'
    fill_in 'Nome', with: ''
    click_on 'Adicionar Produto'
    select 'Espaguete', from: 'produto_1'
    click_on 'Adicionar Produto'
    select 'Bife Grelhado', from: 'produto_2'
    click_on 'Adicionar Produto'
    select 'Coca Cola', from: 'produto_3'
    click_on 'Criar Cardápio'

    expect(page).to have_content('Nome não pode ficar em branco')
  end

  it 'com o campo nome duplicado', js: true do
    user = create_user
    establishment = create_establishment_and_opening_hour(user)
    produtos = create_dishes_and_beverages(establishment)
    Menu.create!(name: 'Almoço', establishment: establishment)

    login_as user
    visit root_path
    click_on 'Cardápios'
    click_on 'Criar novo cardápio'
    fill_in 'Nome', with: 'Almoço'
    click_on 'Adicionar Produto'
    select 'Espaguete', from: 'produto_1'
    click_on 'Adicionar Produto'
    select 'Bife Grelhado', from: 'produto_2'
    click_on 'Adicionar Produto'
    select 'Coca Cola', from: 'produto_3'
    click_on 'Criar Cardápio'

    expect(page).to have_content('Nome já está em uso')
  end
end
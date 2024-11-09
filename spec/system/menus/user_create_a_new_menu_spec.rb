require 'rails_helper'

describe 'Usuário cria um menu' do
  it 'com sucesso', js: true do
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', close_hour: '18:00')
    create_dishes(establishment, dish_1: {name: 'Espaguete', description: 'Macarrão ao molho com pedaços de carne moída'},                 
                  dish_2: {name: 'Estrogonofe', description: 'Frango cortado em cubos ao molho'},
                  dish_3: {name: 'Bife Grelhado', description: 'Carne bovina grelhada'})
    create_beverages(establishment, beverage_1: {name: 'Suco de Laranja', description: 'Feito com laranjas orgânicas'},                 
                     beverage_2: {name: 'Coca Cola', description: 'Refrigerante'},
                     beverage_3: {name: 'Suco de Maracujá', description: 'Feito com \'maracujá do mato\''})

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

    expect(current_path).to eq(establishment_menu_path(Menu.last))
    expect(page).to have_content('Almoço')
    expect(page).to have_content('Espaguete')
    expect(page).to have_content('Bife Grelhado')
    expect(page).to have_content('Coca Cola')
  end

  it 'com o campo nome vazio', js: true do
   user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', close_hour: '18:00')
    create_dishes(establishment, dish_1: {name: 'Espaguete', description: 'Macarrão ao molho com pedaços de carne moída'},                 
                  dish_2: {name: 'Estrogonofe', description: 'Frango cortado em cubos ao molho'},
                  dish_3: {name: 'Bife Grelhado', description: 'Carne bovina grelhada'})
    create_beverages(establishment, beverage_1: {name: 'Suco de Laranja', description: 'Feito com laranjas orgânicas'},                 
                     beverage_2: {name: 'Coca Cola', description: 'Refrigerante'},
                     beverage_3: {name: 'Suco de Maracujá', description: 'Feito com \'maracujá do mato\''})

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
   user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', close_hour: '18:00')
    create_dishes(establishment, dish_1: {name: 'Espaguete', description: 'Macarrão ao molho com pedaços de carne moída'},                 
                  dish_2: {name: 'Estrogonofe', description: 'Frango cortado em cubos ao molho'},
                  dish_3: {name: 'Bife Grelhado', description: 'Carne bovina grelhada'})
    create_beverages(establishment, beverage_1: {name: 'Suco de Laranja', description: 'Feito com laranjas orgânicas'},                 
                     beverage_2: {name: 'Coca Cola', description: 'Refrigerante'},
                     beverage_3: {name: 'Suco de Maracujá', description: 'Feito com \'maracujá do mato\''})
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
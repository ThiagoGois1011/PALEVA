require 'rails_helper'

describe 'Usuário registra um pedido' do
  it 'com sucesso' do
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', close_hour: '18:00')
    products = create_dishes(establishment, dish_1: {name: 'Espaguete', description: 'Macarrão ao molho com pedaços de carne moída'},                 
                             dish_2: {name: 'Estrogonofe', description: 'Frango cortado em cubos ao molho'},
                             dish_3: {name: 'Bife Grelhado', description: 'Carne bovina grelhada'})
    products.concat create_beverages(establishment, beverage_1: {name: 'Suco de Laranja', description: 'Feito com laranjas orgânicas'},                 
                                 beverage_2: {name: 'Coca Cola', description: 'Refrigerante'},
                                 beverage_3: {name: 'Suco de Maracujá', description: 'Feito com \'maracujá do mato\''})
    menu = Menu.create!(name: 'Café da Manhã', establishment: establishment)
    products.each do |item|
      menu.menu_items.create(item: item)
    end

    login_as user
    visit establishment_menus_path
    click_on 'Café da Manhã'
    click_on 'Criar novo pedido'
    fill_in 'Nome', with: 'João Carlos'
    fill_in 'Telefone', with: '11988254174'
    fill_in 'Email', with: 'joão@email.com'
    fill_in 'CPF', with: '48393555094'
    click_on 'Criar pedido'

    user.reload
    expect(current_path).to eq(establishment_menu_path(menu))
    expect(page).to have_content('Pedido registrado com sucesso.')
    expect(user.current_order.name).to eq('João Carlos')
    expect(user.current_order.phone_number).to eq('11988254174')
    expect(user.current_order.email).to eq('joão@email.com')
    expect(user.current_order.cpf).to eq('48393555094')
    expect(page).to have_content(user.current_order.name)
  end

  it 'com campos inválidos' do
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', close_hour: '18:00')
    products = create_dishes(establishment, dish_1: {name: 'Espaguete', description: 'Macarrão ao molho com pedaços de carne moída'},                 
                               dish_2: {name: 'Estrogonofe', description: 'Frango cortado em cubos ao molho'},
                               dish_3: {name: 'Bife Grelhado', description: 'Carne bovina grelhada'})
    products.concat create_beverages(establishment, beverage_1: {name: 'Suco de Laranja', description: 'Feito com laranjas orgânicas'},                 
                                   beverage_2: {name: 'Coca Cola', description: 'Refrigerante'},
                                   beverage_3: {name: 'Suco de Maracujá', description: 'Feito com \'maracujá do mato\''})
    menu = Menu.create!(name: 'Café da Manhã', establishment: establishment)
    products.each do |item|
      menu.menu_items.create(item: item)
    end

    login_as user
    visit establishment_menus_path
    click_on 'Café da Manhã'
    click_on 'Criar novo pedido'
    fill_in 'Nome', with: ''
    fill_in 'Telefone', with: ''
    fill_in 'Email', with: ''
    fill_in 'CPF', with: '99999999'
    click_on 'Criar pedido'

    expect(page).to have_content('Pedido não registrado')
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('CPF inválido')
    expect(page).to have_content('Pedido deve ter um telefone ou email')
  end

  it 'ao apertar para adicionar ao pedido sem ter criado um pedido' do
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', close_hour: '18:00')
    products = create_dishes_with_portions(establishment, dish_1: {name: 'Espaguete', description: 'Macarrão ao molho com pedaços de carne moída'},                 
                             dish_2: {name: 'Estrogonofe', description: 'Frango cortado em cubos ao molho'},
                             dish_3: {name: 'Bife Grelhado', description: 'Carne bovina grelhada'})
    products.concat create_beverages_with_portions(establishment, beverage_1: {name: 'Suco de Laranja', description: 'Feito com laranjas orgânicas'},                 
                                 beverage_2: {name: 'Coca Cola', description: 'Refrigerante'},
                                 beverage_3: {name: 'Suco de Maracujá', description: 'Feito com \'maracujá do mato\''})
    menu = Menu.create!(name: 'Café da Manhã', establishment: establishment)
    products.each do |item|
      menu.menu_items.create(item: item)
    end

    login_as user
    visit establishment_menus_path
    click_on 'Café da Manhã'
    within('#dish_1') do
      click_on 'Adicionar ao pedido'
    end
    fill_in 'Nome', with: 'João Carlos'
    fill_in 'Telefone', with: '11988254174'
    fill_in 'Email', with: 'joão@email.com'
    fill_in 'CPF', with: '48393555094'
    click_on 'Criar pedido'

    user.reload
    expect(current_path).to eq(establishment_menu_path(menu))
    expect(page).to have_content('Pedido registrado com sucesso.')
    expect(user.current_order.name).to eq('João Carlos')
    expect(user.current_order.phone_number).to eq('11988254174')
    expect(user.current_order.email).to eq('joão@email.com')
    expect(user.current_order.cpf).to eq('48393555094')
    expect(page).to have_content(user.current_order.name)
  end

  it 'pela segunda vez' do
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', close_hour: '18:00')
    products = create_dishes(establishment, dish_1: {name: 'Espaguete', description: 'Macarrão ao molho com pedaços de carne moída'},                 
                             dish_2: {name: 'Estrogonofe', description: 'Frango cortado em cubos ao molho'},
                             dish_3: {name: 'Bife Grelhado', description: 'Carne bovina grelhada'})
    products.concat create_beverages(establishment, beverage_1: {name: 'Suco de Laranja', description: 'Feito com laranjas orgânicas'},                 
                                 beverage_2: {name: 'Coca Cola', description: 'Refrigerante'},
                                 beverage_3: {name: 'Suco de Maracujá', description: 'Feito com \'maracujá do mato\''})
    menu = Menu.create!(name: 'Café da Manhã', establishment: establishment)
    products.each do |item|
      menu.menu_items.create(item: item)
    end

    login_as user
    visit establishment_menus_path
    click_on 'Café da Manhã'
    click_on 'Criar novo pedido'
    fill_in 'Nome', with: 'João Carlos'
    fill_in 'Telefone', with: '11988254174'
    fill_in 'Email', with: 'joão@email.com'
    fill_in 'CPF', with: '48393555094'
    click_on 'Criar pedido'
    click_on 'Criar novo pedido'
    fill_in 'Nome', with: 'Thiago Andrade'
    fill_in 'Telefone', with: '74988254718'
    fill_in 'Email', with: 'thiago@email.com'
    fill_in 'CPF', with: '86601882097'
    click_on 'Criar pedido'

    user.reload
    expect(current_path).to eq(establishment_menu_path(menu))
    expect(page).to have_content('Pedido registrado com sucesso.')
    expect(user.current_order.name).to eq('Thiago Andrade')
    expect(user.current_order.phone_number).to eq('74988254718')
    expect(user.current_order.email).to eq('thiago@email.com')
    expect(user.current_order.cpf).to eq('86601882097')
    expect(page).to have_content(user.current_order.name)
  end

  it 'e mais tarde seleciona esse mesmo pedido' do
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', close_hour: '18:00')
    products = create_dishes(establishment, dish_1: {name: 'Espaguete', description: 'Macarrão ao molho com pedaços de carne moída'},                 
                             dish_2: {name: 'Estrogonofe', description: 'Frango cortado em cubos ao molho'},
                             dish_3: {name: 'Bife Grelhado', description: 'Carne bovina grelhada'})
    products.concat create_beverages(establishment, beverage_1: {name: 'Suco de Laranja', description: 'Feito com laranjas orgânicas'},                 
                                 beverage_2: {name: 'Coca Cola', description: 'Refrigerante'},
                                 beverage_3: {name: 'Suco de Maracujá', description: 'Feito com \'maracujá do mato\''})
    menu = Menu.create!(name: 'Café da Manhã', establishment: establishment)
    products.each do |item|
      menu.menu_items.create(item: item)
    end
    order = Order.create!(name: 'João Carlos', cpf: '48393555094', phone_number: '11988254174', email: 'joão@email.com', establishment: establishment)


    login_as user
    visit establishment_menus_path
    click_on 'Café da Manhã'
    click_on 'Continuar com pedido em aberto'
    select 'João Carlos', from: 'Lista de pedidos'
    click_on 'Salvar'

    user.reload
    expect(current_path).to eq(establishment_menu_path(menu))
    expect(page).to have_content('Pedido selecionado com sucesso.')
    expect(user.current_order.name).to eq('João Carlos')
    expect(user.current_order.phone_number).to eq('11988254174')
    expect(user.current_order.email).to eq('joão@email.com')
    expect(user.current_order.cpf).to eq('48393555094')
    expect(page).to have_content(user.current_order.name)
  end

  it 'inválido, depois corrige e faz com sucesso' do
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', close_hour: '18:00')
    products = create_dishes(establishment, dish_1: {name: 'Espaguete', description: 'Macarrão ao molho com pedaços de carne moída'},                 
                             dish_2: {name: 'Estrogonofe', description: 'Frango cortado em cubos ao molho'},
                             dish_3: {name: 'Bife Grelhado', description: 'Carne bovina grelhada'})
    products.concat create_beverages(establishment, beverage_1: {name: 'Suco de Laranja', description: 'Feito com laranjas orgânicas'},                 
                                 beverage_2: {name: 'Coca Cola', description: 'Refrigerante'},
                                 beverage_3: {name: 'Suco de Maracujá', description: 'Feito com \'maracujá do mato\''})
    menu = Menu.create!(name: 'Café da Manhã', establishment: establishment)
    products.each do |item|
      menu.menu_items.create(item: item)
    end

    login_as user
    visit establishment_menus_path
    click_on 'Café da Manhã'
    click_on 'Criar novo pedido'
    fill_in 'Nome', with: ''
    fill_in 'Telefone', with: ''
    fill_in 'Email', with: ''
    fill_in 'CPF', with: ''
    click_on 'Criar pedido'
    fill_in 'Nome', with: 'João Carlos'
    fill_in 'Telefone', with: '11988254174'
    fill_in 'Email', with: 'joão@email.com'
    fill_in 'CPF', with: '48393555094'
    click_on 'Criar pedido'
    
    user.reload
    expect(current_path).to eq(establishment_menu_path(menu))
    expect(page).to have_content('Pedido registrado com sucesso.')
    expect(page).to have_content(user.current_order.name)
  end
end
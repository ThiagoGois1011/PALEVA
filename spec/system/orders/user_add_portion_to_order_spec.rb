require 'rails_helper'

describe 'Usuário adiciona porção após criar pedido' do 
  it 'e adiciona uma porção com observação' do
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', close_hour: '18:00')
    employee = create_employee(establishment, name: 'João')
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
    order = Order.create!(name: 'João Carlos', cpf: '48393555094', phone_number: '11988254174', email: 'joão@email.com', establishment: establishment, user: employee)

    login_as employee
    visit establishment_menu_path(menu)
    within('#dish_3') do
      click_on 'Adicionar ao pedido'
    end
    fill_in 'Observação', with: 'Sem cebola'
    click_on 'Adicionar'

    expect(page).to have_content('Porção adicionado ao pedido.')
    expect(order.order_items[0].observation).to eq('Sem cebola')


  end
  it 'e vai para a tela de confirmar pedido' do
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', close_hour: '18:00')
    products = create_dishes(establishment, dish_1: {name: 'Espaguete', description: 'Macarrão ao molho com pedaços de carne moída'},                 
                            dish_2: {name: 'Estrogonofe', description: 'Frango cortado em cubos ao molho'},
                            dish_3: {name: 'Bife Grelhado', description: 'Carne bovina grelhada'})
    products.concat create_beverages(establishment, beverage_1: {name: 'Suco de Laranja', description: 'Feito com laranjas orgânicas'},                 
                                 beverage_2: {name: 'Coca Cola', description: 'Refrigerante'},
                                 beverage_3: {name: 'Suco de Maracujá', description: 'Feito com \'maracujá do mato\''})
    products[0].portions.create(description: '500g', price: 15)
    products[2].portions.create(description: '300g', price: 20)
    products[3].portions.create(description: '1l', price: 8.5)
    menu = Menu.create!(name: 'Café da Manhã', establishment: establishment)
    products.each do |item|
      menu.menu_items.create(item: item)
    end
    order = Order.create!(name: 'João Carlos', cpf: '48393555094', phone_number: '11988254174', email: 'joão@email.com', establishment: establishment, user: user)

    login_as user
    visit establishment_menu_path(menu)
    within('#dish_1') do
      click_on 'Adicionar ao pedido'
    end
    click_on 'Adicionar'
    within('#dish_3') do
      click_on 'Adicionar ao pedido'
    end
    fill_in 'Observação', with: 'Sem cebola'
    click_on 'Adicionar'
    within('#beverage_1') do
      click_on 'Adicionar ao pedido'
    end
    click_on 'Adicionar'
    click_on 'Finalizar pedido'

    expect(current_path).to eq(confirm_order_establishment_orders_path)
    expect(page).to have_content('Confirmar Pedido')
    expect(page).to have_content('Nome')
    expect(page).to have_content('Descrição')
    expect(page).to have_content('Preço')
    expect(page).to have_content('Observação')
    expect(page).to have_content('Espaguete')
    expect(page).to have_content('500g')
    expect(page).to have_content('15,00')
    expect(page).to have_content('Bife Grelhado')
    expect(page).to have_content('300g')
    expect(page).to have_content('20,00')
    expect(page).to have_content('Sem cebola')
    expect(page).to have_content('Suco de Laranja')
    expect(page).to have_content('1l')
    expect(page).to have_content('8,50')
    expect(page).to have_content('Total a pagar: R$ 43,50')
  end

  it 'e finaliza pedido' do
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
    order = Order.create!(name: 'João Carlos', cpf: '48393555094', phone_number: '11988254174', email: 'joão@email.com', establishment: establishment, user: user)

    login_as user
    visit establishment_menu_path(menu)
    within('#dish_1') do
      click_on 'Adicionar ao pedido'
    end
    click_on 'Adicionar'
    within('#dish_3') do
      click_on 'Adicionar ao pedido'
    end
    click_on 'Adicionar'
    within('#beverage_1') do
      click_on 'Adicionar ao pedido'
    end
    click_on 'Adicionar'
    click_on 'Finalizar pedido'
    click_on 'Finalizar'

    user.reload
    order.reload
    expect(current_path).to eq(establishment_menus_path)
    expect(user.current_order).to be_nil
    expect(order.status).to eq('waiting_for_confirmation')
    expect(order.portions[0].description).to eq('Porção Espaguete')
    expect(order.portions[1].description).to eq('Porção Bife Grelhado')
    expect(order.portions[2].description).to eq('Porção Suco de Laranja')
  end

  it 'e vê uma porção com desconto' do
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', close_hour: '18:00')
    products = create_dishes(establishment, dish_1: {name: 'Espaguete', description: 'Macarrão ao molho com pedaços de carne moída'},                 
                            dish_2: {name: 'Estrogonofe', description: 'Frango cortado em cubos ao molho'},
                            dish_3: {name: 'Bife Grelhado', description: 'Carne bovina grelhada'})
    products.concat create_beverages(establishment, beverage_1: {name: 'Suco de Laranja', description: 'Feito com laranjas orgânicas'},                 
                                 beverage_2: {name: 'Coca Cola', description: 'Refrigerante'},
                                 beverage_3: {name: 'Suco de Maracujá', description: 'Feito com \'maracujá do mato\''})
    portion_to_discount = products[0].portions.create(description: '500g', price: 15)
    products[2].portions.create(description: '300g', price: 20)
    products[3].portions.create(description: '1l', price: 8.5)
    menu = Menu.create!(name: 'Café da Manhã', establishment: establishment)
    products.each do |item|
      menu.menu_items.create(item: item)
    end
    order = Order.create!(name: 'João Carlos', cpf: '48393555094', phone_number: '11988254174', email: 'joão@email.com', establishment: establishment, user: user)
    discount = Discount.create!(establishment: establishment, name: 'Semana do Espaguete', start_date: Date.today , end_date: 7.days.from_now.to_date,
                            discount_percentage: 50)
    discount.portion_discounts.create(portion_id: portion_to_discount.id)
        
    login_as user
    visit establishment_menu_path(menu)
    within('#dish_1') do
      click_on 'Adicionar ao pedido'
    end
    click_on 'Adicionar'
    within('#dish_3') do
      click_on 'Adicionar ao pedido'
    end
    fill_in 'Observação', with: 'Sem cebola'
    click_on 'Adicionar'
    within('#beverage_1') do
      click_on 'Adicionar ao pedido'
    end
    click_on 'Adicionar'
    click_on 'Finalizar pedido'

    expect(current_path).to eq(confirm_order_establishment_orders_path)
    expect(page).to have_content('Confirmar Pedido')
    expect(page).to have_content('Nome')
    expect(page).to have_content('Descrição')
    expect(page).to have_content('Preço')
    expect(page).to have_content('Preço com Desconto')
    expect(page).to have_content('Observação')
    expect(page).to have_content('Espaguete')
    expect(page).to have_content('500g')
    expect(page).to have_content('15,00')
    expect(page).to have_content('7,50')
    expect(page).to have_content('Bife Grelhado')
    expect(page).to have_content('300g')
    expect(page).to have_content('20,00')
    expect(page).to have_content('Sem cebola')
    expect(page).to have_content('Suco de Laranja')
    expect(page).to have_content('1l')
    expect(page).to have_content('8,50')
    expect(page).to have_content('Total a pagar: R$ 43,50')
    expect(page).to have_content('Total a pagar com desconto: R$ 36,00')
  end

  it 'e vê uma porção com mais de um desconto e prevalece o maior' do
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', close_hour: '18:00')
    products = create_dishes(establishment, dish_1: {name: 'Espaguete', description: 'Macarrão ao molho com pedaços de carne moída'},                 
                            dish_2: {name: 'Estrogonofe', description: 'Frango cortado em cubos ao molho'},
                            dish_3: {name: 'Bife Grelhado', description: 'Carne bovina grelhada'})
    products.concat create_beverages(establishment, beverage_1: {name: 'Suco de Laranja', description: 'Feito com laranjas orgânicas'},                 
                                 beverage_2: {name: 'Coca Cola', description: 'Refrigerante'},
                                 beverage_3: {name: 'Suco de Maracujá', description: 'Feito com \'maracujá do mato\''})
    portion_to_discount = products[0].portions.create(description: '500g', price: 15)
    products[2].portions.create(description: '300g', price: 20)
    products[3].portions.create(description: '1l', price: 8.5)
    menu = Menu.create!(name: 'Café da Manhã', establishment: establishment)
    products.each do |item|
      menu.menu_items.create(item: item)
    end
    order = Order.create!(name: 'João Carlos', cpf: '48393555094', phone_number: '11988254174', email: 'joão@email.com', establishment: establishment, user: user)
    discount_1 = Discount.create!(establishment: establishment, name: 'Semana do Espaguete', start_date: Date.today , end_date: 7.days.from_now.to_date,
                                  discount_percentage: 70)
    discount_1.portion_discounts.create(portion_id: portion_to_discount.id)
    discount_2 = Discount.create!(establishment: establishment, name: 'Semana do Macarrão', start_date: Date.today , end_date: 7.days.from_now.to_date,
                                  discount_percentage: 10)
    discount_2.portion_discounts.create(portion_id: portion_to_discount.id)
        
    login_as user
    visit establishment_menu_path(menu)
    within('#dish_1') do
      click_on 'Adicionar ao pedido'
    end
    click_on 'Adicionar'
    within('#dish_3') do
      click_on 'Adicionar ao pedido'
    end
    fill_in 'Observação', with: 'Sem cebola'
    click_on 'Adicionar'
    within('#beverage_1') do
      click_on 'Adicionar ao pedido'
    end
    click_on 'Adicionar'
    click_on 'Finalizar pedido'

    expect(page).to have_content('Espaguete')
    expect(page).to have_content('500g')
    expect(page).to have_content('15,00')
    expect(page).to have_content('4,50')
    expect(page).to have_content('Total a pagar: R$ 43,50')
    expect(page).to have_content('Total a pagar com desconto: R$ 33,00')
  end

  it 'e vê mais de uma porção com desconto' do
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', close_hour: '18:00')
    products = create_dishes(establishment, dish_1: {name: 'Espaguete', description: 'Macarrão ao molho com pedaços de carne moída'},                 
                            dish_2: {name: 'Estrogonofe', description: 'Frango cortado em cubos ao molho'},
                            dish_3: {name: 'Bife Grelhado', description: 'Carne bovina grelhada'})
    products.concat create_beverages(establishment, beverage_1: {name: 'Suco de Laranja', description: 'Feito com laranjas orgânicas'},                 
                                 beverage_2: {name: 'Coca Cola', description: 'Refrigerante'},
                                 beverage_3: {name: 'Suco de Maracujá', description: 'Feito com \'maracujá do mato\''})
    portion_to_discount_1 = products[0].portions.create(description: '500g', price: 15)
    portion_to_discount_2 = products[2].portions.create(description: '300g', price: 20)
    products[3].portions.create(description: '1l', price: 8.5)
    menu = Menu.create!(name: 'Café da Manhã', establishment: establishment)
    products.each do |item|
      menu.menu_items.create(item: item)
    end
    order = Order.create!(name: 'João Carlos', cpf: '48393555094', phone_number: '11988254174', email: 'joão@email.com', establishment: establishment, user: user)
    discount_1 = Discount.create!(establishment: establishment, name: 'Semana do Espaguete', start_date: Date.today , end_date: 7.days.from_now.to_date,
                                  discount_percentage: 40)
    discount_1.portion_discounts.create(portion_id: portion_to_discount_1.id)
    discount_2 = Discount.create!(establishment: establishment, name: 'Semana do Bife', start_date: Date.today , end_date: 7.days.from_now.to_date,
                                  discount_percentage: 40)
    discount_2.portion_discounts.create(portion_id: portion_to_discount_2.id)
        
    login_as user
    visit establishment_menu_path(menu)
    within('#dish_1') do
      click_on 'Adicionar ao pedido'
    end
    click_on 'Adicionar'
    within('#dish_3') do
      click_on 'Adicionar ao pedido'
    end
    fill_in 'Observação', with: 'Sem cebola'
    click_on 'Adicionar'
    within('#beverage_1') do
      click_on 'Adicionar ao pedido'
    end
    click_on 'Adicionar'
    click_on 'Finalizar pedido'

    expect(current_path).to eq(confirm_order_establishment_orders_path)
    expect(page).to have_content('Confirmar Pedido')
    expect(page).to have_content('Nome')
    expect(page).to have_content('Descrição')
    expect(page).to have_content('Preço')
    expect(page).to have_content('Preço com Desconto')
    expect(page).to have_content('Observação')
    expect(page).to have_content('Espaguete')
    expect(page).to have_content('500g')
    expect(page).to have_content('15,00')
    expect(page).to have_content('9,00')
    expect(page).to have_content('Bife Grelhado')
    expect(page).to have_content('300g')
    expect(page).to have_content('20,00')
    expect(page).to have_content('12,00')
    expect(page).to have_content('Sem cebola')
    expect(page).to have_content('Suco de Laranja')
    expect(page).to have_content('1l')
    expect(page).to have_content('8,50')
    expect(page).to have_content('Total a pagar: R$ 43,50')
    expect(page).to have_content('Total a pagar com desconto: R$ 29,50')
  end

  it 'e vê o preço das porções após o desconto chegar ao limite' do
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', close_hour: '18:00')
    products = create_dishes(establishment, dish_1: {name: 'Espaguete', description: 'Macarrão ao molho com pedaços de carne moída'},                 
                            dish_2: {name: 'Estrogonofe', description: 'Frango cortado em cubos ao molho'},
                            dish_3: {name: 'Bife Grelhado', description: 'Carne bovina grelhada'})
    products.concat create_beverages(establishment, beverage_1: {name: 'Suco de Laranja', description: 'Feito com laranjas orgânicas'},                 
                                 beverage_2: {name: 'Coca Cola', description: 'Refrigerante'},
                                 beverage_3: {name: 'Suco de Maracujá', description: 'Feito com \'maracujá do mato\''})
    portion_to_discount = products[0].portions.create(description: '500g', price: 15)
    products[2].portions.create(description: '300g', price: 20)
    products[3].portions.create(description: '1l', price: 8.5)
    menu = Menu.create!(name: 'Café da Manhã', establishment: establishment)
    products.each do |item|
      menu.menu_items.create(item: item)
    end
    order_1 = Order.create!(name: 'João Carlos', cpf: '48393555094', phone_number: '11988254174', email: 'joão@email.com', 
                          establishment: establishment, user: user)
    order_2 = Order.create!(name: 'Thiago', phone_number: '88988994174', 
                          establishment: establishment)
    discount_1 = Discount.create!(establishment: establishment, name: 'Semana do Espaguete', start_date: Date.today , end_date: 7.days.from_now.to_date,
                                  discount_percentage: 40, limit: 1)
    discount_1.portion_discounts.create(portion_id: portion_to_discount.id)
    
    login_as user
    visit establishment_menu_path(menu)
    within('#dish_1') do
      click_on 'Adicionar ao pedido'
    end
    click_on 'Adicionar'
    click_on 'Finalizar pedido'
    click_on 'Finalizar'
    visit establishment_menu_path(menu)
    click_on 'Continuar com pedido em aberto'
    select 'Thiago', from: 'Lista de pedidos'
    click_on 'Salvar'
    within('#dish_1') do
    click_on 'Adicionar ao pedido'
    end
    click_on 'Adicionar'
    within('#dish_3') do
    click_on 'Adicionar ao pedido'
    end
    click_on 'Adicionar'
    click_on 'Finalizar pedido'

    expect(page).to have_content('Espaguete')
    expect(page).to have_content('500g')
    expect(page).to have_content('15,00')
    expect(page).to have_content('0,00')
    expect(page).to have_content('Total a pagar: R$ 35,00')
    expect(page).to have_content('Total a pagar com desconto: R$ 35,00')
  end
end
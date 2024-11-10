require 'rails_helper'

describe 'Usuário adiciona pedidos após criar pedido' do 
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
    expect(page).to have_content('Espaguete')
    expect(page).to have_content('500g')
    expect(page).to have_content('15,00')
    expect(page).to have_content('Bife Grelhado')
    expect(page).to have_content('300g')
    expect(page).to have_content('20,00')
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
end
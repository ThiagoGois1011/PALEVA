require 'rails_helper'

describe 'Usuário adiciona pedidos após criar pedido' do 
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
require 'rails_helper'

describe 'Usuário adiciona pedidos após criar pedido' do 
  it 'e finaliza pedido' do
    user = create_user
    establishment = create_establishment_and_opening_hour(user)
    products = create_dishes_and_beverages_with_portions(establishment)
    menu = Menu.create!(name: 'Café da Manhã', establishment: establishment)
    products.each do |item|
      menu.menu_items.create(item: item)
    end
    order = Order.create!(name: 'João Carlos', cpf: '48393555094', phone_number: '11988254174', email: 'joão@email.com', establishment: establishment, user: user)

    login_as user
    visit establishment_menu_path(establishment, menu)
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
    expect(current_path).to eq(establishment_menus_path(establishment))
    expect(user.current_order).to be_nil
    expect(order.status).to eq('waiting_for_confirmation')
    expect(order.portions[0].description).to eq('Porção Espaguete')
    expect(order.portions[1].description).to eq('Porção Bife Grelhado')
    expect(order.portions[2].description).to eq('Porção Suco de Laranja')
  end
end
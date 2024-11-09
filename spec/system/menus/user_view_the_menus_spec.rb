require 'rails_helper'

describe 'Usuário vê os cardápios' do
  it 'clicando no link para cardápio' do
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', close_hour: '18:00')
    Menu.create!(name: 'Café da Manhã', establishment: establishment)
    Menu.create!(name: 'Almoço', establishment: establishment)

    login_as user
    visit root_path
    click_on 'Cardápios'

    expect(current_path).to eq(establishment_menus_path)
    expect(page).to have_content('Café da Manhã')
    expect(page).to have_content('Almoço')
  end

  it 'após fazer o login' do
    user = create_owner(name: 'Andre', email: 'andre@email.com' , password: 'password1234')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood')
    Menu.create!(name: 'Café da Manhã', establishment: establishment)
    Menu.create!(name: 'Almoço', establishment: establishment)

    visit new_user_session_path
    fill_in 'Email', with: 'andre@email.com'
    fill_in 'Senha', with: 'password1234'
    within('form') do
      click_on 'Entrar'
    end

    expect(current_path).to eq(establishment_menus_path)
    expect(page).to have_content('Café da Manhã')
    expect(page).to have_content('Almoço')
  end

  context 'e entra em um cardápio' do
    it 'com os pratos e bebidas sem porções' do
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
  
      expect(current_path).to eq(establishment_menu_path(menu))
      expect(page).to have_content(products[0].name)
      expect(page).to have_content(products[1].name)
      expect(page).to have_content(products[3].name)
      expect(page).to have_content(products[5].name)
      expect(page).to have_content('Não tem porções.')
    end

    it 'com os pratos e bebidas com porções' do
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
  
      expect(page).to have_content(products[0].portions.first.description)
      expect(page).to have_content(products[0].portions.first.price)
      expect(page).to have_content(products[1].portions.first.description)
      expect(page).to have_content(products[1].portions.first.price)
      expect(page).to have_content(products[3].portions.first.description)
      expect(page).to have_content(products[3].portions.first.price)
      expect(page).to have_content(products[5].portions.first.description)
      expect(page).to have_content(products[5].portions.first.price)
    end

    it 'e não vê os pratos desativados' do
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
      products[1].disabled!
      
      login_as user
      visit establishment_menus_path
      click_on 'Café da Manhã'
  
      expect(page).to have_content(products[0].name)
      expect(page).not_to have_content(products[1].name)
      expect(page).to have_content(products[2].name)
    end
  end
end

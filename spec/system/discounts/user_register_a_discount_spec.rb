require 'rails_helper'

describe 'Usuário cadastra um desconto' do
  it 'com sucesso', js: true do
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', 
                                                          close_hour: '18:00')
    products= create_dishes(establishment, dish_1: {name: 'Miojo', description: 'Miojo comum'},                 
                  dish_2: {name: 'Miojo Talharim', description: 'Miojo talharim feito ao molho branco'})
    products[0].portions.create(description: '250g', price: 7)
    products[0].portions.create(description: '500g', price: 13)
    products[1].portions.create(description: '300g', price: 20)
    data_inicio = Date.today
    data_final = 7.days.from_now.to_date
   
    login_as user
    visit establishment_menus_path
    click_on 'Descontos'
    click_on 'Cadastrar novo desconto'
    fill_in 'Nome', with: 'Miojão Premium'
    fill_in 'Porcentagem do Desconto', with: '10'
    fill_in 'Data de Início', with: data_inicio
    fill_in 'Data Final', with: data_final
    save_page
    fill_in 'Limite de Pedidos', with: '3'
    click_on 'Adicionar Produto'
    select 'Miojo - 250g', from: 'product_1'
    click_on 'Adicionar Produto'
    select 'Miojo - 500g', from: 'product_2'
    click_on 'Adicionar Produto'
    select 'Miojo Talharim - 300g', from: 'product_3'
    click_on 'Salvar'

    expect(page).to have_content('Desconto cadastrado com sucesso.')
    expect(current_path).to eq(establishment_discount_path(Discount.first))
    expect(page).to have_content('Nome: Miojão Premium')
    expect(page).to have_content('Desconto: 10%')
    expect(page).to have_content('Data de Início: ' + data_inicio.strftime("%d/%m/%Y"))
    expect(page).to have_content('Data Final: ' + data_final.strftime("%d/%m/%Y"))
    expect(page).to have_content('Limite de Pedidos: 3')
    expect(page).to have_content('Validade: Válido')
    expect(page).to have_content('Porções')
    expect(page).to have_content('Miojo')
    expect(page).to have_content('250g')
    expect(page).to have_content('R$ 7,00')
    expect(page).to have_content('Miojo')
    expect(page).to have_content('500g')
    expect(page).to have_content('R$ 13,00')
    expect(page).to have_content('Miojo Talharim')
    expect(page).to have_content('300g')
    expect(page).to have_content('R$ 20,00')
  end
end
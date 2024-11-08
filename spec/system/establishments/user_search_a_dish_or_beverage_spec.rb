require 'rails_helper'

describe 'Usuário pesquisa um prato ou bebida' do

  it 'mas precisa ter um estabelecimento' do
    user = create_owner(name: 'Andre')
    
    login_as(user)
    visit root_path
    fill_in 'Pesquisar', with: 'Miojo'
    click_on 'Pesquisar'

    expect(current_path).to eq(new_establishment_path)
    expect(page).to have_content('Cadastrar Estabelecimento')
  end

  it 'e encontra um prato' do
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', 
                                                          close_hour: '18:00')
    Dish.create!(name: 'Miojo', description: 'Da Nissin', calorie: 400, establishment: establishment)   
    Dish.create!(name: 'Crepioca', description: 'Feita com ovo e tapioca', calorie: 800, establishment: establishment)   
    Beverage.create!(name: 'Suco de Laranja', description: 'Feito com laranjas orgânicas', establishment: establishment)
    Beverage.create!(name: 'Suco de Goiaba', description: 'Feito com goiabas orgânicas', establishment: establishment)

    login_as user
    visit root_path
    fill_in 'Pesquisar', with: 'Miojo'
    click_on 'Pesquisar'

    expect(current_path).to eq(search_establishments_path)
    expect(page).to have_content('Nome: Miojo')
    expect(page).to have_content('Descrição: Da Nissin')
    expect(page).not_to have_content('Nome: Crepioca')
    expect(page).not_to have_content('Descrição: Feita com ovo e tapioca')
    expect(page).not_to have_content('Nome: Suco de Laranja')
    expect(page).not_to have_content('Nome: Suco de Goiaba')
  end

  it 'e encontra uma bebida' do
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', 
                                                          close_hour: '18:00')
    Dish.create!(name: 'Miojo', description: 'Da Nissin', calorie: 400, establishment: establishment)   
    Dish.create!(name: 'Crepioca', description: 'Feita com ovo e tapioca', calorie: 800, establishment: establishment)   
    Beverage.create!(name: 'Suco de Laranja', description: 'Feito com laranjas orgânicas', establishment: establishment)
    Beverage.create!(name: 'Suco de Goiaba', description: 'Feito com goiabas orgânicas', establishment: establishment)

    login_as user
    visit root_path
    fill_in 'Pesquisar', with: 'Laranja'
    click_on 'Pesquisar'

    expect(current_path).to eq(search_establishments_path)
    expect(page).to have_content('Nome: Suco de Laranja')
    expect(page).to have_content('Descrição: Feito com laranjas orgânicas')
    expect(page).not_to have_content('Nome: Miojo')
    expect(page).not_to have_content('Descrição: Da Nissin')
    expect(page).not_to have_content('Nome: Crepioca')
    expect(page).not_to have_content('Descrição: Feita com ovo e tapioca')
    expect(page).not_to have_content('Nome: Suco de Goiaba')
  end

  it 'e encontra vários produtos' do
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', 
                                                          close_hour: '18:00')
    Dish.create!(name: 'Miojo', description: 'Da Nissin', calorie: 400, establishment: establishment)   
    Dish.create!(name: 'Crepioca', description: 'Feita com ovo e tapioca', calorie: 800, establishment: establishment)   
    Beverage.create!(name: 'Suco de Laranja', description: 'Feito com laranjas orgânicas', establishment: establishment)
    Beverage.create!(name: 'Suco de Goiaba', description: 'Feito com goiabas orgânicas', establishment: establishment)

    login_as user
    visit root_path
    fill_in 'Pesquisar', with: 'Suco'
    click_on 'Pesquisar'

    expect(current_path).to eq(search_establishments_path)
    expect(page).to have_content('Nome: Suco de Laranja')
    expect(page).to have_content('Descrição: Feito com laranjas orgânicas')
    expect(page).to have_content('Nome: Suco de Goiaba')
    expect(page).to have_content('Descrição: Feito com goiabas orgânicas')
    expect(page).not_to have_content('Nome: Miojo')
    expect(page).not_to have_content('Descrição: Da Nissin')
    expect(page).not_to have_content('Nome: Crepioca')
    expect(page).not_to have_content('Descrição: Feita com ovo e tapioca')
    
  end
end
require 'rails_helper'

describe 'Usuário pesquisa um prato ou bebida' do
  it 'mas precisa estar autenticado' do
    user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
    establishment = Establishment.create!(corporate_name: 'Distribuidora Alimentícia Ifood', brand_name: 'Ifood', 
                                          restration_number: CNPJ.generate, full_address: 'Av Presindete Cabral', 
                                          phone_number: '11981545874', email: 'contato@ifood.com', user: user)
    Dish.create!(name: 'Miojo', description: 'Da Nissin', calorie: 400, establishment: establishment)   
    
    visit root_path
    fill_in 'Pesquisar', with: 'Miojo'
    click_on 'Pesquisar'

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_content('Para continuar, faça login ou registre-se.')
  end

  it 'mas precisa ter um estabelecimento' do
    user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
    
    login_as(user)
    visit root_path
    fill_in 'Pesquisar', with: 'Miojo'
    click_on 'Pesquisar'

    expect(current_path).to eq(new_establishment_path)
    expect(page).to have_content('Cadastrar Estabelecimento')
  end

  it 'e encontra um prato' do
    user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
    establishment = Establishment.create!(corporate_name: 'Distribuidora Alimentícia Ifood', brand_name: 'Ifood', 
                                          restration_number: CNPJ.generate, full_address: 'Av Presindete Cabral', 
                                          phone_number: '11981545874', email: 'contato@ifood.com', user: user)
    Dish.create!(name: 'Miojo', description: 'Da Nissin', calorie: 400, establishment: establishment)   
    Dish.create!(name: 'Crepioca', description: 'Feita com ovo e tapioca', calorie: 800, establishment: establishment)   
    Beverage.create!(name: 'Suco de Laranja', description: 'Feito com laranjas orgânicas', establishment: establishment)
    Beverage.create!(name: 'Suco de Goiaba', description: 'Feito com goiabas orgânicas', establishment: establishment)

    login_as user
    visit root_path
    fill_in 'Pesquisar', with: 'Miojo'
    click_on 'Pesquisar'

    expect(current_path).to eq(search_establishment_index_path)
    expect(page).to have_content('Nome: Miojo')
    expect(page).to have_content('Descrição: Da Nissin')
    expect(page).not_to have_content('Nome: Crepioca')
    expect(page).not_to have_content('Descrição: Feita com ovo e tapioca')
    expect(page).not_to have_content('Nome: Suco de Laranja')
    expect(page).not_to have_content('Nome: Suco de Goiaba')
  end

  it 'e encontra uma bebida' do
    user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
    establishment = Establishment.create!(corporate_name: 'Distribuidora Alimentícia Ifood', brand_name: 'Ifood', 
                                          restration_number: CNPJ.generate, full_address: 'Av Presindete Cabral', 
                                          phone_number: '11981545874', email: 'contato@ifood.com', user: user)
    Dish.create!(name: 'Miojo', description: 'Da Nissin', calorie: 400, establishment: establishment)   
    Dish.create!(name: 'Crepioca', description: 'Feita com ovo e tapioca', calorie: 800, establishment: establishment)   
    Beverage.create!(name: 'Suco de Laranja', description: 'Feito com laranjas orgânicas', establishment: establishment)
    Beverage.create!(name: 'Suco de Goiaba', description: 'Feito com goiabas orgânicas', establishment: establishment)

    login_as user
    visit root_path
    fill_in 'Pesquisar', with: 'Laranja'
    click_on 'Pesquisar'

    expect(current_path).to eq(search_establishment_index_path)
    expect(page).to have_content('Nome: Suco de Laranja')
    expect(page).to have_content('Descrição: Feito com laranjas orgânicas')
    expect(page).not_to have_content('Nome: Miojo')
    expect(page).not_to have_content('Descrição: Da Nissin')
    expect(page).not_to have_content('Nome: Crepioca')
    expect(page).not_to have_content('Descrição: Feita com ovo e tapioca')
    expect(page).not_to have_content('Nome: Suco de Goiaba')
  end

  it 'e encontra vários produtos' do
    user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
    establishment = Establishment.create!(corporate_name: 'Distribuidora Alimentícia Ifood', brand_name: 'Ifood', 
                                          restration_number: CNPJ.generate, full_address: 'Av Presindete Cabral', 
                                          phone_number: '11981545874', email: 'contato@ifood.com', user: user)
    Dish.create!(name: 'Miojo', description: 'Da Nissin', calorie: 400, establishment: establishment)   
    Dish.create!(name: 'Crepioca', description: 'Feita com ovo e tapioca', calorie: 800, establishment: establishment)   
    Beverage.create!(name: 'Suco de Laranja', description: 'Feito com laranjas orgânicas', establishment: establishment)
    Beverage.create!(name: 'Suco de Goiaba', description: 'Feito com goiabas orgânicas', establishment: establishment)

    login_as user
    visit root_path
    fill_in 'Pesquisar', with: 'Suco'
    click_on 'Pesquisar'

    expect(current_path).to eq(search_establishment_index_path)
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
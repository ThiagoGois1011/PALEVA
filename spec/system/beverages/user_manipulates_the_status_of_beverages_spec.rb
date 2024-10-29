require 'rails_helper'

describe 'Usuário vê o status da bebida' do
  it 'a partir da lista das bebidas' do
    user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
    establishment = Establishment.create!(corporate_name: 'Distribuidora Alimentícia Ifood', brand_name: 'Ifood', 
                                          restration_number: CNPJ.generate, full_address: 'Av Presindete Cabral', 
                                          phone_number: '11981545874', email: 'contato@ifood.com', user: user)
    7.times do |day| 
      OpeningHour.create!(establishment: establishment, open_hour: '08:00', 
                          close_hour: '18:00', day_of_week: day)               
    end
    Beverage.create!(name: 'Suco de Laranja', description: 'Feito com laranjas orgânicas', calorie: 400, establishment: establishment)

    login_as user 
    visit establishment_beverages_path(establishment.id)

    expect(page).to have_content('Nome: Suco de Laranja')
    expect(page).to have_content('Status: Ativo')
  end

  it 'a partir da página do prato' do
    user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
    establishment = Establishment.create!(corporate_name: 'Distribuidora Alimentícia Ifood', brand_name: 'Ifood', 
                                          restration_number: CNPJ.generate, full_address: 'Av Presindete Cabral', 
                                          phone_number: '11981545874', email: 'contato@ifood.com', user: user)
    7.times do |day| 
      OpeningHour.create!(establishment: establishment, open_hour: '08:00', 
                          close_hour: '18:00', day_of_week: day)               
    end
    Beverage.create!(name: 'Suco de Laranja', description: 'Feito com laranjas orgânicas', calorie: 400, establishment: establishment)

    login_as user 
    visit establishment_beverages_path(establishment.id)
    click_on 'Suco de Laranja'

    expect(page).to have_content('Nome: Suco de Laranja')
    expect(page).to have_content('Status: Ativo')
  end

  it 'e edita para desativado' do
    user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
    establishment = Establishment.create!(corporate_name: 'Distribuidora Alimentícia Ifood', brand_name: 'Ifood', 
                                          restration_number: CNPJ.generate, full_address: 'Av Presindete Cabral', 
                                          phone_number: '11981545874', email: 'contato@ifood.com', user: user)
    7.times do |day| 
      OpeningHour.create!(establishment: establishment, open_hour: '08:00', 
                          close_hour: '18:00', day_of_week: day)               
    end
    Beverage.create!(name: 'Suco de Laranja', description: 'Feito com laranjas orgânicas', calorie: 400, establishment: establishment)

    login_as user 
    visit establishment_beverages_path(establishment.id)
    click_on 'Suco de Laranja'
    click_on 'Desativar'

    expect(page).to have_content('Nome: Suco de Laranja')
    expect(page).to have_content('Status: Desativado')
  end

  it 'e edita para ativado' do
    user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
    establishment = Establishment.create!(corporate_name: 'Distribuidora Alimentícia Ifood', brand_name: 'Ifood', 
                                          restration_number: CNPJ.generate, full_address: 'Av Presindete Cabral', 
                                          phone_number: '11981545874', email: 'contato@ifood.com', user: user)
    7.times do |day| 
      OpeningHour.create!(establishment: establishment, open_hour: '08:00', 
                          close_hour: '18:00', day_of_week: day)               
    end
    Beverage.create!(name: 'Suco de Laranja', description: 'Feito com laranjas orgânicas', calorie: 400, establishment: establishment, status: :disabled)

    login_as user 
    visit establishment_beverages_path(establishment.id)
    click_on 'Suco de Laranja'
    click_on 'Ativar'

    expect(page).to have_content('Nome: Suco de Laranja')
    expect(page).to have_content('Status: Ativo')
  end
end
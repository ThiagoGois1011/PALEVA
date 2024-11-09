require 'rails_helper'

describe 'Usuário vê o status da bebida' do
  it 'a partir da lista das bebidas' do
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', 
                                                          close_hour: '18:00')
    Beverage.create!(name: 'Suco de Laranja', description: 'Feito com laranjas orgânicas', calorie: 400, establishment: establishment)

    login_as user 
    visit establishment_beverages_path

    expect(page).to have_content('Nome: Suco de Laranja')
    expect(page).to have_content('Status: Ativo')
  end

  it 'a partir da página do prato' do
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', 
                                                          close_hour: '18:00')
    Beverage.create!(name: 'Suco de Laranja', description: 'Feito com laranjas orgânicas', calorie: 400, establishment: establishment)

    login_as user 
    visit establishment_beverages_path
    click_on 'Suco de Laranja'

    expect(page).to have_content('Nome: Suco de Laranja')
    expect(page).to have_content('Status: Ativo')
  end

  it 'e edita para desativado' do
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', 
                                                          close_hour: '18:00')
    Beverage.create!(name: 'Suco de Laranja', description: 'Feito com laranjas orgânicas', calorie: 400, establishment: establishment)

    login_as user 
    visit establishment_beverages_path
    click_on 'Suco de Laranja'
    click_on 'Desativar'

    expect(page).to have_content('Nome: Suco de Laranja')
    expect(page).to have_content('Status: Desativado')
  end

  it 'e edita para ativado' do
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', 
                                                          close_hour: '18:00')
    Beverage.create!(name: 'Suco de Laranja', description: 'Feito com laranjas orgânicas', calorie: 400, establishment: establishment, status: :disabled)

    login_as user 
    visit establishment_beverages_path
    click_on 'Suco de Laranja'
    click_on 'Ativar'

    expect(page).to have_content('Nome: Suco de Laranja')
    expect(page).to have_content('Status: Ativo')
  end
end
require 'rails_helper'

describe 'O dono do estabelecimento faz o pré cadastro do funcionário' do
  it 'com sucesso' do 
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', close_hour: '18:00')

    login_as user
    visit root_path
    click_on 'Funcionários'
    click_on 'Cadastrar novo Funcionário'
    fill_in 'CPF', with: '01962810089'
    fill_in 'Email', with: 'juninho@email.com'
    click_on 'Salvar'

    new_employee = Employee.last
    expect(page).to have_content('Novo funcionário cadastrado com sucesso.')
    expect(new_employee.cpf).to eq('01962810089')
    expect(new_employee.email).to eq('juninho@email.com')
  end

  it 'com CPF e Email duplicado' do 
    user = create_owner(name: 'Andre', cpf: '01962810089', email: 'juninho@email.com')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', close_hour: '18:00')

    login_as user
    visit root_path
    click_on 'Funcionários'
    click_on 'Cadastrar novo Funcionário'
    fill_in 'CPF', with: '01962810089'
    fill_in 'Email', with: 'juninho@email.com'
    click_on 'Salvar'

    new_employee = Employee.last
    expect(page).to have_content('Funcionário não cadastrado.')
    expect(page).to have_content('Email já está em uso')
    expect(page).to have_content('CPF já está em uso')
  end

  it 'com CPF e Email em branco' do 
    user = create_owner(name: 'Andre', cpf: '01962810089', email: 'juninho@email.com')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', close_hour: '18:00')

    login_as user
    visit root_path
    click_on 'Funcionários'
    click_on 'Cadastrar novo Funcionário'
    fill_in 'CPF', with: ''
    fill_in 'Email', with: ''
    click_on 'Salvar'

    new_employee = Employee.last
    expect(page).to have_content('Funcionário não cadastrado.')
    expect(page).to have_content('Email não pode ficar em branco')
    expect(page).to have_content('CPF não pode ficar em branco')
  end

  it 'com CPF e Email inválido' do 
    user = create_owner(name: 'Andre', cpf: '01962810089', email: 'juninho@email.com')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', close_hour: '18:00')

    login_as user
    visit root_path
    click_on 'Funcionários'
    click_on 'Cadastrar novo Funcionário'
    fill_in 'CPF', with: '99999999'
    fill_in 'Email', with: 'juninho@@email'
    click_on 'Salvar'

    new_employee = Employee.last
    expect(page).to have_content('Funcionário não cadastrado.')
    expect(page).to have_content('Email não é válido')
    expect(page).to have_content('CPF inválido')
  end
end
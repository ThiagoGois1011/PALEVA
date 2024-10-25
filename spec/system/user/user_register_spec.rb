require 'rails_helper'

describe 'Usuário se cadastra' do
  it 'com sucesso' do
    visit root_path
    click_on 'Cadastrar'
    fill_in 'Nome', with: 'Thiago'
    fill_in 'Sobrenome', with: 'dos Anjos Soares Gois'
    fill_in 'CPF', with: '08882664562'
    fill_in 'Email', with: 'thiago@email.com'
    fill_in 'Senha', with: 'password1234'
    fill_in 'Confirme sua senha', with: 'password1234'
    click_on 'Cadastrar'
  
    expect(page).to have_content('Bem vindo! Você realizou seu registro com sucesso.')
    current_user = User.last
    expect(current_user.name).to eq('Thiago')
    expect(current_user.cpf).to eq('08882664562')
  end

  it 'com email inválido' do
    visit root_path
    click_on 'Cadastrar'
    fill_in 'Nome', with: 'Thiago'
    fill_in 'Sobrenome', with: 'dos Anjos Soares Gois'
    fill_in 'CPF', with: '84536595265'
    fill_in 'Email', with: 'thiago@email'
    fill_in 'Senha', with: 'password1234'
    fill_in 'Confirme sua senha', with: 'password1234'
    click_on 'Cadastrar'

    expect(page).to have_content('Não foi possível salvar usuário')
    expect(page).to have_content('Email não é válido')
  end

  it 'com senha menor que 12 caracteres' do
    visit root_path
    click_on 'Cadastrar'
    fill_in 'Nome', with: 'Thiago'
    fill_in 'Sobrenome', with: 'dos Anjos Soares Gois'
    fill_in 'CPF', with: '84536595265'
    fill_in 'Email', with: 'thiago@email.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Cadastrar'

    expect(page).to have_content('Não foi possível salvar usuário')
    expect(page).to have_content('Senha é muito curto')
  end

  it 'com CPF inválido' do
    visit root_path
    click_on 'Cadastrar'
    fill_in 'Nome', with: 'Thiago'
    fill_in 'Sobrenome', with: 'dos Anjos Soares Gois'
    fill_in 'CPF', with: '88888888888'
    fill_in 'Email', with: 'thiago@email.com'
    fill_in 'Senha', with: 'password1234'
    fill_in 'Confirme sua senha', with: 'password1234'
    click_on 'Cadastrar'
     
    expect(page).to have_content('Não foi possível salvar usuário')
    expect(page).to have_content('CPF inválido')
  end

  it 'com CPF duplicado' do
    User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: 44749124621, email: 'andre@email.com', password: 'password5498')

    visit root_path
    click_on 'Cadastrar'
    fill_in 'Nome', with: 'Thiago'
    fill_in 'Sobrenome', with: 'dos Anjos Soares Gois'
    fill_in 'CPF', with: '44749124621'
    fill_in 'Email', with: 'thiago@email.com'
    fill_in 'Senha', with: 'password1234'
    fill_in 'Confirme sua senha', with: 'password1234'
    click_on 'Cadastrar'

    expect(page).to have_content('Não foi possível salvar usuário')
    expect(page).to have_content('CPF já está em uso')
  end

end
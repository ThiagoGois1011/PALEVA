require 'rails_helper'

describe 'Funcionário acessa uma página' do
 context 'mas é bloqueado ao acessar a página de' do
    it 'pratos' do
      owner = create_owner(name: 'André')
      establishment = create_establishment_and_opening_hour(owner, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', close_hour: '18:00')
      employee = create_employee(establishment, name: 'João', email: 'joao@email.com', password: 'password9999')

      login_as employee
      visit establishment_dishes_path

      expect(page).to have_content('Você não tem permissão de entrar nesta página.')
      expect(current_path).to eq(establishment_menus_path)
    end

    it 'bebidas' do
      owner = create_owner(name: 'André')
      establishment = create_establishment_and_opening_hour(owner, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', close_hour: '18:00')
      employee = create_employee(establishment, name: 'João', email: 'joao@email.com', password: 'password9999')

      login_as employee
      visit establishment_beverages_path

      expect(page).to have_content('Você não tem permissão de entrar nesta página.')
      expect(current_path).to eq(establishment_menus_path)
    end

    it 'formulário para criar bebidas' do
      owner = create_owner(name: 'André')
      establishment = create_establishment_and_opening_hour(owner, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', close_hour: '18:00')
      employee = create_employee(establishment, name: 'João', email: 'joao@email.com', password: 'password9999')

      login_as employee
      visit new_establishment_beverage_path

      expect(page).to have_content('Você não tem permissão de entrar nesta página.')
      expect(current_path).to eq(establishment_menus_path)
    end
 end

 it 'de uma lista de cardápios' do
  owner = create_owner(name: 'André')
  establishment = create_establishment_and_opening_hour(owner, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', close_hour: '18:00')
  employee = create_employee(establishment, name: 'João', email: 'joao@email.com', password: 'password9999')

  login_as employee
  visit establishment_menus_path

  expect(page).not_to have_content('Você não tem permissão de entrar nesta página.')
  expect(current_path).to eq(establishment_menus_path)
 end

 it 'de um cardápios' do
  owner = create_owner(name: 'André')
  establishment = create_establishment_and_opening_hour(owner, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', close_hour: '18:00')
  employee = create_employee(establishment, name: 'João', email: 'joao@email.com', password: 'password9999')
  menu = Menu.create!(name: 'Almoço', establishment: establishment)

  login_as employee
  visit establishment_menu_path(menu)

  expect(page).not_to have_content('Você não tem permissão de entrar nesta página.')
  expect(current_path).to eq(establishment_menu_path(menu))
 end

 it 'do estabelecimento' do
  owner = create_owner(name: 'André')
  establishment = create_establishment_and_opening_hour(owner, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', close_hour: '18:00')
  employee = create_employee(establishment, name: 'João', email: 'joao@email.com', password: 'password9999')

  login_as employee
  visit establishment_path

  expect(page).not_to have_content('Você não tem permissão de entrar nesta página.')
  expect(current_path).to eq(establishment_path)
 end

 it 'de criação de pedido' do
  owner = create_owner(name: 'André')
  establishment = create_establishment_and_opening_hour(owner, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', close_hour: '18:00')
  employee = create_employee(establishment, name: 'João', email: 'joao@email.com', password: 'password9999')

  login_as employee
  visit new_establishment_order_path

  expect(page).not_to have_content('Você não tem permissão de entrar nesta página.')
  expect(current_path).to eq(new_establishment_order_path)
 end
end
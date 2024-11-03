require 'rails_helper'

describe 'Usuário cadastra um horário de funcionamento' do
  context 'a partir da tela inicial' do
    it 'com sucesso' do
      user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
      cnpj = CNPJ.generate
  
      login_as user
      visit root_path
      click_on 'Estabelecimento'
      fill_in 'Nome Fantasia', with: 'Distribuidora Alimentícia Ifood'
      fill_in 'Razão Social', with: 'Ifood'
      fill_in 'CNPJ', with:cnpj
      fill_in 'Endereço', with: 'av presindete cabral'
      fill_in 'Telefone', with: '11981545874'
      fill_in 'Email', with: 'contato@ifood.com'
      click_on 'Cadastrar Estabelecimento'
      within('.business_days') do
        fill_in 'Horário de abertura', with: '8:00'
        fill_in 'Horário de fechamento', with: '18:00'
      end
      within('.saturday') do
        fill_in 'Horário de abertura', with: '8:00'
        fill_in 'Horário de fechamento', with: '14:00'
      end
      within('.sunday') do
        check 'Fechado'
      end
      click_on 'Salvar'
  
      expect(page).to have_content('Horário de abertura cadastrado com sucesso.')
      expect(current_path).to eq(establishment_path(Establishment.last.id))
      expect(page).to have_content('Razão Social: Ifood')
      expect(page).to have_content('Email: contato@ifood.com')
      expect(page).to have_content("CNPJ: #{cnpj}" )
      expect(page).to have_content('Segunda: 08:00 - 18:00')
      expect(page).to have_content('Quarta: 08:00 - 18:00')
      expect(page).to have_content('Sábado: 08:00 - 14:00')
      expect(page).to have_content('Domingo: Fechado')
    end

    it 'com horários comerciais diferentes' do
      user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
      cnpj = CNPJ.generate
  
      login_as user
      visit root_path
      click_on 'Estabelecimento'
      fill_in 'Nome Fantasia', with: 'Distribuidora Alimentícia Ifood'
      fill_in 'Razão Social', with: 'Ifood'
      fill_in 'CNPJ', with:cnpj
      fill_in 'Endereço', with: 'av presindete cabral'
      fill_in 'Telefone', with: '11981545874'
      fill_in 'Email', with: 'contato@ifood.com'
      click_on 'Cadastrar Estabelecimento'
      check 'Configurar os dias separadamente'
      within('.monday') do
        fill_in 'Horário de abertura', with: '8:00'
        fill_in 'Horário de fechamento', with: '18:00'
      end
      within('.tuesday') do
        fill_in 'Horário de abertura', with: '6:00'
        fill_in 'Horário de fechamento', with: '16:00'
      end
      within('.wednesday') do
        check 'Fechado'
      end
      within('.thursday') do
        fill_in 'Horário de abertura', with: '7:00'
        fill_in 'Horário de fechamento', with: '17:00'
      end
      within('.friday') do
        fill_in 'Horário de abertura', with: '2:00'
        fill_in 'Horário de fechamento', with: '12:00'
      end
      within('.saturday') do
        fill_in 'Horário de abertura', with: '8:00'
        fill_in 'Horário de fechamento', with: '14:00'
      end
      within('.sunday') do
        check 'Fechado'
      end
      click_on 'Salvar'
  
      expect(page).to have_content('Horário de abertura cadastrado com sucesso.')
      expect(current_path).to eq(establishment_path(Establishment.last.id))
      expect(page).to have_content('Razão Social: Ifood')
      expect(page).to have_content('Email: contato@ifood.com')
      expect(page).to have_content("CNPJ: #{cnpj}" )
      expect(page).to have_content('Segunda: 08:00 - 18:00')
      expect(page).to have_content('Terça: 06:00 - 16:00')
      expect(page).to have_content('Quarta: Fechado')
      expect(page).to have_content('Sábado: 08:00 - 14:00')
      expect(page).to have_content('Domingo: Fechado')
    end
  end
end
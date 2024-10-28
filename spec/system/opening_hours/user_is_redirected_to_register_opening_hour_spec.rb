require 'rails_helper'

describe 'Usuário é redirecionado' do
  context 'para cadastrar um horário de abertura' do
    it 'a partir da página inicial' do
      user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: 44749124621, email: 'andre@email.com', password: 'password5498')
      establishment = Establishment.create!(corporate_name: 'Distribuidora Alimentícia Ifood', brand_name: 'Ifood', 
                                            restration_number: CNPJ.generate, full_address: 'Av Presindete Cabral', 
                                            phone_number: '11981545874', email: 'contato@ifood.com', user: user)

      login_as user
      visit root_path
      click_on 'Estabelecimento'
      
      expect(page).to have_content('Cadastrar Horário de Funcionamento')
      expect(current_path).to eq(new_establishment_opening_hour_path(establishment.id))
    end
  end

  it 'porém já possui todos os dias' do 
    user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: 44749124621, email: 'andre@email.com', password: 'password5498')
    establishment = Establishment.create!(corporate_name: 'Distribuidora Alimentícia Ifood', brand_name: 'Ifood', 
                                          restration_number: CNPJ.generate, full_address: 'Av Presindete Cabral', 
                                          phone_number: '11981545874', email: 'contato@ifood.com', user: user)
    7.times do |day| 
      OpeningHour.create!(establishment: establishment, open_hour: '08:00', 
                          close_hour: '18:00', day_of_week: day)               
    end
    
    login_as user
    visit new_establishment_opening_hour_path(establishment.id)

    expect(page).to have_content('Todos os dias já foram cadastrados.')
    expect(current_path).to eq(establishment_path(establishment.id))
  end
end
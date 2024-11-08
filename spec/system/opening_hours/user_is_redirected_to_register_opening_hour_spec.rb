require 'rails_helper'

describe 'Usuário é redirecionado' do
  context 'para cadastrar um horário de abertura' do
    it 'a partir da página inicial' do
      user = create_owner(name: 'Andre')
      establishment = create_establishment(user, corporate_name: 'Distribuidora Alimentícia Ifood')

      login_as user
      visit root_path
      click_on 'Estabelecimento'
      
      expect(page).to have_content('Cadastrar Horário de Funcionamento')
      expect(current_path).to eq(new_establishment_opening_hour_path(establishment.id))
    end
  end

  it 'porém já possui todos os dias' do 
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', close_hour: '18:00')
    
    login_as user
    visit new_establishment_opening_hour_path(establishment.id)

    expect(page).to have_content('Todos os dias já foram cadastrados.')
    expect(current_path).to eq(establishment_path(establishment.id))
  end
end
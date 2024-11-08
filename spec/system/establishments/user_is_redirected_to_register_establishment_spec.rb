require 'rails_helper'

describe 'Usuário é redirecionado' do
  context 'para cadastrar um estabelecimento' do
    it 'a partir da página inicial' do
      user = create_owner(name: 'Andre')

      login_as user
      visit root_path
      click_on 'Estabelecimento'
      
      expect(page).to have_content('Cadastrar Estabelecimento')
      expect(current_path).to eq(new_establishment_path)
    end
  end

  it 'Por que já possui um estabelecimento' do 
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', 
                                                          close_hour: '18:00')

    login_as user
    visit new_establishment_path

    expect(page).to have_content('Cada usuário só pode ter um estabelecimento cadastrado')
    expect(current_path).to eq(establishment_path(establishment.id))
  end
end
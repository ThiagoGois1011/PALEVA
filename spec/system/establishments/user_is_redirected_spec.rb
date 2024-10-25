require 'rails_helper'

describe 'Usuário é redirecionado' do
  context 'para cadastrar um estabelecimento' do
    it 'a partir da página inicial' do
      user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: 44749124621, email: 'andre@email.com', password: 'password5498')

      login_as user
      visit root_path

      expect(page).to have_content('Cadastrar Estabelecimento')
      expect(current_path).to eq(new_establishment_path)
    end
  end

  it 'Por que já possui um estabelecimento' do 
    user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: 44749124621, email: 'andre@email.com', password: 'password5498')
    establishment = Establishment.create!(corporate_name: 'Distribuidora Alimentícia Ifood', brand_name: 'Ifood', 
                                          restration_number: CNPJ.generate, full_address: 'Av Presindete Cabral', 
                                          phone_number: '11981545874', email: 'contato@ifood.com', user: user)

    login_as user
    visit new_establishment_path

    expect(page).to have_content('Cada usuário só pode ter um estabelecimento cadastrado')
    expect(current_path).to eq(establishment_path(establishment.id))
  end
end
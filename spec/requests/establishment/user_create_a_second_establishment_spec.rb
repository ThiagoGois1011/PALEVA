require 'rails_helper'

describe 'Usuário tenta enviar uma requisição para o controller do estabelecimento' do
  it 'para criar um segundo estabelecimento' do
    user = create_owner(name: 'João')
    establishment = create_establishment(user, corporate_name: 'Distribuidora Alimentícia Ifood')

    login_as user
    post(establishment_path, params: {establishment: {corporate_name: 'Distribuidora Alimentícia Mc lanches', brand_name: 'Mc lanches', 
                                                       restration_number: CNPJ.generate, full_address: 'Av São Paulo', 
                                                       phone_number: '11981545274', email: 'vendas@mclanches.com'}})
    expect(response).to redirect_to(establishment_path)
  end
end
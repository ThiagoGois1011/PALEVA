require 'rails_helper'

describe 'Usuário tenta enviar uma requisição para o controller do estabelecimento' do
  it 'para criar um segundo estabelecimento' do
    user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
    Establishment.create!(corporate_name: 'Distribuidora Alimentícia Mc lanches', brand_name: 'Mc lanches', 
                                          restration_number: CNPJ.generate, full_address: 'Av São Paulo', 
                                          phone_number: '11981545274', email: 'vendas@mclanches.com', user: user)

    login_as user
    post(establishment_index_path, params: {establishment: {corporate_name: 'Distribuidora Alimentícia Ifood', brand_name: 'Ifood', 
                                            restration_number: CNPJ.generate, full_address: 'Av Presindete Cabral', 
                                            phone_number: '11981545874', email: 'contato@ifood.com'}})

    expect(response).to redirect_to(establishment_path(user.establishment.id))
  end
end
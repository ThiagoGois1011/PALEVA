require 'rails_helper'

describe 'Usuário cadastra um marcador' do
  it 'com sucesso' do
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', 
                                                          close_hour: '18:00')

    login_as user
    visit establishment_dishes_path
    click_on 'Cadastrar Marcador'
    fill_in 'Descrição', with: 'Alto em sódio'
    click_on 'Salvar'

    expect(page).to have_content('Marcador cadastrado com sucesso.')
    expect(page).to have_content('Alto em sódio')
  end

  it 'com campos em branco' do
    user = create_owner(name: 'Andre')
    establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', 
                                                          close_hour: '18:00')

    login_as user
    visit establishment_dishes_path
    click_on 'Cadastrar Marcador'
    fill_in 'Descrição', with: ''
    click_on 'Salvar'

    expect(current_path).to have_content(establishment_markers_path)
    expect(page).to have_content('Marcador não cadastrado.')
    expect(page).to have_content('Descrição não pode ficar em branco')
  end
end
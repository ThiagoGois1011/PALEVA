require 'rails_helper'

describe 'Usuário cadastra um horário de funcionamento' do
  it 'com sucesso' do
    user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
    establishment = Establishment.create!(corporate_name: 'Distribuidora Alimentícia Ifood', brand_name: 'Ifood', 
                                          restration_number: CNPJ.generate, full_address: 'Av Presindete Cabral', 
                                          phone_number: '11981545874', email: 'contato@ifood.com', user: user)

    login_as user
    visit new_establishment_opening_hour_path(establishment.id)
    within('.dias_comerciais') do
      fill_in 'Horário de abertura', with: '8:00'
      fill_in 'Horário de fechamento', with: '18:00'
    end
    within('.sabado') do
      fill_in 'Horário de abertura', with: '8:00'
      fill_in 'Horário de fechamento', with: '14:00'
    end
    within('.domingo') do
      find(:css, "input[type='checkbox']").set(true)
    end
    click_on 'Salvar'

    expect(page).to have_content('Horário de abertura cadastrado com sucesso.')
    expect(establishment.opening_hours.find_by(day_of_week: :monday).open_hour.strftime("%H:%M")).to eq('08:00')
    expect(establishment.opening_hours.find_by(day_of_week: :sunday).open_hour).to be_nil
  end
end
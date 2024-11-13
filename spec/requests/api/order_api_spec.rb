require 'rails_helper'

describe 'Order API' do
  context 'GET /api/v1/establishments/:establishment_code/orders' do
    it 'sucesso' do
      user = create_owner(name: 'João')
      establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', 
                                                            open_hour: '08:00', close_hour: '18:00')
      products = create_dishes(establishment, dish_1: {name: 'Espaguete', description: 'Macarrão ao molho com pedaços de carne moída'},                 
                               dish_2: {name: 'Estrogonofe', description: 'Frango cortado em cubos ao molho'},
                               dish_3: {name: 'Bife Grelhado', description: 'Carne bovina grelhada'})
      products[0].portions.create(description: '500g', price: 15)
      products[1].portions.create(description: '300g', price: 20)
      products[2].portions.create(description: '1kg', price: 50)
      order_1 = Order.create(name: 'Matheus', phone_number: '11988254174', email: 'matheus@email.com', 
                           cpf: '97168422014', establishment: establishment, user: user, code: Order.generate_code )
      order_1.order_items.create(portion: products[0].portions.first, observation: 'Sem alho');
      order_2 = Order.create(name: 'Thiago', phone_number: '11988774174', email: 'thiago@email.com', 
                           establishment: establishment, user: user, code: Order.generate_code )
      order_2.order_items.create(portion: products[1].portions.first, observation: 'Sem lactose');
      order_3 = Order.create(name: 'André', phone_number: '11988774554', email: 'andre@email.com', 
                           establishment: establishment, user: user, code: Order.generate_code )
      order_3.order_items.create(portion: products[1].portions.first, observation: 'Bem passado');

      get "/api/v1/establishments/#{establishment.code}/orders"

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response[0]["name"]).to eq('Matheus')
      expect(json_response[0]["phone_number"]).to eq('11988254174')
      expect(json_response[0]["email"]).to eq('matheus@email.com')
      expect(json_response[1]["name"]).to eq('Thiago')
      expect(json_response[1]["phone_number"]).to eq('11988774174')
      expect(json_response[1]["email"]).to eq('thiago@email.com')
      expect(json_response[2]["name"]).to eq('André')
      expect(json_response[2]["phone_number"]).to eq('11988774554')
      expect(json_response[2]["email"]).to eq('andre@email.com')
    end

    it 'com nenhum pedido para listar' do
      user = create_owner(name: 'João')
      establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', 
                                                            open_hour: '08:00', close_hour: '18:00')
      
      get "/api/v1/establishments/#{establishment.code}/orders"

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response).to eq([])
    end

    it 'com um código de estabelecimento que não existe' do
      user = create_owner(name: 'João')
      establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', 
                                                            open_hour: '08:00', close_hour: '18:00')

      get "/api/v1/establishments/TEGTDA/orders"

      expect(response).to have_http_status(404)
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response["error"]).to eq('Estabelecimento não encontrado.')
    end

    it 'com erro interno no API' do
      user = create_owner(name: 'João')
      establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', 
                                                            open_hour: '08:00', close_hour: '18:00')
      allow_any_instance_of(Establishment).to receive(:orders).and_raise(ActiveRecord::ActiveRecordError)

      get "/api/v1/establishments/#{establishment.code}/orders"

      expect(response).to have_http_status(500)
    end

    it 'com status de esperando confirmação' do
      user = create_owner(name: 'João')
      establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', 
                                                            open_hour: '08:00', close_hour: '18:00')
      products = create_dishes(establishment, dish_1: {name: 'Espaguete', description: 'Macarrão ao molho com pedaços de carne moída'},                 
                               dish_2: {name: 'Estrogonofe', description: 'Frango cortado em cubos ao molho'},
                               dish_3: {name: 'Bife Grelhado', description: 'Carne bovina grelhada'})
      products[0].portions.create(description: '500g', price: 15)
      products[1].portions.create(description: '300g', price: 20)
      products[2].portions.create(description: '1kg', price: 50)
      order_1 = Order.create(name: 'Matheus', phone_number: '11988254174', email: 'matheus@email.com', 
                           cpf: '97168422014', establishment: establishment, user: user, code: Order.generate_code )
      order_1.order_items.create(portion: products[0].portions.first, observation: 'Sem alho');
      order_2 = Order.create(name: 'Thiago', phone_number: '11988774174', email: 'thiago@email.com', 
                           establishment: establishment, user: user, code: Order.generate_code, status: :waiting_for_confirmation )
      order_2.order_items.create(portion: products[1].portions.first, observation: 'Sem lactose');
      order_3 = Order.create(name: 'André', phone_number: '11988774554', email: 'andre@email.com', 
                           establishment: establishment, user: user, code: Order.generate_code )
      order_3.order_items.create(portion: products[1].portions.first, observation: 'Bem passado');

      get "/api/v1/establishments/#{establishment.code}/orders?status=#{'waiting_for_confirmation'}"

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response[0]["name"]).to eq('Thiago')
      expect(response.body).not_to include('Matheus')
      expect(response.body).not_to include('André')
    end

    it 'com status inválido' do
      user = create_owner(name: 'João')
      establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', 
                                                            open_hour: '08:00', close_hour: '18:00')
      products = create_dishes(establishment, dish_1: {name: 'Espaguete', description: 'Macarrão ao molho com pedaços de carne moída'},                 
                               dish_2: {name: 'Estrogonofe', description: 'Frango cortado em cubos ao molho'},
                               dish_3: {name: 'Bife Grelhado', description: 'Carne bovina grelhada'})
      products[0].portions.create(description: '500g', price: 15)
      products[1].portions.create(description: '300g', price: 20)
      products[2].portions.create(description: '1kg', price: 50)
      order_1 = Order.create(name: 'Matheus', phone_number: '11988254174', email: 'matheus@email.com', 
                           cpf: '97168422014', establishment: establishment, user: user, code: Order.generate_code )
      order_1.order_items.create(portion: products[0].portions.first, observation: 'Sem alho');
      order_2 = Order.create(name: 'Thiago', phone_number: '11988774174', email: 'thiago@email.com', 
                           establishment: establishment, user: user, code: Order.generate_code, status: :waiting_for_confirmation )
      order_2.order_items.create(portion: products[1].portions.first, observation: 'Sem lactose');
      order_3 = Order.create(name: 'André', phone_number: '11988774554', email: 'andre@email.com', 
                           establishment: establishment, user: user, code: Order.generate_code )
      order_3.order_items.create(portion: products[1].portions.first, observation: 'Bem passado');

      get "/api/v1/establishments/#{establishment.code}/orders?status=#{'esperando entrega'}"

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response[0]["name"]).to eq('Matheus')
      expect(json_response[0]["phone_number"]).to eq('11988254174')
      expect(json_response[0]["email"]).to eq('matheus@email.com')
      expect(json_response[1]["name"]).to eq('Thiago')
      expect(json_response[1]["phone_number"]).to eq('11988774174')
      expect(json_response[1]["email"]).to eq('thiago@email.com')
      expect(json_response[2]["name"]).to eq('André')
      expect(json_response[2]["phone_number"]).to eq('11988774554')
      expect(json_response[2]["email"]).to eq('andre@email.com')
    end
  end

  context 'GET /api/v1/establishments/:establishment_code/orders/:code' do
    it 'sucesso' do
      user = create_owner(name: 'João')
      establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', 
                                                            open_hour: '08:00', close_hour: '18:00')
      dish = Dish.create!(name: 'Espaguete', description: 'Macarrão ao molho com pedaços de carne moída', establishment: establishment)
      portion = dish.portions.create(description: '500g', price: 15)
      order = Order.create(name: 'Matheus', phone_number: '11988254174', email: 'matheus@email.com', 
                           cpf: '97168422014', establishment: establishment, user: user, 
                           code: Order.generate_code, status: :waiting_for_confirmation)
      order.order_items.create(portion: portion, observation: 'Sem alho')
    
      get "/api/v1/establishments/#{establishment.code}/orders/#{order.code}"

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response["name"]).to eq('Matheus')
      expect(json_response["phone_number"]).to eq('11988254174')
      expect(json_response["email"]).to eq('matheus@email.com')
      expect(json_response["status"]).to eq('waiting_for_confirmation')
      order_items = json_response["order_items"][0]
      expect(order_items["observation"]).to eq('Sem alho')
      portion_json = order_items["portion"]
      expect(portion_json["description"]).to eq('500g')
      expect(portion_json["price"]).to eq('15.0')
      dish_json = portion_json["portionable"]
      expect(dish_json["name"]).to eq('Espaguete')
      expect(dish_json["description"]).to eq('Macarrão ao molho com pedaços de carne moída')
    end
    
    it 'com um código de estabelecimento que não existe' do
      user = create_owner(name: 'João')
      establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', 
                                                            open_hour: '08:00', close_hour: '18:00')
      order = Order.create(name: 'Matheus', phone_number: '11988254174', email: 'matheus@email.com', 
                           cpf: '97168422014', establishment: establishment, user: user, 
                           code: Order.generate_code, status: :waiting_for_confirmation)

      get "/api/v1/establishments/TEGTDA/orders/#{order.code}"

      expect(response).to have_http_status(404)
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response["error"]).to eq('Estabelecimento não encontrado.')
    end
  end
end
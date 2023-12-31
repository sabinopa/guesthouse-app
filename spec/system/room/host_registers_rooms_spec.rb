require 'rails_helper'

describe 'Host register room' do 
  it 'must have a guesthouse already registered' do 
    host = Host.create!(name: 'Aline', lastname: 'Santos', email: 'aline@email.com', password: 'password')
    payment_method = PaymentMethod.create!(method: 'PIX')
    guesthouse = Guesthouse.create!(host: host, description: 'Atmosfera acolhedora e serviços personalizados', brand_name: 'Pousada Serenidade', 
                                    corporate_name: 'Serenidade Hospedagens Ltda', registration_number: '10.290.988/0001-20', phone_number: '42 98989-0000',
                                    email: 'contato@pousadaencanto.com', address: 'Estrada das Colinas, Km 5', neighborhood: 'Vale Tranquilo', 
                                    city: 'Maceió', state:'AL', postal_code: '12345-67', payment_method_id: payment_method.id, pet_friendly: 'Aceita animais de estimação', 
                                    usage_policy: 'Manter silêncio nas áreas comuns.', checkin: '14:00', checkout: '10:00', status: :active)

    login_as(host, :scope => :host)  
    visit root_path

    expect(page).to have_content 'Ver detalhes da pousada'
    expect(page).to have_content 'Adicionar quartos'
  end

  it 'successfully' do
    host = Host.create!(name: 'Aline', lastname: 'Santos', email: 'aline@email.com', password: 'password')
    payment_method = PaymentMethod.create!(method: 'PIX')
    guesthouse = Guesthouse.create!(host: host, description: 'Atmosfera acolhedora e serviços personalizados', brand_name: 'Pousada Serenidade', 
                                    corporate_name: 'Serenidade Hospedagens Ltda', registration_number: '10.290.988/0001-20', phone_number: '42 98989-0000',
                                    email: 'contato@pousadaencanto.com', address: 'Estrada das Colinas, Km 5', neighborhood: 'Vale Tranquilo', 
                                    city: 'Maceió', state:'AL', postal_code: '12345-67', payment_method_id: payment_method.id, pet_friendly: 'Aceita animais de estimação', 
                                    usage_policy: 'Manter silêncio nas áreas comuns.', checkin: '14:00', checkout: '10:00', status: :active)
  
    login_as(host, :scope => :host)  
    visit root_path
    click_on 'Adicionar quartos'
    fill_in 'Nome', with: 'Quarto Tranquilidade'
    fill_in 'Descrição', with: 'Um ambiente calmo e reconfortante.'
    fill_in 'Dimensão', with: '15'
    fill_in 'Capacidade', with: '4'
    fill_in 'Preço', with: '220.0'
    check 'Banheiro'
    check 'Televisão'
    check 'Armário'
    check 'Cofre'
    check 'Acessibilidade'
    click_on 'Salvar'

    expect(page).to have_content "Quarto Tranquilidade: Criado com sucesso!"
    expect(page).to have_content "Quarto Tranquilidade - 4 pessoas"
  end

  it 'and sees details page' do
    host = Host.create!(name: 'Aline', lastname: 'Santos', email: 'aline@email.com', password: 'password')
    payment_method = PaymentMethod.create!(method: 'PIX')
    guesthouse = Guesthouse.create!(host: host, description: 'Atmosfera acolhedora e serviços personalizados', brand_name: 'Pousada Serenidade', 
                                    corporate_name: 'Serenidade Hospedagens Ltda', registration_number: '10.290.988/0001-20', phone_number: '42 98989-0000',
                                    email: 'contato@pousadaencanto.com', address: 'Estrada das Colinas, Km 5', neighborhood: 'Vale Tranquilo', 
                                    city: 'Maceió', state:'AL', postal_code: '12345-67', payment_method_id: payment_method.id, pet_friendly: 'Aceita animais de estimação', 
                                    usage_policy: 'Manter silêncio nas áreas comuns.', checkin: '14:00', checkout: '10:00', status: :active)
    room = Room.create!(guesthouse: guesthouse, name: 'Tranquilidade', description: 'Um ambiente calmo e reconfortante.', size: 15, 
                        max_people: '4', price: '220.0', bathroom: true, balcony: false, tv: true, wardrobe: true, safe: true, accessibility: true, status: 1)
    
    login_as(host, :scope => :host)  
    visit root_path
    click_on 'Ver quartos'
    click_on 'Tranquilidade - 4 pessoas'

    expect(page).to have_content 'Quarto Tranquilidade'
    expect(page).to have_content 'Pousada Serenidade'
    expect(page).to have_content 'Um ambiente calmo e reconfortante.'
    expect(page).to have_content 'Dimensão: 15 m2'
    expect(page).to have_content 'Capacidade: 4 pessoas'
    expect(page).to have_content 'Preço: R$ 220.0'
    expect(page).to have_content 'Banheiro: Particular'
    expect(page).to have_content 'Armário: Possui'
    expect(page).to have_content 'Cofre: Possui'
    expect(page).to have_content 'Acessível para pessoas com deficiência'
  end

  it 'and sees list of rooms' do
    bruna = Host.create!(name: 'Bruna', lastname: 'Pereira', email: 'bruna@email.com', password: 'password')
    payment_method = PaymentMethod.create!(method: 'PIX')
    guesthouse = bruna.create_guesthouse!(description: 'Atmosfera acolhedora e serviços personalizados', brand_name: 'Pousada Serenidade', 
                                       corporate_name: 'Serenidade Hospedagens Ltda', registration_number: '10.290.988/0001-20', phone_number: '42 98989-0000',
                                       email: 'contato@pousadaencanto.com', address: 'Estrada das Colinas, Km 5', neighborhood: 'Vale Tranquilo', 
                                       city: 'Maceió', state:'AL', postal_code: '12345-67', payment_method_id: payment_method.id, pet_friendly: 'Aceita animais de estimação', 
                                       usage_policy: 'Manter silêncio nas áreas comuns.', checkin: '14:00', checkout: '10:00', status: :active)
    first_room = Room.create!(guesthouse: guesthouse, name: 'Harmonia', description: 'Um espaço sereno para relaxamento total.', size: 20, 
                               max_people: '3', price: '250,00', bathroom: true, balcony: true, tv: false, wardrobe: true, safe: false, accessibility: false, status: 1)  
    second_room = Room.create!(guesthouse: guesthouse, name: 'Calmaria', description: 'Decoração adorável.', size: 10, 
                                 max_people: '2', price: '180,00', bathroom: false, balcony: false, tv: true, wardrobe: true, safe: true, accessibility: true, status: 1) 

    login_as(bruna, :scope => :host)  
    visit root_path
    click_on 'Pousada Serenidade - Maceió'

    expect(page).to have_link 'Harmonia - 3 pessoas'
    expect(page).to have_link 'Calmaria - 2 pessoas'
 end
end
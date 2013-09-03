require 'acceptance_helper'

describe "validar declaracion", :type => :feature do

  context 'sin correo electrónico' do
    it "dispara validaciones" do
      visit '/'
      expect(page).to have_content 'Validar'
      within "form#declaracion" do
        attach_file 'archivo', 'spec/files/mensual_ceros_1_1.xml'
      end
      click_button 'Validar declaración'
      expect(page).to have_content 'Tu solicitud no pudo ser procesada por las siguientes razones'
      expect(page).to have_content 'El correo electrónico proporcionado no es válido.'
    end
  end

  context 'version 1.1' do
    context 'declaracion mensual en ceros' do
      it "valida" do
        email = 'user@example.com'
        visit '/'
        within "form#declaracion" do
          fill_in 'email', :with => email
          attach_file 'archivo', 'spec/files/mensual_ceros_1_1.xml'
        end
        click_button 'Validar declaración'
        expect(page).to have_content "Tu archivo está procesado. Un correo electrónico será enviado a #{email}"
      end
    end

    context 'declaracion mensual con datos' do
      it "valida" do
        email = 'user@example.com'
        visit '/'
        within "form#declaracion" do
          fill_in 'email', :with => email
          attach_file 'archivo', 'spec/files/mensual_datos_1_1.xml'
        end
        click_button 'Validar declaración'
        expect(page).to have_content "Tu archivo está procesado. Un correo electrónico será enviado a #{email}"
      end
    end
  end

  context 'version 2.0' do
    context 'declaracion mensual en ceros' do
      it "valida" do
        email = 'user@example.com'
        visit '/'
        within "form#declaracion" do
          fill_in 'email', :with => email
          attach_file 'archivo', 'spec/files/mensual_ceros_2_0.xml'
        end
        click_button 'Validar declaración'
        expect(page).to have_content "Tu archivo está procesado. Un correo electrónico será enviado a #{email}"
      end
    end

    context 'declaracion mensual con datos' do
      it "valida" do
        email = 'user@example.com'
        visit '/'
        within "form#declaracion" do
          fill_in 'email', :with => email
          attach_file 'archivo', 'spec/files/mensual_datos_2_0.xml'
        end
        click_button 'Validar declaración'
        expect(page).to have_content "Tu archivo está procesado. Un correo electrónico será enviado a #{email}"
      end
    end
  end
end

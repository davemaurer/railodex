require 'rails_helper'

RSpec.describe EmailAddressesController, type: :controller do
  let(:valid_attributes) { { address: 'coolguy@chill.com', person_id: 1} }
  let(:invalid_attributes) { { address: nil, person_id: nil } }
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all email_addresses as @email_addresses" do
      email_address = EmailAddress.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(assigns(:email_addresses)).to eq([email_address])
    end
  end

  describe "GET #show" do
    it "assigns the requested email_address as @email_address" do
      email_address = EmailAddress.create! valid_attributes
      get :show, params: {id: email_address.to_param}, session: valid_session
      expect(assigns(:email_address)).to eq(email_address)
    end
  end

  describe "GET #new" do
    it "assigns a new email_address as @email_address" do
      get :new, params: {}, session: valid_session
      expect(assigns(:email_address)).to be_a_new(EmailAddress)
    end
  end

  describe "GET #edit" do
    it "assigns the requested email_address as @email_address" do
      email_address = EmailAddress.create! valid_attributes
      get :edit, params: {id: email_address.to_param}, session: valid_session
      expect(assigns(:email_address)).to eq(email_address)
    end
  end

  describe "POST #create" do
    let(:john) { Person.create(first_name: 'John', last_name: 'Connor') }
    let(:valid_attributes) { { address: 'john@terminator.com', person_id: john.id } }

    context "with valid params" do
      it "creates a new EmailAddress" do
        expect {
          post :create, params: {email_address: valid_attributes}, session: valid_session
        }.to change(EmailAddress, :count).by(1)
      end

      it "assigns a newly created email_address as @email_address" do
        post :create, params: {email_address: valid_attributes}, session: valid_session
        expect(assigns(:email_address)).to be_a(EmailAddress)
        expect(assigns(:email_address)).to be_persisted
      end

      it "redirects to the created email_address's person" do
        post :create, params: {email_address: valid_attributes}, session: valid_session
        expect(response).to redirect_to(john)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved email_address as @email_address" do
        post :create, params: {email_address: invalid_attributes}, session: valid_session
        expect(assigns(:email_address)).to be_a_new(EmailAddress)
      end

      it "re-renders the 'new' template" do
        post :create, params: {email_address: invalid_attributes}, session: valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:bruce) { Person.create(first_name: 'Bruce', last_name: 'Wayne') }
      let(:valid_attributes) { {address: 'darkknight@me.com', person_id: bruce.id} }
      let(:new_attributes) { { address: 'super@super.com', person_id: bruce.id } }

      it "updates the requested email_address" do
        email_address = EmailAddress.create! valid_attributes
        put :update, params: {id: email_address.to_param, email_address: new_attributes}, session: valid_session
        email_address.reload
        expect(email_address.address).to eq('super@super.com')
      end

      it "assigns the requested email_address as @email_address" do
        email_address = EmailAddress.create! valid_attributes
        put :update, params: {id: email_address.to_param, email_address: valid_attributes}, session: valid_session
        expect(assigns(:email_address)).to eq(email_address)
      end

      it "redirects to the email_address" do
        email_address = EmailAddress.create! valid_attributes
        put :update, params: {id: email_address.to_param, email_address: valid_attributes}, session: valid_session
        expect(response).to redirect_to(bruce)
      end
    end

    context "with invalid params" do
      it "assigns the email_address as @email_address" do
        email_address = EmailAddress.create! valid_attributes
        put :update, params: {id: email_address.to_param, email_address: invalid_attributes}, session: valid_session
        expect(assigns(:email_address)).to eq(email_address)
      end

      it "re-renders the 'edit' template" do
        email_address = EmailAddress.create! valid_attributes
        put :update, params: {id: email_address.to_param, email_address: invalid_attributes}, session: valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested email_address" do
      email_address = EmailAddress.create! valid_attributes
      expect {
        delete :destroy, params: {id: email_address.to_param}, session: valid_session
      }.to change(EmailAddress, :count).by(-1)
    end

    it "redirects to the email_addresses list" do
      email_address = EmailAddress.create! valid_attributes
      delete :destroy, params: {id: email_address.to_param}, session: valid_session
      expect(response).to redirect_to(email_addresses_url)
    end
  end
end

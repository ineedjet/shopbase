# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Clients::AppController, type: :controller do
  describe 'GET #index' do
    context 'when user is client' do
      let(:client) { create(:client) }
      before { sign_in(client) }

      it 'renders index template' do
        get :index
        expect(response).to have_http_status(200)
        expect(response).to render_template :index
      end
    end

    context 'when user is not a client' do
      let(:staff) { create(:staff) }
      before { sign_in(staff) }

      it 'redirects to login page' do
        get :index
        expect(response).to redirect_to new_client_session_path
      end
    end

    context 'when user is not logged in' do
      it 'redirects to login page' do
        get :index
        expect(response).to redirect_to new_client_session_path
      end
    end
  end
end

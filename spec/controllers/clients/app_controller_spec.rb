# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Clients::AppController, type: :controller do
  describe 'GET #show' do
    context 'when user is client' do
      let(:client) { create(:client) }
      before { sign_in(client) }

      it 'renders show template' do
        get :show
        expect(response).to have_http_status(200)
        expect(response).to render_template :show
      end
    end

    context 'when user is not a client' do
      it 'redirects to root' do
        get :show
        expect(response).to redirect_to new_client_session_path
      end
    end
  end
end

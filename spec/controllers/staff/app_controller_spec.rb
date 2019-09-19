# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Staffs::ApplicationController, type: :controller do
  describe 'GET #index' do
    context 'when user is staff' do
      let(:staff) { create(:staff) }
      before { sign_in(staff) }

      it 'renders index template' do
        get :index
        expect(response).to have_http_status(200)
        expect(response).to render_template :index
      end
    end

    context 'when user is not a staff' do
      let(:client) { create(:client) }
      before { sign_in(client) }

      it 'redirects to login page' do
        get :index
        expect(response).to redirect_to new_staff_session_path
      end
    end

    context 'when user is not logged in' do
      it 'redirects to login page' do
        get :index
        expect(response).to redirect_to new_staff_session_path
      end
    end
  end
end

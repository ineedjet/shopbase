# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe 'GET #home' do
    it 'render home template' do
      get :home
      expect(response).to have_http_status(200)
      expect(response).to render_template(:home)
    end
  end
end

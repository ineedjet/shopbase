# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /staffs with auth token', type: :request do
  let(:staff) { create(:staff) }
  let(:credentials) { token_credentials_for(staff) }
  let(:wrong_credentials) do
    { 'uid': staff.uid, 'access-token': 'shit', 'staff': 'wrong' }
  end

  describe 'HTML' do
    context 'with correct credentials' do
      it 'returns 200 status' do
        get '/staffs', headers: credentials
        expect(response).to have_http_status(200)
        expect(response).to render_template('staffs/application/index')
        expect(response).to render_template('layouts/staff', layout: 'staff')
      end
    end

    context 'with wrong credentials' do
      it 'return 302 status' do
        get '/staffs', headers: wrong_credentials
        expect(response).to have_http_status(302)
      end
    end

    context 'without any credentials' do
      it 'return 302 status' do
        get '/staffs'
        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'JSON' do
    context 'with correct credentials' do
      it 'returns json' do
        get '/staffs.json', headers: credentials
        expect(response.content_type).to include('application/json')
        expect(is_json?(response.body)).to be true
        parsed_body = JSON.parse(response.body)
        expect(parsed_body.keys).to_not include('error')
      end
    end

    context 'with wrong credentials' do
      it 'returns json with error' do
        get '/staffs.json', headers: wrong_credentials
        expect(response.content_type).to include('application/json')
        expect(is_json?(response.body)).to be true
        parsed_body = JSON.parse(response.body)
        expect(parsed_body['error']).to eq('You need to sign in or sign up before continuing.')
      end
    end

    context 'without any credentials' do
      it 'returns json with error' do
        get '/staffs.json'
        expect(response.content_type).to include('application/json')
        expect(is_json?(response.body)).to be true
        parsed_body = JSON.parse(response.body)
        expect(parsed_body['error']).to eq('You need to sign in or sign up before continuing.')
      end
    end
  end
end

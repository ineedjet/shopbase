# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /clients with auth token', type: :request do
  let(:client) { create(:client) }
  let(:credentials) { token_credentials_for(client) }
  let(:wrong_credentials) do
    { 'uid': client.uid, 'access-token': 'shit', 'client': 'wrong' }
  end

  describe 'HTML' do
    context 'with correct credentials' do
      it 'returns 200 status' do
        get '/clients', headers: credentials
        expect(response).to have_http_status(200)
        expect(response).to render_template('clients/application/index')
        expect(response).to render_template('layouts/client', layout: 'client')
      end
    end

    context 'with wrong credentials' do
      it 'return 302 status' do
        get '/clients', headers: wrong_credentials
        expect(response).to have_http_status(302)
      end
    end

    context 'without any credentials' do
      it 'return 302 status' do
        get '/clients'
        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'JSON' do
    context 'with correct credentials' do
      it 'returns json' do
        get '/clients.json', headers: credentials
        expect(response.content_type).to include('application/json')
        expect(is_json?(response.body)).to be true
        parsed_body = JSON.parse(response.body)
        expect(parsed_body.keys).to_not include('error')
      end
    end

    context 'with wrong credentials' do
      it 'returns json with error' do
        get '/clients.json', headers: wrong_credentials
        expect(response.content_type).to include('application/json')
        expect(is_json?(response.body)).to be true
        parsed_body = JSON.parse(response.body)
        expect(parsed_body['error']).to eq('You need to sign in or sign up before continuing.')
      end
    end

    context 'without any credentials' do
      it 'returns json with error' do
        get '/clients.json'
        expect(response.content_type).to include('application/json')
        expect(is_json?(response.body)).to be true
        parsed_body = JSON.parse(response.body)
        expect(parsed_body['error']).to eq('You need to sign in or sign up before continuing.')
      end
    end
  end
end

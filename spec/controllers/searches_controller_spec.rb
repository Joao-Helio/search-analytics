require 'rails_helper'

RSpec.describe SearchesController, type: :controller do
  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    let(:valid_attributes) { { query: 'example query' } }

    it 'creates a new SearchLog' do
      expect {
        post :create, params: valid_attributes, format: :json
      }.to change(SearchLog, :count).by(1)
    end

    it 'returns a success message' do
      post :create, params: valid_attributes, format: :json
      json_response = JSON.parse(response.body)
      expect(json_response['status']).to eq('success')
    end
  end

  describe 'GET #results' do
    let!(:article) { Article.create(title: 'example', content: 'example content') }

    it 'returns search results' do
      get :results, params: { query: 'example' }
      expect(assigns(:articles)).to include(article)
    end
  end

  describe 'GET #analytics' do
    let!(:search_log) { SearchLog.create(query: 'example query', ip_address: '127.0.0.1', user_agent: 'Mozilla/5.0') }

    it 'returns top searches' do
      get :analytics
      expect(assigns(:top_queries)).to include('example query' => 1)
    end

    it 'returns recent searches' do
      get :analytics
      expect(assigns(:recent_searches)).to include(search_log)
    end

    it 'returns top searches this week' do
      get :analytics
      expect(assigns(:top_queries_week)).to include('example query' => 1)
    end

    it 'returns top searches this month' do
      get :analytics
      expect(assigns(:top_queries_month)).to include('example query' => 1)
    end
  end
end

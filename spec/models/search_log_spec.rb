require 'rails_helper'

RSpec.describe SearchLog, type: :model do
  it 'is valid with valid attributes' do
    expect(SearchLog.new(query: 'example query', ip_address: '127.0.0.1', user_agent: 'Mozilla/5.0')).to be_valid
  end

  it 'is not valid without a query' do
    expect(SearchLog.new(query: nil, ip_address: '127.0.0.1', user_agent: 'Mozilla/5.0')).not_to be_valid
  end

  it 'is not valid without an ip_address' do
    expect(SearchLog.new(query: 'example query', ip_address: nil, user_agent: 'Mozilla/5.0')).not_to be_valid
  end

  it 'is not valid without a user_agent' do
    expect(SearchLog.new(query: 'example query', ip_address: '127.0.0.1', user_agent: nil)).not_to be_valid
  end

  it 'returns top searches' do
    SearchLog.create(query: 'example query', ip_address: '127.0.0.1', user_agent: 'Mozilla/5.0')
    expect(SearchLog.top_searches).to include('example query' => 1)
  end

  it 'returns recent searches' do
    search_log = SearchLog.create(query: 'example query', ip_address: '127.0.0.1', user_agent: 'Mozilla/5.0')
    expect(SearchLog.recent_searches).to include(search_log)
  end

  it 'returns search trends' do
    SearchLog.create(query: 'example query', ip_address: '127.0.0.1', user_agent: 'Mozilla/5.0')
    expect(SearchLog.search_trends).not_to be_empty
  end
end

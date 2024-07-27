class AnalyticsController < ApplicationController
  def index
    @top_searches = SearchLog.group(:query).order('count_id DESC').limit(10).count(:id)
    @recent_searches = SearchLog.order(created_at: :desc).limit(10)
    @top_users = SearchLog.group(:ip_address).order('count_id DESC').limit(10).count(:id)
    @search_trends = SearchLog.group_by_day(:created_at).count
  end
end
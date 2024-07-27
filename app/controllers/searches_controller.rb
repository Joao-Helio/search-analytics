class SearchesController < ApplicationController
  protect_from_forgery except: :create

  def index
    @top_searches = fetch_top_searches
    @recent_searches = fetch_recent_searches
    @top_users = SearchLog.group(:ip_address).order('count_id DESC').limit(10).count(:id)
    render :index
  end

  def show
    # Code for show action
  end

  def create
    query = params[:query].strip
    ip_address = request.remote_ip

    if query.present?
      SearchLog.create(query: query, ip_address: ip_address)
    end

    render json: { status: 'success', message: 'Search logged successfully' }
  end

  def results
    @query = params[:query]
    @articles = Article.search(@query) if @query.present?
  end

  def suggestions
    query = params[:query]
    articles = Article.where('title ILIKE ?', "%#{query}%").limit(10).pluck(:title)
    render json: { suggestions: articles }
  end

  def analytics
    @top_queries = SearchLog.group(:query).order('count_id DESC').limit(10).count(:id)
    @top_users = SearchLog.group(:ip_address).order('count_id DESC').limit(10).count(:id)
    @search_trends = SearchLog.group_by_day(:created_at).count
    render :index
  end

  private

  def fetch_top_searches
    SearchLog.group(:query).order('count_id DESC').limit(10).count(:id)
  end

  def fetch_recent_searches
    SearchLog.order(created_at: :desc).limit(10)
  end
end

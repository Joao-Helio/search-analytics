class SearchesController < ApplicationController
  protect_from_forgery except: :create

  def index
    render :index
  end

  def show
  end

  def create
    query = params[:query].strip
    ip_address = request.remote_ip
    user_agent = request.user_agent

    if query.present?
      search_log = SearchLog.new(query: query, ip_address: ip_address, user_agent: user_agent)
      search_log.save
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
    @recent_searches = SearchLog.order(created_at: :desc).limit(10)
    @top_queries_week = SearchLog.where(created_at: 1.week.ago..Time.now).group(:query).order('count_id DESC').limit(10).count(:id)
    @top_queries_month = SearchLog.where(created_at: 1.month.ago..Time.now).group(:query).order('count_id DESC').limit(10).count(:id)

    render 'analytics/index'
  end
  
  

  private

  def fetch_top_searches
    SearchLog.group(:query).order('count_id DESC').limit(10).count(:id)
  end

  def fetch_recent_searches
    SearchLog.order(created_at: :desc).limit(10)
  end
end

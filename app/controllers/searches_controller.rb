class SearchesController < ApplicationController
  protect_from_forgery except: :create

  def index
    render :index
  end

  def show
    # Code for show action
  end

  def create
    query = params[:query].strip
    ip_address = request.remote_ip
    user_agent = request.user_agent
  
    logger.debug "Search query: #{query}, IP address: #{ip_address}, User Agent: #{user_agent}"
  
    if query.present?
      search_log = SearchLog.new(query: query, ip_address: ip_address, user_agent: user_agent)
      if search_log.save
        logger.debug "Search log created: #{search_log.inspect}"
      else
        logger.debug "Failed to create search log: #{search_log.errors.full_messages.join(', ')}"
      end
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
    @recent_searches = SearchLog.order(created_at: :desc).limit(10)
  
    logger.debug "Top Queries: #{@top_queries.inspect}"
    logger.debug "Top Users: #{@top_users.inspect}"
    logger.debug "Search Trends: #{@search_trends.inspect}"
    logger.debug "Recent Searches: #{@recent_searches.inspect}"
  
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

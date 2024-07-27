class SearchesController < ApplicationController
    protect_from_forgery except: :create
  
    def index
        @top_searches = SearchLog.top_searches
        @recent_searches = SearchLog.recent_searches
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
        render json: { top_queries: @top_queries }
    end
    
    private
  
    def fetch_suggestions(query)
        SearchLog.where('query LIKE ?', "#{query}%")
                 .group(:query)
                 .order('count_id DESC')
                 .limit(5)
                 .count(:id)
                 .keys
      end

  end
  
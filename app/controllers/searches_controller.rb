class SearchesController < ApplicationController
    protect_from_forgery except: :create
  
    def index
        # Code to render the search page
    end

    def show
        # Code for show action
    end
  
    def create
        SearchLog.create!(
          query: params[:query],
          ip_address: request.remote_ip
        )
        head :ok
    end
    
    def analytics
        @top_searches = SearchLog.top_searches
        @recent_searches = SearchLog.recent_searches
        @search_trends = SearchLog.trend_data
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
  
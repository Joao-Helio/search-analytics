class SearchLog < ApplicationRecord
    def self.top_searches(limit = 10)
        where(created_at: 30.days.ago..Time.current)
          .group(:query)
          .order('count_id DESC')
          .limit(limit)
          .count(:id)
    end
  
    def self.recent_searches(limit = 10)
      order(created_at: :desc).limit(limit)
    end
  
    def self.search_trends
      group_by_day(:created_at).count
    end

    def self.trend_data
        start_date = 30.days.ago.beginning_of_day
        end_date = Time.current.end_of_day
    
        searches_by_day = where(created_at: start_date..end_date)
                           .group("DATE(created_at)")
                           .order("DATE(created_at)")
                           .count
    
        labels = (start_date.to_date..end_date.to_date).map(&:to_s)
        values = labels.map { |date| searches_by_day[date] || 0 }
    
        {
          labels: labels,
          values: values
        }
    end

end
  
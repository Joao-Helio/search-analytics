# Search Analytics Application

## Overview

The Search Analytics Application is a web-based tool designed to track and analyze search queries performed by users. It provides insights into the most popular search terms, recent search activity, and trends over time. The application is built using Ruby on Rails and integrates with a PostgreSQL database for data storage.

## Features

1. **Real-time Search Functionality**:
   - Users can perform search queries in real-time, with results displayed instantly as they type.

2. **Analytics Dashboard**:
   - Displays top search queries of all time, the current week, and the current month.
   - Lists recent search queries.
   - Provides insights into search trends over time.

3. **Data Logging**:
   - Tracks each search query along with the user's IP address and user agent.

## How It Works

1. **Search Functionality**:
   - Users enter search terms into a search box on the main page.
   - As users type, search suggestions are displayed based on existing data.
   - Upon pressing Enter or clicking the Search button, the application logs the search query and redirects the user to a results page.

2. **Data Logging**:
   - Each search query is logged with associated metadata (IP address, user agent) and stored in the `SearchLog` table in the database.
   - Logged data is used for generating analytics and insights.

3. **Analytics Dashboard**:
   - Aggregates data from the `SearchLog` table to display various insights.
   - Uses ActiveRecord queries to group and count search queries for different time periods.

## Technical Details

- **Backend**: Ruby on Rails
- **Frontend**: HTML, CSS (Bootstrap)
- **Database**: PostgreSQL

## Example Usage

### Perform a Search

1. Navigate to the homepage.
2. Enter a search term in the search box.
3. View instant search suggestions.
4. Press Enter or click the Search button to see the results.

### View Analytics

1. Click on the "Analytics" button on the homepage.
2. View top searches, recent searches, and search trends on the analytics dashboard.

## Contact
For any questions or support, please contact joaohelio@hotmail.com.
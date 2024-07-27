// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "analytics"
import './controllers/analytics';
import "bootstrap"
import 'bootstrap/dist/js/bootstrap'
import 'bootstrap/dist/css/bootstrap.min.css'

document.addEventListener('DOMContentLoaded', () => {
    const searchForm = document.getElementById('search-form');
    const searchInput = document.getElementById('search-input');
    const suggestions = document.getElementById('suggestions');
  
    searchForm.addEventListener('submit', async (event) => {
      event.preventDefault();
      const query = searchInput.value;
  
      if (query.trim() === '') return;
  
      try {
        const response = await fetch('/search', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
          },
          body: JSON.stringify({ query })
        });
  
        const data = await response.json();
        displaySuggestions(data.suggestions);
      } catch (error) {
        console.error('Error fetching search suggestions:', error);
      }
    });
  
    function displaySuggestions(suggestionsList) {
      suggestions.innerHTML = '';
      suggestionsList.forEach(suggestion => {
        const suggestionElement = document.createElement('div');
        suggestionElement.textContent = suggestion;
        suggestions.appendChild(suggestionElement);
      });
    }
  });
  
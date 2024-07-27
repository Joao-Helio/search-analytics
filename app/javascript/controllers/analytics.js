document.addEventListener('DOMContentLoaded', function () {
    const searchBox = document.getElementById('searchBox');
  
    searchBox.addEventListener('input', function () {
      const query = searchBox.value.trim();
  
      if (query) {
        logSearch(query);
      }
    });
  
    function logSearch(query) {
      fetch('/searches', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        },
        body: JSON.stringify({ query: query })
      })
      .then(response => response.json())
      .then(data => {
        console.log('Search logged:', data);
      });
    }
  });
  
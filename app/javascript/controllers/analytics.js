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
        })
        .catch(error => {
            console.error('Error logging search:', error);
        });
    }

    // Read and parse trend data from the HTML element
    const trendDataElement = document.getElementById('trend-data');
    const trendData = JSON.parse(trendDataElement.getAttribute('data-trend-data'));

    // Extract labels and data from the parsed trend data
    const labels = Object.keys(trendData);
    const data = Object.values(trendData);

    // Get the canvas element
    const canvas = document.getElementById('trendChart');
    const ctx = canvas.getContext('2d');

    // Draw the line chart
    function drawLineChart(ctx, labels, data) {
        const chartWidth = canvas.width;
        const chartHeight = canvas.height;

        // Define chart area
        ctx.clearRect(0, 0, chartWidth, chartHeight);
        ctx.strokeStyle = '#4CAF50'; // Line color
        ctx.lineWidth = 2;
        ctx.font = '12px Arial';

        // Draw x and y axes
        ctx.beginPath();
        ctx.moveTo(40, 10);
        ctx.lineTo(40, chartHeight - 30);
        ctx.lineTo(chartWidth - 10, chartHeight - 30);
        ctx.stroke();

        // Draw data points and lines
        ctx.beginPath();
        const xInterval = (chartWidth - 50) / (labels.length - 1);
        const yMax = Math.max(...data);
        const yScale = (chartHeight - 40) / yMax;

        data.forEach((point, index) => {
            const x = 40 + index * xInterval;
            const y = chartHeight - 30 - point * yScale;

            ctx.lineTo(x, y);
            ctx.arc(x, y, 3, 0, 2 * Math.PI);
        });

        ctx.stroke();

        // Draw labels
        labels.forEach((label, index) => {
            const x = 40 + index * xInterval;
            ctx.fillText(label, x - 10, chartHeight - 10);
        });
    }

    drawLineChart(ctx, labels, data);
});

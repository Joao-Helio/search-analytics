# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "chart.js", to: "https://cdn.jsdelivr.net/npm/chart.js"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "bootstrap", to: "https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
pin "analytics", to: "analytics.js"

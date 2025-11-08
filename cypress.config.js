const { defineConfig } = require('cypress');

module.exports = defineConfig({
  e2e: {
    baseUrl: 'http://localhost:3000', // FRONT
    supportFile: 'cypress/support/e2e.js',
    specPattern: 'cypress/e2e/**/*.cy.js',
    screenshotOnRunFailure: true,
    video: false,
    viewportWidth: 1366,
    viewportHeight: 768,
    defaultCommandTimeout: 8000,
    retries: { runMode: 2, openMode: 0 },
    env: {
      apiUrl: 'http://localhost:3000', // API base (pode ser outro host)
      apiPrefix: '/api',               // prefixo da API
      endpoints: {
        products: '/produtos',
        orders: '/pedidos'
      }
    },
    chromeWebSecurity: false
  }
});

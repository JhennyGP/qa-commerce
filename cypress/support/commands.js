import { el } from '../pages/elements';

// Helpers básicos
Cypress.Commands.add('getByTestId', (id) => cy.get(`[data-testid="${id}"]`));

// API helpers (front e api em hosts distintos)
Cypress.Commands.add('apiRequest', (method, path, body, options = {}) => {
  const apiUrl = Cypress.env('apiUrl');
  const apiPrefix = Cypress.env('apiPrefix') || '';
  const url = `${apiUrl}${apiPrefix}${path}`;
  return cy.request({ method, url, body, failOnStatusCode: false, ...options });
});

Cypress.Commands.add('apiGet', (path, options = {}) => cy.apiRequest('GET', path, null, options));
Cypress.Commands.add('apiPost', (path, payload, options = {}) => cy.apiRequest('POST', path, payload, options));

// Fluxos UI reutilizáveis
// Cypress.Commands.add('addToCartByName', (productName) => {
//   cy.contains(el.home.productCard, productName)
//     .within(() => cy.get(el.home.addToCart).click());
//   cy.get(el.home.cartBadge).should('be.visible');
// });

Cypress.Commands.add('openCart', () => {
  cy.get(el.home.cartLink).click();
  cy.url().should('include', '/cart');
});

Cypress.Commands.add('goToCheckout', () => {
  cy.get(el.cart.checkoutLink).click();
  cy.url().should('include', '/checkout');
});

Cypress.Commands.add('fillCheckout', (customer, paymentLabel = 'Pix') => {
  cy.get(el.checkout.inputs.firstName).clear().type(customer.firstName);
  cy.get(el.checkout.inputs.lastName).clear().type(customer.lastName);
  cy.get(el.checkout.inputs.email).clear().type(customer.email);
  cy.get(el.checkout.inputs.document).clear().type(customer.document);
  cy.get(el.checkout.inputs.phone).clear().type(customer.phone);
  cy.get(el.checkout.inputs.zip).clear().type(customer.zip);
  cy.get(el.checkout.inputs.address).clear().type(customer.address);
  cy.get(el.checkout.inputs.number).clear().type(customer.number);
  cy.get(el.checkout.inputs.city).clear().type(customer.city);
  cy.get(el.checkout.inputs.state).clear().type(customer.state);
  cy.contains(`${el.checkout.paymentMethod} label`, paymentLabel).click();
});

Cypress.Commands.add('placeOrder', () => {
  cy.get(el.checkout.placeOrder).click();
});

Cypress.Commands.add('assertCartLine', ({ name, unitPrice, qty = 1 }) => {
  cy.contains(el.cart.cartItem, name).within(() => {
    cy.get(el.cart.itemQty).should('have.text', String(qty));
    if (unitPrice != null) {
      cy.get(el.cart.itemUnitPrice).invoke('text').then((t) => {
        const price = Number(t.replace(/[^\d,]/g, '').replace(',', '.'));
        expect(price).to.be.closeTo(unitPrice, 0.01);
      });
      cy.get(el.cart.itemSubtotal).invoke('text').then((t) => {
        const subtotal = Number(t.replace(/[^\d,]/g, '').replace(',', '.'));
        expect(subtotal).to.be.closeTo(unitPrice * qty, 0.01);
      });
    }
  });
});

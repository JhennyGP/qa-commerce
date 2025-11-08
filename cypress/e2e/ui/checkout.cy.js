import Home from '../../pages/home.page';
import Checkout from '../../pages/checkout.page';
import { el } from '../../pages/elements';

describe('Checkout simples', () => {
  beforeEach(() => {
    cy.fixture('customer').as('cust');
  });

  const addFirstItemToCart = () => {
    Home.visit();
    Home.firstCard().as('card');
    Home.addButtonIn(cy.get('@card')).click({ force: true });
  };

  const goToCheckout = () => {
    Home.cartLink().click();
    cy.url().should('include', '/cart');
    cy.get(el.cart.checkoutLink).first().click({ force: true });
    cy.url().should('include', 'checkout');
  };

  it('adiciona 1 item, preenche obrigatórios, escolhe PIX, aceita termos e finaliza', function () {
    addFirstItemToCart();
    goToCheckout();

    Checkout.firstName().type(this.cust.firstName);
    Checkout.lastName().type(this.cust.lastName);
    Checkout.email().type(this.cust.email);
    Checkout.address().type(this.cust.address);
    Checkout.number().type(String(this.cust.number));
    Checkout.zip().type(this.cust.zip);
    Checkout.pix().check({ force: true });
    Checkout.terms().check({ force: true });
    Checkout.submit().click({ force: true });

    cy.url().should('include', '/status.html');
    cy.location('search').then((q) => {
      const id = new URLSearchParams(q).get('orderId');
      expect(id).to.match(/^\d+$/);
    });
    cy.contains('h1,h2', /status do pedido/i).should('be.visible');
    cy.contains(/obrigado pelo seu pedido/i).should('be.visible');
    cy.contains(/id do pedido\s*:/i).should('exist');
    cy.contains(/total\s*:\s*r\$\s*\d+[.,]\d{2}/i).should('exist');
    cy.contains(/status\s*:\s*(pagamento aprovado|conclu[ií]do)/i).should('exist');
  });
});

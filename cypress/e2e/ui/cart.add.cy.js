import Home from '../../pages/home.page';
import { el } from '../../pages/elements';

describe('Adiciona produto ao carrinho (Home)', () => {
  beforeEach(() => {
    Home.visit();
  });

  it('seleciona o primeiro card e adiciona ao carrinho', () => {
    Home.firstCard().as('card');

    cy.get('@card')
      .find(el.home.addToCart)
      .invoke('attr', 'data-id')
      .then((id) => {
        expect(id, 'data-id no card').to.exist;
        cy.wrap(String(id)).as('productId');
      });

    Home.addButtonIn(cy.get('@card')).click({ force: true });

    Home.cartLink().click();
    cy.url().should('include', '/cart');

    cy.get('@productId').then((id) => {
      const rowSel = [
        '#cart tbody tr',
        '[data-testid="cart-item"]',
        '.cart-item',
        '.list-group .list-group-item'
      ].join(', ');

      const linkSel = `a[href*="product.html?id=${id}"]`;

      cy.get('body').then(($b) => {
        if ($b.find(linkSel).length) {
          cy.get(linkSel).closest(rowSel).as('line');
        } else {
          expect($b.find(rowSel).length, 'ao menos 1 item no carrinho').to.be.greaterThan(0);
          cy.get(rowSel).first().as('line');
        }
      });
    });
  });
});

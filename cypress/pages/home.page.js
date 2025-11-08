import { el } from './elements';

class HomePage {
  visit() { cy.visit('/'); }
  firstCard() { return cy.get(el.home.productCard).first(); }
  addButtonIn(card) { return card.find(el.home.addToCart).first(); }
  cartLink() { return cy.contains('a,button', /carrinho/i).first(); }
}
export default new HomePage();

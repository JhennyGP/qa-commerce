import { el } from './elements';

class CheckoutPage {
  firstName() { return cy.get(el.checkout.firstName); }
  lastName() { return cy.get(el.checkout.lastName); }
  email() { return cy.get(el.checkout.email); }
  address() { return cy.get(el.checkout.address); }
  number() { return cy.get(el.checkout.number); }
  zip() { return cy.get(el.checkout.zip); }
  pix() { return cy.get(el.checkout.paymentPix); }
  terms() { return cy.get(el.checkout.terms); }
  submit() { return cy.get(el.checkout.submit); }
  successMsg() { return cy.get(el.checkout.success); }
}
export default new CheckoutPage();

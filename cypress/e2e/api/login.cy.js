describe('API - Usuarios e Login', () => {
  it('POST /users', () => {
    const usersPath = Cypress.env('endpoints').users;
    const loginPath = Cypress.env('endpoints').login;

    const email = `qa_${Date.now()}@example.com`;
    const password = 'Password123!';
    const userBody = { name: 'Jhenny', email, password, isAdmin: false };

    cy.apiPost(usersPath, userBody).then((resCreate) => {
      expect('201').to.include(resCreate.status);

      const bodyCreate = resCreate.body || {};

      expect(bodyCreate).to.have.property('id').and.to.be.a('number');
      if (bodyCreate.message) {
        expect(String(bodyCreate.message).toLowerCase()).to.include('sucesso');
      }


      cy.apiPost(loginPath, { email, password }).then((resLogin) => {
        expect(resLogin.status).to.eq(200);

        const bodyLogin = resLogin.body || {};
        expect(bodyLogin).to.have.all.keys('id', 'name', 'token');
        expect(bodyLogin.token).to.be.a('string').and.not.empty;

        Cypress.env('authToken', bodyLogin.token);
      });
    });
  });
});

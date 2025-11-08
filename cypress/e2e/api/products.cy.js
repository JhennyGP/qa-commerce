describe('API - Produtos', () => {
  it('GET /produtos', () => {
    const productsPath = Cypress.env('endpoints').products;

    cy.apiGet(`${productsPath}?page=1&limit=10`).then((res) => {
      expect(res.status).to.eq(200);

      const body = res.body || {};
      expect(body).to.have.property('products').and.to.be.an('array');
      expect(body).to.have.property('totalPages').and.to.be.a('number');
      expect(body).to.have.property('currentPage', 1);
      expect(body.products.length).to.be.at.most(10);
    });

    const page = 2;
    const limit = 3;

    cy.apiGet(`${productsPath}?page=${page}&limit=${limit}`).then((res) => {
      expect(res.status).to.eq(200);

      const body = res.body || {};
      expect(body).to.have.property('currentPage', page);
      expect(body).to.have.property('products').and.to.be.an('array');
      expect(body.products.length).to.be.at.most(limit);

      if (page < body.totalPages) {
        expect(body.products.length).to.eq(limit);
      }
    });
  });
});

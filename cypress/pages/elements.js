export const el = {
  home: {
    productList: '#product-list',
    productCard: '#product-list .card',
    productName: 'legend',
    addToCart: '.add-to-cart'
  },
  cart: {
    cartItem: '#cart tbody tr',
    itemQty: 'td.qty',
    itemUnitPrice: 'td.price',
    itemSubtotal: 'td.subtotal',
    checkoutLink: 'a[href*="checkout"]'
  },
  checkout: {
    firstName: '#first-name',
    lastName: '#last-name',
    email: 'input[type="email"]',
    address: '#address',
    number: '#number',
    zip: '#cep',
    paymentPix: '#payment-pix',
    terms: '#terms',
    submit: 'button.btn.btn-primary',
    success: '[data-testid="order-success"], #order-success, .alert-success'
  }
};

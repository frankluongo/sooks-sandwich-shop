export default class BillingPage {
  constructor() {
    if (this.sameAsShipping === null) {
      return;
    }
    this.observeSameAsShipping();
  }

  observeSameAsShipping() {
    this.sameAsShipping.addEventListener(
      'change',
      this.handleSameAsShippingChange.bind(this),
    );
  }

  handleSameAsShippingChange(event) {
    this.toggleBillingAddress(event.target.checked);
  }

  toggleBillingAddress(state) {
    this.billingAddress.setAttribute('aria-hidden', state);
  }

  get billingAddress() {
    return document.querySelector('[data-js="BillingPage.BillingAddress"]');
  }

  get sameAsShipping() {
    return document.querySelector('[data-js="BillingPage.SameAsShipping"]');
  }
}

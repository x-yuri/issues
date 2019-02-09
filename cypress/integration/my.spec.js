describe('test case', function() {
    [...Array(2).keys()].forEach(function() {
        it('produces 400 error', function() {
            cy.visit('http://localhost:9000/order');
            cy.get('#order-button').click();
            cy.get('body').should('contain', 'Thank you');
            cy.request('POST', 'http://localhost:9000/login');
            cy.wait(2000)   // for requests to finish (quick and dirty)
        });
    });
});

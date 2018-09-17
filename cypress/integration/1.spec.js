describe('...', () => {
    beforeEach(() => {
        cy.fixture('1.txt').as('f1');
    });

    it('...', function() {
        cy.log(this.f1);
    });
});

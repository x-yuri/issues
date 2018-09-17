describe('...', () => {
    it('...', () => {
        cy.fixture('1.txt').then(content => {
            cy.log(content);
            cy.writeFile('cypress/fixtures/1.txt', String(Number(content) + 1));
        })
        cy.fixture('1.txt').then(content => {
            cy.log(content);
        });
    });
});

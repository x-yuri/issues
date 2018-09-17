describe('My First Test', function() {
  it('Visits the test site', function() {
    cy.visit('http://localhost:33333');
    cy.get('select').select('1');
    cy.get('select').should('have.value', '1');
    cy.get('input').type('test');
  })
})

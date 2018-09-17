describe('then', function() {
    specify('aliases work', function () {
        cy.wrap(1).as('myAlias');
        cy.wrap(2).then(function(subj) {
            expect(this.myAlias).to.eq(1); // undefined
        });
    });
})

```
$ git clone -b cypress-overwrite https://github.com/x-yuri/issues cypress-overwrite
$ cd cypress-overwrite
$ yarn
$ ./node_modules/.bin/cypress open
```

`1.spec.js`:

```js
describe('then', function() {
    specify('aliases work', function () {
        cy.wrap(1).as('myAlias');
        cy.wrap(2).then(function(subj) {
            expect(this.myAlias).to.eq(1); // undefined
        });
    });
})
```

![](https://i.imgur.com/N0FttfE.png)

`2.spec.js`:

```js
Cypress.Commands.overwrite('then', function(originalCommand, subject, fn, options = {}) {
    return originalCommand.call(this, subject, options, fn);
});

describe('then', function() {
    specify('aliases work', function () {
        cy.wrap(1).as('myAlias');
        cy.wrap(2).then(function(subj) {
            expect(this.myAlias).to.eq(1); // undefined
        });
    });
})
```

![](https://i.imgur.com/PB5CKJ3.png)

Issue: https://github.com/cypress-io/cypress/issues/5101

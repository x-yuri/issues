## `cypress`: uploading files (traditional forms)

```html
<form enctype="multipart/form-data" action="/upload" method="post">
    <input name="file" type="file">
    <input type="submit">
</form>
```

### [`cypress-file-upload`][7] package

`cypress/integration/1.spec.js`:

```js
import 'cypress-file-upload';

const fileName = 'upload.png';
cy.fixture(fileName).then(fileContent => {
    cy.get('input[type="file"]')
        .upload({fileContent, fileName, mimeType: 'image/png'});
});
cy.get('input[type="submit"]').click();
```

[7]: https://github.com/abramenal/cypress-file-upload

### NIH

`cypress/support/commands.js`:

```js
Cypress.Commands.add('attachFile', {
    prevSubject: 'element',
}, ($input, fname, type) => {
    cy.fixture(fname).then(Cypress.Blob.base64StringToBlob).then(blob => {
        const file = new File([blob], fname, {type});
        const dt = new DataTransfer;
        dt.items.add(file);
        $input[0].files = dt.files;
    });
});
```

`cypress/integration/1.spec.js`:

```js
cy.get('input[type="file"]')
    .attachFile('upload.png', 'image/png');
cy.get('input[type="submit"]').click()
```

### NIH (binary encoding)

`cypress/support/commands.js`:

```js
Cypress.Commands.add('attachFile', {
    prevSubject: 'element',
}, ($input, fname, type) => {
    cy.fixture(fname, 'binary').then(content => {
        content = Uint8Array.from(content, x => x.charCodeAt(0))
        const file = new File([content], fname, {type});
        const dt = new DataTransfer;
        dt.items.add(file);
        $input[0].files = dt.files;
    });
});
```

`cypress/integration/1.spec.js`:

```js
cy.get('input[type="file"]')
    .attachFile('/upload.png', 'image/png');
cy.get('input[type="submit"]').click()
```

### [`cypress-form-data-with-file-upload`][8] package

It attaches `submit` handler to the form, where it cancels the default behavior,
sends an XHR requests with the data and [writes][1] the response
into the AUT's iframe. The last bit discards event handlers that Cypress
has attached.
For all subsequent tests, subsequent runs, until you close the runner window.
E.g. [`onsubmit`][2] handler [adds][3] ["FORM SUB"][4] log entry,
`onbeforeunload` makes it [wait][5] for the page to [load][6] before proceeding
to the next test, and adds "PAGE LOAD" log entry. I view it as a deal-breaker,
considering there are better solutions.

[1]: https://github.com/bahmutov/cypress-form-data-with-file-upload/blob/v1.0.0/index.js#L46

[2]: https://github.com/cypress-io/cypress/blob/v3.6.1/packages/driver/src/cypress/cy.coffee#L144
[3]: https://github.com/cypress-io/cypress/blob/v3.6.1/packages/driver/src/cypress.coffee#L388
[4]: https://github.com/cypress-io/cypress/blob/v3.6.1/packages/driver/src/cy/commands/navigation.coffee#L146

[5]: https://github.com/cypress-io/cypress/blob/v3.6.1/packages/driver/src/cypress/cy.coffee#L146
[6]: https://github.com/cypress-io/cypress/blob/v3.6.1/packages/driver/src/cypress/cy.coffee#L410

[8]: https://github.com/bahmutov/cypress-form-data-with-file-upload

### Running locally

Console 1:

```
$ git clone -b cypress-classic-form-file-upload https://github.com/x-yuri/issues cypress-classic-form-file-upload
$ cd $_
$ npm i
$ node server.js
```

Console 2:

```
$ npx cypress open
```

### Links

https://github.com/cypress-io/cypress/issues/170#issuecomment-558874692<br>
https://github.com/cypress-io/cypress/issues/1558#issuecomment-559735099

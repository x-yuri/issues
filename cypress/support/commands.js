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

Cypress.Commands.add('attachFileBin', {
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

import 'cypress-file-upload';
const attachFiles = require('cypress-form-data-with-file-upload');

describe('file uploads', function() {
    beforeEach(() => {
        cy.exec('rm uploads/*', {failOnNonZeroExit: false});
    });

    specify('nih', function() {
        cy.visit('localhost:3000');
        cy.get('input[type="file"]')
            .attachFile('upload.png', 'image/png');
        cy.get('input[type="submit"]').click()
    });

    specify('nih (binary)', function() {
        cy.visit('localhost:3000')
        // filename starts with / to avoid using the cached value of the fixture
        // only this test demands the fixture in a binary encoding
        cy.get('input[type="file"]')
            .attachFileBin('/upload.png', 'image/png');
        cy.get('input[type="submit"]').click()
    });

    specify('cypress-file-upload', function() {
        const fileName = 'upload.png';
        cy.visit('localhost:3000');
        cy.fixture(fileName).then(fileContent => {
            cy.get('input[type="file"]')
                .upload({fileContent, fileName, mimeType: 'image/png'});
        });
        cy.get('input[type="submit"]').click();
    });

    specify('cypress-form-data-with-file-upload', function() {
        const fname = 'upload.png';
        cy.visit('localhost:3000');
        cy.fixture(fname)
            .then(Cypress.Blob.base64StringToBlob)
            .then(content => {
                cy.get('form').then(attachFiles({
                    file: new File([content], fname, {
                        type: 'image/png',
                    })
                }));
            });
        cy.get('input[type="submit"]').click()
    });
});

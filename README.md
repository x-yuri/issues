### Usage

```
$ git clone -b cypress-screenshots-run-open https://github.com/x-yuri/issues cypress-screenshots-run-open
$ cd cypress-screenshots-run-open
$ npm i
$ npx cypress run -b electron
$ mv 'cypress/screenshots/1.spec.js/ -- .png' run.png
$ npx cypress open
// Choose Electron 73, run the 1.spec.js spec
$ mv 'cypress/screenshots/1.spec.js/ -- .png' open.png
```

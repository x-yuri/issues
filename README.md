### Usage

```
$ git clone -b cypress-change-fixture-2 https://github.com/x-yuri/issues cypress-change-fixture-2
$ cd cypress-change-fixture-2
$ npm i
$ npx cypress open
```

Choose 1.spec.js, and you'll see:

![](https://i.imgur.com/RDLxFER.png)

```
echo 2 > cypress/fixtures/1.txt
```

Press "r" (Run All Tests), and you'll see:

![](https://i.imgur.com/fLe3Sup.png)

### References

https://github.com/cypress-io/cypress/issues/4716#issuecomment-568918731

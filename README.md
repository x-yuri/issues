```
$ git clone -b cypress-snapshots https://github.com/x-yuri/issues cypress-snapshots
$ cd cypress-snapshots
$ yarn
# console 1
$ yarn serve
# console 2
$ yarn open-cypress
# run the spec
```

The state after running the spec is as expected:

![](https://i.imgur.com/ZOVVvtr.png)

But then I hover over the last command:

![](https://i.imgur.com/bYF4Egb.png)

Or pin it:

![](https://i.imgur.com/VGZCJZJ.png)

It's as if the select's value never changed.

Issue: https://github.com/cypress-io/cypress/issues/4443

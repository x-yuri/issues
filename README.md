### Steps to reproduce

    $ npm --version
    6.9.0

    $ cd current
    $ npm i
    npm WARN current No description
    npm WARN current No repository field.
    npm WARN current No license field.

    added 2 packages from 2 contributors and audited 2 packages in 0.535s
    found 0 vulnerabilities

    $ npm ls
    /home/yuri/prj/issues/current
    ├── path-parse@1.0.6 extraneous
    └─┬ resolve@1.9.0
      └── UNMET DEPENDENCY path-parse@^1.0.6

    npm ERR! extraneous: path-parse@1.0.6 /home/yuri/prj/issues/current/node_modules/path-parse
    npm ERR! missing: path-parse@^1.0.6, required by resolve@1.9.0

    $ npm i
    npm WARN current No description
    npm WARN current No repository field.
    npm WARN current No license field.

    moved 1 package and audited 2 packages in 0.559s
    found 0 vulnerabilities

    $ npm ls
    /home/yuri/prj/issues/current
    └─┬ resolve@1.9.0
      └── path-parse@1.0.6

    $ git diff
    diff --git a/current/package-lock.json b/current/package-lock.json
    index a7551f0..07a0808 100644
    --- a/current/package-lock.json
    +++ b/current/package-lock.json
    @@ -2,17 +2,19 @@
       "requires": true,
       "lockfileVersion": 1,
       "dependencies": {
    -    "path-parse": {
    -      "version": "1.0.6",
    -      "resolved": "https://registry.npmjs.org/path-parse/-/path-parse-1.0.6.tgz",
    -      "integrity": "sha512-GSmOT2EbHrINBf9SR7CDELwlJ8AENk3Qn7OikK4nFYAu3Ote2+JYNVvkpAEQm3/TLNEJFD/xZJjzyxg3KBWOzw=="
    -    },
         "resolve": {
           "version": "1.9.0",
           "resolved": "https://registry.npmjs.org/resolve/-/resolve-1.9.0.tgz",
           "integrity": "sha512-TZNye00tI67lwYvzxCxHGjwTNlUV70io54/Ed4j6PscB8xVfuBJpRenI/o6dVk0cY0PYTY27AgCoGGxRnYuItQ==",
           "requires": {
             "path-parse": "^1.0.6"
    +      },
    +      "dependencies": {
    +        "path-parse": {
    +          "version": "1.0.6",
    +          "resolved": "https://registry.npmjs.org/path-parse/-/path-parse-1.0.6.tgz",
    +          "integrity": "sha512-GSmOT2EbHrINBf9SR7CDELwlJ8AENk3Qn7OikK4nFYAu3Ote2+JYNVvkpAEQm3/TLNEJFD/xZJjzyxg3KBWOzw=="
    +        }
           }
         }
       }

[Related issue][1].

[1]: https://npm.community/t/npm-ls-produces-false-negative-missing-dependencies-when-node-modules-dir-is-symlinked/7895

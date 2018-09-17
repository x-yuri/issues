### How to reproduce the issue

    npm i
    // change version in package.json to ^1.10.0
    npm up
    npm up --save-dev  # this way it updates the dependency
    
### How this repository was created

    echo {} > package.json
    npm i resolve@1.9.0 -D

[Related issue][1].

[1]: https://npm.community/t/npm-update-doesnt-always-update-development-dependencies/7886

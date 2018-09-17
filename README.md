### Steps to reproduce

    $ cd root
    $ npm i
    $ ./node_modules/.bin/webpack --mode development
    Module not found: Error: Can't resolve '../bootstrap-sass/assets/stylesheets/bootstrap/fonts/glyphicons-halflings-regular.eot' in '/.../root/node_modules/bootstrap-loader'

    // uncomment line in src/bootstrap-customizations.scss
    $ ./node_modules/.bin/webpack --mode development
    // succeeds

https://github.com/shakacode/bootstrap-loader/issues/359#issue-360569255

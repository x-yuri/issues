### Steps to reproduce

    $ npm i
    $ ./node_modules/.bin/webpack --mode development
    Module not found: Error: Can't resolve '../bootstrap-sass/assets/stylesheets/bootstrap-sass/assets/fonts/bootstrap/glyphicons-halflings-regular.woff2' in '/.../node_modules/bootstrap-loader'

    // uncomment line in src/bootstrap-customizations.scss
    $ ./node_modules/.bin/webpack --mode development
    // succeeds

https://github.com/shakacode/bootstrap-loader/issues/359#issue-360569255

### Steps to reproduce

    $ git clone -b bootstrap-loader-node-modules-symlink git@github.com:x-yuri/issues.git 1
    $ cd 1
    $ npm i
    $ mkdir ../2
    $ mv node_modules ../2
    $ ln -s ../2/node_modules node_modules
    $ ./node_modules/.bin/webpack --mode development

    ERROR in ../2/node_modules/bootstrap-loader/no-op.js (../2/node_modules/bootstrap-loader/lib/bootstrap.loader.js!../2/node_modules/bootstrap-loader/no-op.js)
    Module build failed (from ../2/node_modules/bootstrap-loader/lib/bootstrap.loader.js):
    Error: Could not resolve module 'bootstrap-sass' which must be installed when bootstrap version is configured to v3.
    You must install 'bootstrap' for bootstrap v4 or 'bootstrap-sass' for bootstrap v3.
    You can also specify the location manually by specifying 'bootstrapPath' in bootstrap-loader's query string.
    See https://github.com/shakacode/bootstrap-loader/blob/master/README.md#usage.
        at Object.module.exports.pitch (/.../2/node_modules/bootstrap-loader/lib/bootstrap.loader.js:148:11)
     @ ../2/node_modules/bootstrap-loader/loader.js 2:17-61
     @ ./src/index.js

It can't find `.bootstraprc`, so it falls back to default `.bootstraprc-3-default`.

https://github.com/shakacode/bootstrap-loader/issues/353#issuecomment-430190179

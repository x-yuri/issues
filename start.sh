#!/usr/bin/env bash
set -eu
webpack_version=$1
mode=$2
bootstrap_version=$3
[ "$mode" = production ] && extract_styles=true || extract_styles=false

cd "webpack-$webpack_version"
if ! [ -d node_modules ]; then
    yarn
fi

if [ "$webpack_version" = 4 ] && [ "$mode" = production ]; then
    styleLoaders="styleLoaders:
  - css-loader?sourceMap=true
  - sass-loader?sourceMap=true"
elif [ "$webpack_version" = 4 ] && [ "$mode" = development ]; then
    styleLoaders="styleLoaders:
  - style-loader?sourceMap=true
  - css-loader?sourceMap=true
  - sass-loader?sourceMap=true"
elif [ "$webpack_version" = 3 ] && [ "$mode" = production ]; then
    styleLoaders="styleLoaders:
  - style-loader?sourceMap=true
  - css-loader?sourceMap=true&minimize
  - sass-loader?sourceMap=true"
elif [ "$webpack_version" = 3 ] && [ "$mode" = development ]; then
    styleLoaders="styleLoaders:
  - style-loader?sourceMap=true
  - css-loader?sourceMap=true
  - sass-loader?sourceMap=true"
fi
if [ "$bootstrap_version" = 4 ]; then
    styles="styles:
  mixins: true
  buttons: true
  alert: true
    "
else
    styles="styles:
  mixins: true
  buttons: true
  alerts: true
    "
fi
echo "---
bootstrapVersion: $bootstrap_version
useCustomIconFontPath: true
$styleLoaders
extractStyles: $extract_styles
$styles
" > .bootstraprc

node - "$webpack_version" "$mode" <<\SCRIPT
    const opn = require('opn');
    const portfinder = require('portfinder');
    const supportsColor = require('supports-color');

    const webpack_version = process.argv[2];
    const mode = process.argv[3];

    const webpack = require('webpack');
    const webpackDevServer = require('webpack-dev-server');
    const config = webpack_version == 4
        ? require('./webpack.config.js')(null, {mode})
        : require('./webpack.config.js')(mode);
    const compiler = webpack(Object.assign(config,
        webpack_version == 4
            ? {mode}
            : {}));
    const server = new webpackDevServer(compiler, {
        stats: {
            cached: false,
            cachedAssets: false,
            modules: false,
            colors: supportsColor,
            entrypoints: false,
        },
    });
    portfinder.getPort((err, port) => {
        if (err) throw err;
        server.listen(port, 'localhost', err => {
            if (err) throw err;
            opn(`http://localhost:${port}`);
        });
    });
SCRIPT

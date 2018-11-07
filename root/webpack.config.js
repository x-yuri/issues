const webpack = require('webpack');
const path = require('path');

module.exports = {
    module: {
        rules: [{
            test: /\.(svg|eot|woff|woff2|ttf)$/,
            use: 'file-loader',
        }],
    },
    plugins: [
        new webpack.DefinePlugin({
            BOOTSTRAP_CONFIG: JSON.stringify(path.join(__dirname, '.bootstraprc')),
        }),
    ],
};

module.exports = {
    module: {
        rules: [{
            test: /\.(svg|eot|woff|woff2|ttf)$/,
            use: 'file-loader',
        }],
    },
};

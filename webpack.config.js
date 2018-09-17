const HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = (env, argv) => {
    return {
        module: {
            rules: [{
                test: /\.css$/,
                use: [
                    'style-loader',
                    'css-loader',
                ],
            }, {
                test: /\.sass$/,
                use: [
                    'style-loader?',
                    'css-loader',
                    'sass-loader',
                ],
            }],
        },
        plugins: [
            new HtmlWebpackPlugin({
                template: 'src/index.html',
            }),
        ],
    };
};

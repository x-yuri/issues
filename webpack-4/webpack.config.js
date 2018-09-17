const HtmlWebpackPlugin = require('html-webpack-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const OptimizeCSSAssetsPlugin = require('optimize-css-assets-webpack-plugin');
const UglifyJsPlugin = require('uglifyjs-webpack-plugin');

module.exports = (env, argv) => {
    const extract = argv.mode == 'production';
    return {
        module: {
            rules: [Object.assign({
                test: /\.css$/,
            }, extract
                ? {use: [MiniCssExtractPlugin.loader, 'css-loader?sourceMap=true']}
                : {use: [
                    'style-loader?sourceMap=true',
                    'css-loader?sourceMap=true',
                ]}
            ), Object.assign({
                test: /\.sass$/,
            }, extract
                ? {use: [
                    MiniCssExtractPlugin.loader,
                    'css-loader?sourceMap=true',
                    'sass-loader?sourceMap=true',
                ]}
                : {use: [
                    'style-loader?sourceMap=true',
                    'css-loader?sourceMap=true',
                    'sass-loader?sourceMap=true',
                ]}
            )],
        },
        plugins: [
            new HtmlWebpackPlugin({
                template: 'src/index.html',
            }),
        ].concat(extract ?
            new MiniCssExtractPlugin
        : []),
        devtool: 'source-map',
        optimization: Object.assign(argv.mode == 'production'
            ? {minimizer: [
                new UglifyJsPlugin({
                    sourceMap: true,
                }),
                new OptimizeCSSAssetsPlugin({
                    cssProcessorOptions: {
                        map: {inline: false, annotation: true},
                    },
                }),
            ]}
            : {}
        ),
    };
};

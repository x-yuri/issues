const webpack = require('webpack');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const ExtractTextPlugin = require('extract-text-webpack-plugin');
const path = require('path');

module.exports = env => {
    const extract = env == 'production';
    const minimize = env == 'production' ? '&minimize' : '';
    return {
        entry: path.resolve('src/index.js'),
        output: {
            filename: 'main.js',
            path: path.resolve('dist'),
        },
        module: {
            rules: [Object.assign({
                test: /\.css$/,
            }, extract
                ? {use: ExtractTextPlugin.extract('css-loader?sourceMap=true' + minimize)}
                : {use: [
                    'style-loader?sourceMap=true',
                    'css-loader?sourceMap=true' + minimize,
                ]}),
            Object.assign({
                test: /\.sass$/,
            }, extract
                ? {use: ExtractTextPlugin.extract([
                    'css-loader?sourceMap=true' + minimize,
                    'sass-loader?sourceMap=true',
                ].join('!'))}
                : {use: [
                    'style-loader?sourceMap=true',
                    'css-loader?sourceMap=true' + minimize,
                    'sass-loader?sourceMap=true',
                ]})]
        },
        devtool: 'source-map',
        plugins: [
            new HtmlWebpackPlugin({
                template: 'src/index.html',
            }),
        ].concat(extract ?
            [new ExtractTextPlugin('main.css')]
        : [], env == 'production' ?
            [new webpack.optimize.UglifyJsPlugin({
                sourceMap: true
            })]
        : []),
    };
};

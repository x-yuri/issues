[`src/index.js`][1]:

[1]: src/index.js

```js
import './1.css';
```

[`src/1.css`][2]:

[2]: src/1.css

```css
@import './2.css';
@import './2.min.css';
body::before {
    content: "1.css";
}
```

[`src/2.css`][3]:

[3]: src/2.css

```css
body::before {
    content: "2.css";
}
```

[`src/2.min.css`][4]:

[4]: src/2.min.css

```css
body::before {
    content: "2.min.css";
}
```

[`webpack.config.js`][5]:

[5]: webpack.config.js

```js
const MiniCssExtractPlugin = require('mini-css-extract-plugin');

module.exports = {
    mode: 'production',
    module: {
        rules: [{
            test: /\.css$/,
            use: [
                MiniCssExtractPlugin.loader,
                'css-loader'
            ],
        }],
    },
    plugins: [
        new MiniCssExtractPlugin,
    ],
};
```

```
$ npm i
$ ./node_modules/.bin/webpack
$ cat dist/main.css
body::before {
    content: "2.css";
}

body::before {
    content: "2.min.css";
}

body::before {
    content: "1.css";
}
```

Changing order:

```js
@import './2.min.css';
@import './2.css';
body::before {
    content: "1.css";
}
```

```
$ ./node_modules/.bin/webpack
$ cat dist/main.css
body::before {
    content: "2.min.css";
}

body::before {
    content: "2.css";
}

body::before {
    content: "1.css";
}
```

https://github.com/webpack-contrib/extract-text-webpack-plugin/issues/200#issuecomment-429157446

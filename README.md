[`src/index.js`][1]:

[1]: src/index.js

```js
import './1.css';
import './1.min.css';
```

[`src/1.css`][2]:

[2]: src/1.css

```css
body::before {
    content: "1.css";
}
```

[`src/1.min.css`][3]:

[3]: src/1.min.css

```css
body::before {
    content: "1.min.css";
}
```

[`webpack.config.js`][4]:

[4]: webpack.config.js

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
    content: "1.css";
}

body::before {
    content: "1.min.css";
}
```

Changing order:

```js
import './1.min.css';
import './1.css';
```

```
$ ./node_modules/.bin/webpack
$ cat dist/main.css
body::before {
    content: "1.min.css";
}

body::before {
    content: "1.css";
}

```

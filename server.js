const express = require('express');
const multer = require('multer');
const morgan = require('morgan');

const app = express();

app.set('view engine', 'pug');
app.set('views', '.');

app.use(morgan('tiny'));

app.use(express.static(__dirname));

const storage = multer.diskStorage({
  destination: 'uploads/',
  filename: function (req, file, cb) {
    cb(null, file.originalname)
  }
});
const upload = multer({ storage });

app.post('/upload', upload.single('file'), function (req, res) {
    res.render('./upload', {fname: req.file.originalname});
});

app.listen(3000);

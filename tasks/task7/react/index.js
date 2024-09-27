const express = require('express');

const PORT = 4040;
const app = express();

app.get('/',(req, res) => res.send('<h1> hello world<h1>'));

app.listen(PORT, () => console.log(`app is up and running on port ${PORT}`));
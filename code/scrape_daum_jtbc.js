// scrape_daum_jtbc.js

var webPage = require('webpage');
var page = webPage.create();

var fs = require('fs');
var path = 'data/daum_jtbc.html';

page.open('http://movie.daum.net/tv/ratings?tvProgramId=66868', function (status) {
  var content = page.content;
  page.render('fig/daum_jtbc.png');
  fs.write(path, content, 'w');
  phantom.exit();
});
// scrape_daum_mbc.js

var webPage = require('webpage');
var page = webPage.create();

var fs = require('fs');
var path = 'data/daum_mbc.html';

page.open('http://movie.daum.net/tv/ratings?tvProgramId=48135', function (status) {
  var content = page.content;
  page.render('fig/daum_mbc.png');
  fs.write(path, content, 'w');
  phantom.exit();
});
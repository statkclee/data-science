// scrape_daum_sbs.js

var webPage = require('webpage');
var page = webPage.create();

var fs = require('fs');
var path = 'data/daum_sbs.html';

page.open('http://movie.daum.net/tv/ratings?tvProgramId=48152', function (status) {
  var content = page.content;
  page.render('fig/daum_sbs.png');
  fs.write(path, content, 'w');
  phantom.exit();
});
// scrape_itemmania.js

var webPage = require('webpage');
var page = webPage.create();

var fs = require('fs');
var path = 'data/daum_kt_stock.html';

page.open('http://finance.daum.net/item/quote.daum?code=030200', function (status) {
  var content = page.content;
  page.render('fig/daum_kt_stock.png');
  fs.write(path, content, 'w');
  phantom.exit();
});
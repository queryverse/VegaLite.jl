'use strict';

// import required libraries
var fs = require('fs'),
    path = require('path'),
    vl = require('../deps/lib/vega-lite.min.js'),
    rw = require('../deps/node_modules/rw'),
    vega = require('../deps/lib/vega.min.js');

// set baseURL if provided on command line
var base = 'file://' + process.cwd() + path.sep;

// load spec, compile vg spec
rw.readFile('/dev/stdin', 'utf8', function(err, text) {
  if (err) throw err;
  var spec = JSON.parse(text);
  compile(spec);
});

function compile(vlSpec) {
  var result =  vl.compile(vlSpec);
  // TODO: deal with error
  var vgSpec = result.spec;

  var view = new vega.View(vega.parse(vgSpec), {
      loader: vega.loader({baseURL: base}),
      logLevel: vega.Warn,
      renderer: 'none'
    })
    .initialize()
    .toSVG()
    .then(function(svg) { writeSVG(svg); })
    .catch(function(err) { console.error(err); });
}

function writeSVG(svg) {
  rw.writeFile('/dev/stdout', svg, function(err) { if (err) throw err; });
}

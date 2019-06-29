var fs = require('fs');
var sourceMap = require('source-map');
var arguments = process.argv.splice(2);
console.log('所传递的参数是：', arguments);
var line = arguments[0];
var column = arguments[1];

fs.readFile('./main.sourcemap', 'utf8', function (err, data) {
var smc = new sourceMap.SourceMapConsumer(data);
console.log(smc.originalPositionFor({
            line: parseInt(line),
            column: parseInt(column)
        }));
});
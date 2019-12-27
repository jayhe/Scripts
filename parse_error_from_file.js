/**
 * node parse_error.js /json_path // 参数json文件路径
 */
var fs = require('fs');
var sourceMap = require('source-map');
var arguments = process.argv.splice(1);
console.log('所传递的参数是：', arguments);
var json_path = arguments[0];

fs.readFile('./main.sourcemap', 'utf8', function (err, data) {
var smc = new sourceMap.SourceMapConsumer(data);
console.log(smc.originalPositionFor({
            line: parseInt(line),
            column: parseInt(column)
        }));
});
/**
 * node parse_error.js line column // 参数为行号列号
 */
var fs = require('fs');
var sourceMap = require('source-map');
var arguments = process.argv.splice(2);
console.log('所传递的参数是：', arguments);
function parseJSError(aLine, aColumn) {
    fs.readFile('./main.sourcemap', 'utf8', function (err, data) {
        var smc = new sourceMap.SourceMapConsumer(data);
        let parseData = smc.originalPositionFor({
            line: parseInt(aLine),
            column: parseInt(aColumn)
        });
        // 输出到控制台
        console.log(parseData);
        // 输出到文件中
        fs.appendFile('./parsed.txt', JSON.stringify(parseData) + '\n', 'utf8', function(err) {  
            if(err) {  
                console.log(err);
            }
        });  
    });
}

var line = arguments[0];
var column = arguments[1];
parseJSError(line, column);
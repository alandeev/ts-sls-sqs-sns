// webpack.config.js
const slsw = require('serverless-webpack');

module.exports = {
  entry: slsw.lib.entries,
  mode: slsw.lib.webpack.isLocal ? "development" : "production",
  target: 'node',
  module: {
    rules: [
      {
        test: /\.ts$/,
        use: 'ts-loader',
        exclude: [/node_modules/, /.build/, /.serverless/ ],
      }
    ]
  },
  resolve: {
    extensions: ['.ts', '.js']
  },
}

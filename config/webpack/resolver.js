const path = require('path')

module.exports = {
  resolve: {
    alias: {
      // __dirname =  /Users/svetozar/rails/shopbase/config/webpack
      common: path.resolve(__dirname, '../../app/javascript/components/common'),
      utils: path.resolve(__dirname, '../../app/javascript/utils'),
      components: path.resolve(__dirname, '../../app/javascript/components'),
      staffDashboard: path.resolve(__dirname, '../../app/javascript/components/staff/dashboard'),
    }
  }
}

const { environment } = require('@rails/webpacker')

module.exports = environment

// Bootstrap導入でyarnインストール後に追記
const webpack = require('webpack')
environment.plugins.prepend(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery',
    Popper: 'popper.js'
  })
)
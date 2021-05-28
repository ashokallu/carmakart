const { environment } = require('@rails/webpacker')

// loaders
const exposeLoader = require('./loaders/expose-loader')

// plugins
const providePlugin = require('./plugins/provide-plugin')

environment.loaders.prepend('expose-loader', exposeLoader)
environment.plugins.append('ProvidePlugin', providePlugin)

module.exports = environment

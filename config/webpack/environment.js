const { environment } = require('@rails/webpacker')

// loaders
const jQueryLoader = require('./loaders/jquery-loader')
const bootstrapLoader = require('./loaders/bootstrap-loader')

// plugins
const providePlugin = require('./plugins/provide-plugin')

environment.loaders.prepend('jquery-loader', jQueryLoader)
environment.loaders.prepend('bootstrap-loader', bootstrapLoader)
environment.plugins.append('ProvidePlugin', providePlugin)

module.exports = environment

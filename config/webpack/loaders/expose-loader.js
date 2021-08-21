// https://webpack.js.org/loaders/expose-loader/
// https://www.npmjs.com/package/expose-loader

// Value of the "test" property should be resolved to a module, and when this same module is imported inside any other module and sent to the browser, in that case, webpack will 'expose' the identifiers in the array of the 'exposes' property as properties of the 'window' object with their values as the default export of the module resolved in the 'test' property.
module.exports = {
  test: require.resolve('jquery'),
  use: [
    {
      loader: 'expose-loader',
      options: {
        exposes: ['$', 'jQuery'],
      },
    },
  ],
}
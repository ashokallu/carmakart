// https://webpack.js.org/loaders/expose-loader/
// https://www.npmjs.com/package/expose-loader

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
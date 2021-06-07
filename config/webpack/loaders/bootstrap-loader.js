module.exports = {
  test: require.resolve('bootstrap'),
  // loader: "expose-loader",
  use: [
    {
      loader: 'expose-loader',
      options: {
        exposes: 'bootstrap',
      },
    },
  ],
}

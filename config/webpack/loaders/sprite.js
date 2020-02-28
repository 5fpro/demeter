module.exports = {
  test: /\.svg$/,
  include: /.+app\/javascript\/icons\/.+\.(svg)$/i,
  use: [
    {
      loader: 'svg-sprite-loader',
      options: {
        symbolId: 'icon-[name]',
      },
    },
    {
      loader: 'image-webpack-loader',
      options: {
        bypassOnDebug: false,
        svgo: {
          plugins: [
            { cleanupIDs: true },
            { removeTitle: true },
            { removeComments: true },
            { removeDesc: true },
            { removeDimensions: true },
            { removeUselessStrokeAndFill: true },
            { convertColors: { currentColor: true } },
          ],
        },
      },
    },
  ],
};

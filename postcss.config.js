module.exports = {
  plugins: [
    require('postcss-import'),
    require('postcss-flexbugs-fixes'),
    require('postcss-assets')({
      basePath: 'app/javascript/',
      relative: true,
    }),
    require('postcss-short')({
      skip: 'n',
    }),
    require('postcss-preset-env')({
      autoprefixer: {
        flexbox: 'no-2009',
      },
      stage: false,
    }),
    require('postcss-discard-comments')({
      removeAll: true,
    }),
  ],
};

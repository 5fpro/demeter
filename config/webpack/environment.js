const { environment } = require('@rails/webpacker');
const ForkTsCheckerWebpackPlugin = require('fork-ts-checker-webpack-plugin');
const sprite = require('./loaders/sprite');
const typescript = require('./loaders/typescript');
const dotenv = require('dotenv');
const merge = require('webpack-merge');

dotenv.config({ path: '.env', silent: true });

environment.config.set('externals', {
  jquery: 'jQuery',
  $: 'jQuery',
});
environment.loaders.insert('sprite', sprite, { after: 'file' });

const fileLoader = environment.loaders.get('file');
fileLoader.exclude = /.+app\/javascript\/icons\/.+\.(svg)$/i;

environment.loaders.prepend('typescript', typescript);

environment.plugins.append(
  'ForkTsCheckerWebpackPlugin',
  new ForkTsCheckerWebpackPlugin({
    // makes webpack wait for type checking to finish before "emitting"; allows
    // type errors to remain present in the build output from webpack and in
    // webpack-dev-server's darkened overlay
    async: false,
  })
);

const sassLoader = environment.loaders
  .get('sass')
  .use.find(el => el.loader === 'sass-loader');
sassLoader.options = merge(sassLoader.options, {
  data: `$cdn-host: ${JSON.stringify(
    process.env.CDN_HOST || process.env.ASSET_HOST
  )};`,
});

module.exports = environment;

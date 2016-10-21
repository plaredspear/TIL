# Compiling Assets (Laravel Elixir)

[Compilling Assets (Laravel Elixir)](https://laravel.com/docs/5.3/elixir)


## Introduction

Elixir supports common CSS and JavaScript pre-processors like Sass and Webpack.

```javascript
elixir(function(mix) {
    mix.sass('app.scss')
       .webpack('app.js');
});
```


## Installation & Setup


#### Installing Node

```
node -v
npm -v
```


#### Gulp

> npm install --global gulp-cli


#### Laravel Elixir

> npm install

In case, using window:

> npm install --no-bin-links


## Running Elixir

```
// Run all tasks...
gulp

// Run all tasks and minify all CSS and JavaScript...
gulp --production
```


#### Watching Asserts For Changes

> gulp watch


## Working With Stylesheets


### Less

```javascript
elixir(function(mix) {
    mix.less('app.less');
});
```

```javascript
elixir(function(mix) {
    mix.less([
        'app.less',
        'controllers.less'
    ]);
});
```

```javascript
elixir(function(mix) {
    mix.less('app.less', 'public/stylesheets');
});

// Specifying a specific output filename...
elixir(function(mix) {
    mix.less('app.less', 'public/stylesheets/style.css');
});
```


### Sass

```javascript
elixir(function(mix) {
    mix.sass('app.scss');
});
```

```javascript
elixir(function(mix) {
    mix.sass([
        'app.scss',
        'controllers.scss'
    ], 'public/assets/css');
});

```

#### Custom Paths

```javascript
elixir(function(mix) {
    mix.sass('./app/assets/sass/app.scss');
});
```


### Stylus

```javascript
elixir(function(mix) {
    mix.stylus('app.styl');
});
```


### Plain CSS

```javascript
elixir(function(mix) {
    mix.styles([
        'normalize.css',
        'main.css'
    ]);
});
```

```javascript
elixir(function(mix) {
    mix.styles([
        'normalize.css',
        'main.css'
    ], 'public/assets/css/site.css');
});
```


### Source Maps

```javascript
elixir.config.sourcemaps = false;

elixir(function(mix) {
    mix.sass('app.scss');
});
```


## Working With Scripts

help you work with your JavaScript files.
(compiling ECMAScript 2015, module bundling, minification, concatenating plain JavaScript files)


### Webpack

`resources/assets/js` directory
`public/js` directory

```javascript
elixir(function(mix) {
    mix.webpack('app.js');
});
```

```javascript
elixir(function(mix) {
    mix.webpack(
        './app/assets/js/app.js',
        './public/dist'
    );
});
```


### Rollup

(skip)


### Scripts

```javascript
elixir(function(mix) {
    mix.scripts([
        'order.js',
        'forum.js'
    ]);
});
```

```javascript
elixir(function(mix) {
    mix.scripts(['app.js', 'controllers.js'], 'public/js/app.js')
       .scripts(['forum.js', 'threads.js'], 'public/js/forum.js');
});
```

```javascript
elixir(function(mix) {
    mix.scriptsIn('public/js/some/directory');
});
```


## Copying Files & Directories

```javascript
elixir(function(mix) {
    mix.copy('vendor/foo/bar.css', 'public/css/bar.css');
});
```


## Versioning / Cache Busting

```javascript
elixir(function(mix) {
    mix.version('css/all.css');
});
```

Laravel's global `elixir` helper를 사용하여 asset 파일에 접근할 수 있음.

```html
<link rel="stylesheet" href="{{ elixir('css/all.css') }}">
```


#### Versioning Multiple Files

```javascript
elixir(function(mix) {
    mix.version(['css/all.css', 'js/app.js']);
});
```

```html
<link rel="stylesheet" href="{{ elixir('css/all.css') }}">

<script src="{{ elixir('js/app.js') }}"></script>
```


## BrowserSync

```javascript
elixir(function(mix) {
    mix.browserSync({
        proxy: 'project.dev'
    });
});
```

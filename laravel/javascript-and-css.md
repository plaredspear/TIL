# JavaScript & CSS

[JavaScript & CSS](https://laravel.com/docs/5.3/frontend)


## Introduction

basic starting point Boostrap and Vue.


#### CSS

Laravel Elixir provides a clean, expressive API over compiling SASS or LESS



#### JavaScript

Vue library.


## Writing CSS

`bootstrap-sass` package included.

installing frontend dependencies using NPM:

> npm install

`gulp` command will process the instructions in your `gulpfile.js` file.

compiled CSS는 `public/css` directory에 위치하게 됨.

> gulp


## Writing JavaScript

compiled JavaScript는 `public/js` directory에 위치하게 됨.


### Writing Vue Components

`resources/assetsjs/components`

> Vue.component('example', require('./components/Example.vue'));

```php
@extends('layouts.app')

@section('content')
    <example></example>
@endsection
```

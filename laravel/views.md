# Views

[Views](https://laravel.com/docs/5.3/views)

## Creating Views

`resources/views` directory

`resources/views/greeting.blade.php` 형태.

```php
Route::get('/', function() {
  return view('greeting', ['name' => 'James']);
});
```

여기서 `view()`는 global `view` helper.

"Dot" notation으로 nested view를 사용할 수 있음.

## Passing Data To Views

> return view('greetings', ['name' => 'Victoria']);

`with` method 활용가능

> return view('greeting')->with('name', 'Victoria');


### Sharing Data With All Views

service provider's `boot` method에 `share`를 호출해야함.

```php
<?php

namespace App\Providers;

use Illuminate\Support\Facades\View;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        View::share('key', 'value');
    }

    /**
     * Register the service provider.
     *
     * @return void
     */
    public function register()
    {
        //
    }
}
```

## View Composers

View composer는 view가 render될 때의 callback 또는 Class method이다.


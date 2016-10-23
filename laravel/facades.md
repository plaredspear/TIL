# Facades

[Facades](https://laravel.com/docs/5.3/facades)


# Introduction

Facades provide a "static" interface to classes that are available in the application's service container.

maintaing more testability and flexibility than traditional static methods.

```php
use Illuminate\Support\Facades\Cache;

Route::get('/cache', function () {
    return Cache::get('key');
});
```


# When To Use Facades

The primary danger of facades is class scope creep.


## Facades Vs. Dependency Injection

DI pros: swap implementations of injected class
This is useful during testing since you can inject a mock or stub and assert that various methods were called on the stub.

static class method를 mock 또는 stub 할 수 없다.

facades가 method call을 proxy하기 위해 dynamic method를 사용하기 때문에, test할 수 있음.

```php
use Illuminate\Support\Facades\Cache;

Route::get('/cache', function () {
    return Cache::get('key');
});
```

```php
use Illuminate\Support\Facades\Cache;

/**
 * A basic functional test example.
 *
 * @return void
 */
public function testBasicExample()
{
    Cache::shouldReceive('get')
         ->with('key')
         ->andReturn('value');

    $this->visit('/cache')
         ->see('value');
}
```


## Facades Vs. Helper Functions

```php
return View::make('profile');

return view('profile');
```


```php
Route::get('/cache', function () {
    return cache('key');
});
```

```php
use Illuminate\Support\Facades\Cache;

/**
 * A basic functional test example.
 *
 * @return void
 */
public function testBasicExample()
{
    Cache::shouldReceive('get')
         ->with('key')
         ->andReturn('value');

    $this->visit('/cache')
         ->see('value');
}
```


## How Facades Work

`facade` base class makes use of the `__callStatic()c-method

```php
<?php

namespace App\Http\Controllers;

use Cache;
use App\Http\Controllers\Controller;

class UserController extends Controller
{
    /**
     * Show the profile for the given user.
     *
     * @param  int  $id
     * @return Response
     */
    public function showProfile($id)
    {
        $user = Cache::get('user:'.$id);

        return view('profile', ['user' => $user]);
    }
}
```

`Illuminate\Support\Facades\Cache` class:

```php
class Cache extends Facade
{
    /**
     * Get the registered name of the component.
     *
     * @return string
     */
    protected static function getFacadeAccessor() { return 'cache'; }
}
```


# Facade Class Reference

(skip)

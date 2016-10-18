# HTTP Responses

[HTTP Responses](https://laravel.com/docs/5.3/responses)

## Creating Responses

#### Strpings & Arrays

route나 controller에서 string을 return하는 것이 기본.
그러면 framework가 자동으로 HTTP response로 변환

```php
Route::get('/', function () {
    return 'Hello World';
});
```

array를 리턴하면 자동으로 JSON response로 변환

```php
Route::get('/', function () {
    return [1, 2, 3];
});
```

* Eloquent collection JSON으로 자동 변환

#### Response Objects

`Illuminate\Http\Response`

`Symfony\Component\HttpFoundation\Response` class는 다양한 method를 제공한다.

```php
Route::get('home', function () {
    return response('Hello World', 200)
                  ->header('Content-Type', 'text/plain');
});
```

#### Attaching Headers To Responses

대부분의 response method는 chainable.

```php
return response($content)
            ->header('Content-Type', $type)
            ->header('X-Header-One', 'Header Value')
            ->header('X-Header-Two', 'Header Value');
```

`withHeaders` method

```php
return response($content)
            ->withHeaders([
                'Content-Type' => $type,
                'X-Header-One' => 'Header Value',
                'X-Header-Two' => 'Header Value',
            ]);
```
#### Attaching Cookies To Responses

```php
return response($content)
                ->header('Content-Type', $type)
                ->cookie('name', 'value', $minutes);
```

> ->cookie($name, $value, $minutes, $path, $domain, $secure, $httpOnly)

#### Cookies & Encryption

기본적으로 모든 cookie는 encrypted and signed.
client에서 수정하거나 읽기가 불가능함.

disable 시키려면 `App\Http\Midddleware\EncryptCookies`의 `$except` property 활용

```php
/**
 * The names of the cookies that should not be encrypted.
 *
 * @var array
 */
protected $except = [
    'cookie_name',
];
```

## Redirects

`Illuminate\Http\RedirectResponse` class.

global `redirect` helper:

```php
Route::get('dashboard', function () {
    return redirect('home/dashboard');
});
```

redirect their previous location: `back` helper function.

```php
Route::post('user/profile', function () {
    // Validate the request...

    return back()->withInput();
});
```

### Redirecting To Named Routes

named route

> return redirect()->route('login');

with parameters

```php
// For a route with the following URI: profile/{id}

return redirect()->route('profile', ['id' => 1]);
```

#### Populating Parameters Via Eloquent Models

The ID will be extracted automatically.

```php
// For a route with the following URI: profile/{id}

return redirect()->route('profile', [$user]);
```

customize the route parameter -> override the `getRouteKey` method on your Eloquent model

```php
/**
 * Get the value of the model's route key.
 *
 * @return mixed
 */
public function getRouteKey()
{
    return $this->slug;
}
```

### Redirecting To Controller Actions

> return redirect()->action('HomeController@index');

```php
return redirect()->action(
    'UserController@profile', ['id' => 1]
);
```

### Redirecting With Flashed Session Data

flashing data.

```php
Route::post('user/profile', function () {
    // Update the user's profile...

    return redirect('dashboard')->with('status', 'Profile updated!');
});
```

flashed message from the session.
Blade syntax:

```php
@if (session('status'))
    <div class="alert alert-success">
        {{ session('status') }}
    </div>
@endif
```

## Other Response Types

`response` helper.

### View Responses

```php
return response()
            ->view('hello', $data, 200)
            ->header('Content-Type', $type);
```

### JSON Responses

`json` method는 자동으로 `Content-Type` header를 `application/json`으로 설정.

```php
return response()->json([
    'name' => 'Abigail',
    'state' => 'CA'
]);
```

JSONP repsonse를 생성하고 싶을 때는 `withCallback` method를 조합:

```php
return response()
            ->json(['name' => 'Abigail', 'state' => 'CA'])
            ->withCallback($request->input('callback'));
```

### File Donwloads

`download` method

```php
return response()->download($pathToFile);

return response()->download($pathToFile, $name, $headers);
```

### File Responses

display a file such as an image or PDF.

```php
return response()->file($pathToFile);

return response()->file($pathToFile, $headers);
```

## Response Macros

`macro` method on the `Response` facade를 사용하면, customize 가능.

```php
<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use Illuminate\Support\Facades\Response;

class ResponseMacroServiceProvider extends ServiceProvider
{
    /**
     * Register the application's response macros.
     *
     * @return void
     */
    public function boot()
    {
        Response::macro('caps', function ($value) {
            return Response::make(strtoupper($value));
        });
    }
}
```

> return response()->caps('foo');


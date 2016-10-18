# The HTTP Layer: HTTP Requests

[HTTP Requests](https://laravel.com/docs/5.3/requests)

## Accessing The Request

```php
<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class UserController extends Controller
{
    /**
     * Store a new user.
     *
     * @param  Request  $request
     * @return Response
     */
    public function store(Request $request)
    {
        $name = $request->input('name');

        //
    }
}
```

#### Dependency Injection & Route Parameters

> Route::put('user/{id}', 'UserController@update');

```php
<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class UserController extends Controller
{
    /**
     * Update the specified user.
     *
     * @param  Request  $request
     * @param  string  $id
     * @return Response
     */
    public function update(Request $request, $id)
    {
        //
    }
}
```

```php
<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class UserController extends Controller
{
    /**
     * Update the specified user.
     *
     * @param  Request  $request
     * @param  string  $id
     * @return Response
     */
    public function update(Request $request, $id)
    {
        //
    }
}
```

#### Accessing The Request Via Route Closures

```php
use Illuminate\Http\Request;

Route::get('/', function (Request $request) {
    //
});
```

### Request Path & Method

#### Retrieving The Request Path

The `path` method returns the request's path information.

> $uri = $request->path();

`is` method

```php
if ($request->is('admin/*')) {
    //
}
```

#### Retrieving The Request URL

```php
// Without Query String...
$url = $request->url();

// With Query String...
$url = $request->fullUrl();
```

#### Retrieving The Request Method

```php
$method = $request->method();

if ($request->isMethod('post')) {
    //
}
```

### PSR-7 Requests

Laravel request 대신 PSR-7 request를 사용할 수도 있음.

```
composer require symfony/psr-http-message-bridge
composer require zendframework/zend-diactoros
```

```php
use Psr\Http\Message\ServerRequestInterface;

Route::get('/', function (ServerRequestInterface $request) {
    //
});
```

## Retrieving Input



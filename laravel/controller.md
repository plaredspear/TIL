# The HTTP Layer: Controllers

[Controllers](https://laravel.com/docs/5.3/controllers)

## Introduction

`app/Http/Controllers` directory

## Basic Controllers

### Defining Controllers

```php
<?php

namespace App\Http\Controllers;

use App\User;
use App\Http\Controllers\Controller;

class UserController extends Controller
{
    /**
     * Show the profile for the given user.
     *
     * @param  int  $id
     * @return Response
     */
    public function show($id)
    {
        return view('user.profile', ['user' => User::findOrFail($id)]);
    }
}
```

> Route::get('user/{id}', 'UserController@show');

### Controllers & Namespaces

full controller namespace를 언급할 필요가 없다.

`RouteServiceProvider`가 namespace를 포함한 route group을 load하므로 해당 class name만 언급하면 된다.

만약 `App\Http\Controllers\Photos\AdminController`를 사용한다면,

> Route::get('foo', 'Photos\AdminController@method');

### Single Action Controllers

single action -> `__invoke` method

```php
<?php

namespace App\Http\Controllers;

use App\User;
use App\Http\Controllers\Controller;

class ShowProfile extends Controller
{
    /**
     * Show the profile for the given user.
     *
     * @param  int  $id
     * @return Response
     */
    public function __invoke($id)
    {
        return view('user.profile', ['user' => User::findOrFail($id)]);
    }
}
```

> Route::get('user/{id}', 'ShowProfile');

## Controller Middleware

> Route::get('profile', 'UserController@show')->middleware('auth');

route file에서 middleware를 할당할 수도 있지만, Controller의 constructor에 선언하는 것이 더 편하다.

```php
class UserController extends Controller
{
    /**
     * Instantiate a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('auth');

        $this->middleware('log')->only('index');

        $this->middleware('subscribed')->except('store');
    }
}
```

전체를 지정하지 않고 일부만 지정할 때:

```php
$this->middleware(function ($request, $next) {
    // ...

    return $next($request);
});
```

### Resource Controllers

artisan `make:controller` command

> php artisan make:controller PhotoController --resource

and register a resourceful route

> Route::resource('photos', 'PhotoController');

| Verb      | URI                   | Action  | Route Name     |
|-----------|-----------------------|---------|----------------|
| GET       | `photos`              | index   | photos.index   |
| GET       | `/photos/create`      | create  | photos.create  |
| POST      | `/photos`             | store   | photos.store   |
| GET       | `/photos/{photo}`     | show    | photos.show    |
| GET       | `/photos/{photo}/edit | edit    | photos.edit    |
| PUT/PATCH | `/photos/`{photo}`    | update  | photos.update  |
| DELETE    | `/photos/{photo}`     | destroy | photos.destroy |

#### Spoofing Form Methods

HTML forms : hidden `_method` field

> {{ method_field('PUT') }}

### Partial Resource Routes

```php
Route::resource('photo', 'PhotoController', ['only' => [
    'index', 'show'
]]);

Route::resource('photo', 'PhotoController', ['except' => [
    'create', 'store', 'update', 'destroy'
]]);
```

### Naming Resource Routes

```php
Route::resource('photo', 'PhotoController', ['names' => [
    'create' => 'photo.build'
]]);
```

### Naming Resource Route Parameter

```php
Route::resource('user', 'AdminUserController', ['parameters' => [
    'user' => 'admin_user'
]]);
```

> /user/{admin_user}

### Supplementing Resource Controllers

```php
Route::get('photos/popular', 'PhotoController@method');

Route::resource('photos', 'PhotoController');
```

resource 이외의 추가 route를 선언할 경우, `resource` 이전에 선언해야함.
(컨트롤러를 추가하는 것을 권장)

## Dependency Injection & Controllers

#### Constructor Injection

```php
<?php

namespace App\Http\Controllers;

use App\Repositories\UserRepository;

class UserController extends Controller
{
    /**
     * The user repository instance.
     */
    protected $users;

    /**
     * Create a new controller instance.
     *
     * @param  UserRepository  $users
     * @return void
     */
    public function __construct(UserRepository $users)
    {
        $this->users = $users;
    }
}
```

#### Method Injection

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
        $name = $request->name;

        //
    }
}
```

> Route::put('user/{id}', 'UserController@update');

```php
<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class UserController extends Controller
{
    /**
     * Update the given user.
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

## Route Caching

(Closure 기반의 route는 cache될 수 없음. 반드시 controller class로 만들어야 됨.)

> php artisan route:cache

route가 변경되면 다시 생성해야함.
배포할 때 항상 처리하도록 할 것.

> php artisan route:clear

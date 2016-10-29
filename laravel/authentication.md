# Authentication

[Authentication](https://laravel.com/docs/5.3/authentication)


# Introduction

빠른 적용:

> php artisan make:auth

> php artisan migrate

Guards define how users are authenticated for each request.

Providers define how users are retrieved from your persistent storage.


## Database Considerations

`App\User`

`remember_token` nullable인지 확인할 것.


# Authentication Quickstart

`App\Http\Controllers\Auth` namespace에 pre-built authentication controllers

- `RegistrationController`
- `LoginController`
- `ForgotPasswordController`
- `ResetPasswordController`


## Routing

> php artisan make:auth

- will install a layout view,
- registration
- and login views,
- as well as routes for all authentication end-points.

- `HomeController`


## Views


## Authenticating


### Path Customization

> protected $redirectTo = '/';


### Guard Customization

```php
use Illuminate\Support\Facades\Auth;

protected function guard()
{
    return Auth::guard('guard-name');
}
```


### Validation /Storage Customization


## Retrieving The Authenticated User

```php
use Illuminate\Support\Facades\Auth;

$user = Auth::user();
```

```php
<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class ProfileController extends Controller
{
    /**
     * Update the user's profile.
     *
     * @param  Request  $request
     * @return Response
     */
    public function update(Request $request)
    {
        // $request->user() returns an instance of the authenticated user...
    }
}
```


### Determining If The Current User Is Authenticated

```php
use Illuminate\Support\Facades\Auth;

if (Auth::check()) {
    // The user is logged in...
}
```


## Protecting Routes

route definition:

```php
Route::get('profile', function () {
    // Only authenticated users may enter...
})->middleware('auth');
```

controller's constructor:

```php
public function __construct()
{
    $this->middleware('auth');
}
```


### Specifying A Guard

```php
public function __construct()
{
    $this->middleware('auth:api');
}
```


## Login Throttling

will not be able to login for one minute


# Manually Authenticating Users

- import `Auth` facade
- check out `attempt` method

```php
<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Auth;

class LoginController extends Controller
{
    /**
     * Handle an authentication attempt.
     *
     * @return Response
     */
    public function authenticate()
    {
        if (Auth::attempt(['email' => $email, 'password' => $password])) {
            // Authentication passed...
            return redirect()->intended('dashboard');
        }
    }
}
```

`attempt` method는 key / value를 받음.

위의 예제에서는 `email` column으로 user를 찾음
저장된 hashed password와 hash한 password를 비교


### Specifying Additional Conditions

```php
if (Auth::attempt(['email' => $email, 'password' => $password, 'active' => 1])) {
    // The user is active, not suspended, and exists.
}
```


### Accessing Specific Guard Instances

This allows you to manage authentication for separate parts of your application using entirely separate authenticatable models or user tables.

The guard name passed to the `guard` method should correspond to one of the guards configured in your `auth.php` configuration file:

```php
if (Auth::guard('admin')->attempt($credentials)) {
    //
}
```


### Logging Out

> Auth::logout();


## Remebering Users

```php
if (Auth::attempt(['email' => $email, 'password' => $password], $remember)) {
    // The user is being remembered...
}
```

if you are "remebering" users,

```php
if (Auth::viaRemember()) {
    //
}
```


## Other Authentication Methods


### Authenticate A User Instance

```php
Auth::login($user);

// Login and "remember" the given user...
Auth::login($user, true);
```

> Auth::guard('admin')->login($user);


### Authenticate A User By ID

```php
Auth::loginUsingId(1);

// Login and "remember" the given user...
Auth::loginUsingId(1, true);
```


### Authenticate A User Once

```php
if (Auth::once($credentials)) {
    //
}
```


# HTTP Basic Authentication

```php
Route::get('profile', function () {
    // Only authenticated users may enter...
})->middleware('auth.basic');
```


### A Note On FastCGI

```php
RewriteCond %{HTTP:Authorization} ^(.+)$
RewriteRule .* - [E=HTTP_AUTHORIZATION:%{HTTP:Authorization}]
```


## Stateless HTTP Basic Authentication



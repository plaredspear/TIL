# Errors & Logging

[Errors & Logging](https://laravel.com/docs/5.3/errors)


# Introduction

Laravel utilizes the `Monolog` library


# Configuration


## Error Detail

`config/app.php`에 `APP_DEBUG` environment
- for local development: **true**
- for production: **false**


## Log Storage

`single` files
`daily` files
`syslog`
`errorlog`

`config/app.php` 파일의 `log` option으로 설정할 수 있음.

> 'log' => 'daily'


### Maximum Daily Log Files

When using the `daily` log mode, Laravel will only retain **five days** of log files by default.

> 'log_max_files' => 30


## Log Severity Levels

`debug`, `info`, `notice`, `warning`, `error`, `critical`, `alert`, `emergency`

> 'log_level' => env('APP_LOG_LEVEL', 'error'),


# Custom Monolog Configuration

```php
$app->configureMonologUsing(function($monolog) {
    $monolog->pushHandler(...);
});

return $app;
```


# The Exception Handler


## The Report Method

All exceptions are handled by the `App\Exceptions\Handler` class.

`report` method: log exceptions or send them to an external service like **Bugsnag** or **Sentry**.

```php
/**
 * Report or log an exception.
 *
 * This is a great spot to send exceptions to Sentry, Bugsnag, etc.
 *
 * @param  \Exception  $exception
 * @return void
 */
public function report(Exception $exception)
{
    if ($exception instanceof CustomException) {
        //
    }

    return parent::report($exception);
}
```


### Ignoring Exceptions By Type

`$dontReport` property: will not be logged

```php
/**
 * A list of the exception types that should not be reported.
 *
 * @var array
 */
protected $dontReport = [
    \Illuminate\Auth\AuthenticationException::class,
    \Illuminate\Auth\Access\AuthorizationException::class,
    \Symfony\Component\HttpKernel\Exception\HttpException::class,
    \Illuminate\Database\Eloquent\ModelNotFoundException::class,
    \Illuminate\Validation\ValidationException::class,
];
```


## The Render Method

`render` method: converting a given exception into an HTTP response that should be sent back to the browser.


# HTTP Exceptions

`abort` helper:

> abort(404);

> abort(403, 'Unauthorized action.');


## Custom HTTP Error Pages


# Logging

```php
<?php

namespace App\Http\Controllers;

use App\User;
use Illuminate\Support\Facades\Log;
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
        Log::info('Showing user profile for user: '.$id);

        return view('user.profile', ['user' => User::findOrFail($id)]);
    }
}
```

```php
Log::emergency($message);
Log::alert($message);
Log::critical($message);
Log::error($message);
Log::warning($message);
Log::notice($message);
Log::info($message);
Log::debug($message);
```


### Contextual Information

> Log::info('User failed to login.', ['id' => $user->id]);


### Accessing The Underlying Monolog Instance

> $monolog = Log::getMonolog();

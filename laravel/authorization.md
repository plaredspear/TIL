# Authorization

[Authorization](https://laravel.com/docs/5.3/authorization)


# Introduction

2 primary ways of authrorizing action: gates and policies.


Gates provide a simple, Closure based approach to authorization

while policies, like controllers, group their logic around a particular model or resource.

We'll explore gates first and then examine policies.

most likely contain a mixture of gates and policies.

Gates art most applicable to actions which are not related to any model or resource, such as viewing an administrator dashboard.

In contrast, policies should be used when you wish to authorize an action for a particular model or resource.


# Gates


## Writing Gates

Gates are Closures that determine if a user is authorized to perform a given action and are typically defined in the `App\Providers\AuthServiceProvider` class using the `Gate` facade.
Gates always receive a user instance as their first argument, and may optionally receive additional arguments such as a relevant Eloquent model:

```php
/**
 * Register any authentication / authorization services.
 *
 * @return void
 */
public function boot()
{
    $this->registerPolicies();

    Gate::define('update-post', function ($user, $post) {
        return $user->id == $post->user_id;
    });
}
```


## Authorizing Actions

게이트를 사용하여 authorize를 하기 위해서는 `allows` method를 사용해야 한다.

```php
if (Gate::allows('update-post', $post)) {
    // The current user can update the post...
}
```

특정 유저에게만 허용할 경우, `forUser` method

```php
if (Gate::forUser($user)->allows('update-post', $post)) {
    // The user can update the post...
}
```


# Creating Policies


## Generating Policies

> php artisan make:policy PostPolicy

> php artisan make:policy PostPolicy --model=Post


## Registering Policies

`AuthServiceProvider`

```php
<?php

namespace App\Providers;

use App\Post;
use App\Policies\PostPolicy;
use Illuminate\Support\Facades\Gate;
use Illuminate\Foundation\Support\Providers\AuthServiceProvider as ServiceProvider;

class AuthServiceProvider extends ServiceProvider
{
    /**
     * The policy mappings for the application.
     *
     * @var array
     */
    protected $policies = [
        Post::class => PostPolicy::class,
    ];

    /**
     * Register any application authentication / authorization services.
     *
     * @return void
     */
    public function boot()
    {
        $this->registerPolicies();

        //
    }
}
```


# Writing Policies


## Policy Methods

```php
<?php

namespace App\Policies;

use App\User;
use App\Post;

class PostPolicy
{
    /**
     * Determine if the given post can be updated by the user.
     *
     * @param  \App\User  $user
     * @param  \App\Post  $post
     * @return bool
     */
    public function update(User $user, Post $post)
    {
        return $user->id === $post->user_id;
    }
}
```


## Methods Without Models


## Policy Filters

`before` method

```php
public function before($user, $ability)
{
    if ($user->isSuperAdmin()) {
        return true;
    }
}
```


# Authorizing Actions Using Policies


## Via The User Model

`can`, `cant` method

```php
if ($user->can('update', $post)) {
    //
}
```


### Actions That Don't Require Models

```php
use App\Post;

if ($user->can('create', Post::class)) {
    // Executes the "create" method on the relevant policy...
}
```


## Via Middleware

```php
use App\Post;

Route::put('/post/{post}', function (Post $post) {
    // The current user may update the post...
})->middleware('can:update,post');
```


### Actions That Don't Require Models

```php
Route::post('/post', function () {
    // The current user may create posts...
})->middleware('can:create,App\Post');
```


## Via Controller Helpers

```php
<?php

namespace App\Http\Controllers;

use App\Post;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class PostController extends Controller
{
    /**
     * Update the given blog post.
     *
     * @param  Request  $request
     * @param  Post  $post
     * @return Response
     */
    public function update(Request $request, Post $post)
    {
        $this->authorize('update', $post);

        // The current user can update the blog post...
    }
}
```


### Actions That Don't Require Models

```php
/**
 * Create a new blog post.
 *
 * @param  Request  $request
 * @return Response
 */
public function create(Request $request)
{
    $this->authorize('create', Post::class);

    // The current user can create blog posts...
}
```


## Via Blade Templates

```php
@can('update', $post)
    <!-- The Current User Can Update The Post -->
@endcan

@cannot('update', $post)
    <!-- The Current User Can't Update The Post -->
@endcannot
```

```php
@if (Auth::user()->can('update', $post))
    <!-- The Current User Can Update The Post -->
@endif

@unless (Auth::user()->can('update', $post))
    <!-- The Current User Can't Update The Post -->
@endunless
```


### Actions That Don't Require Models

```php
@can('create', Post::class)
    <!-- The Current User Can Create Posts -->
@endcan

@cannot('create', Post::class)
    <!-- The Current User Can't Create Posts -->
@endcannot
```

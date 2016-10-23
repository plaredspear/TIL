# Service Providers

[Service Providers](https://laravel.com/docs/5.3/providers)


# Introduction 

Laravel's core services are bootstrapped via service providers.

`config/app.php` file -> `providers` array


# Writing Service Providers

All service providers extend the `Illuminate\Support\ServiceProvider` class.

Most service providers contains a `register` and a `boot` method, you should only bind things into the service container.

Artisan CLI `make:provider` command:

> php artisan make:provider RiakServiceProvider


## The Register Method

`register` method: you should only bind things into the service container.

```php
<?php

namespace App\Providers;

use Riak\Connection;
use Illuminate\Support\ServiceProvider;

class RiakServiceProvider extends ServiceProvider
{
    /**
     * Register bindings in the container.
     *
     * @return void
     */
    public function register()
    {
        $this->app->singleton(Connection::class, function ($app) {
            return new Connection(config('riak'));
        });
    }
}
```


## The Boot Method

**This method is called after all other service providers have been registered**

```php
<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;

class ComposerServiceProvider extends ServiceProvider
{
    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        view()->composer('view', function () {
            //
        });
    }
}
```


### Boot Method Dependency Injection

```php
use Illuminate\Contracts\Routing\ResponseFactory;

public function boot(ResponseFactory $response)
{
    $response->macro('caps', function ($value) {
        //
    });
}
```


# Registering Providers

`config/app.php`

```php
'providers' => [
    // Other Service Providers

    App\Providers\ComposerServiceProvider::class,
],
```


# Deferred Providers

```php
<?php

namespace App\Providers;

use Riak\Connection;
use Illuminate\Support\ServiceProvider;

class RiakServiceProvider extends ServiceProvider
{
    /**
     * Indicates if loading of the provider is deferred.
     *
     * @var bool
     */
    protected $defer = true;

    /**
     * Register the service provider.
     *
     * @return void
     */
    public function register()
    {
        $this->app->singleton(Connection::class, function ($app) {
            return new Connection($app['config']['riak']);
        });
    }

    /**
     * Get the services provided by the provider.
     *
     * @return array
     */
    public function provides()
    {
        return [Connection::class];
    }

}
```

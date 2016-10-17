# Eloquent: Getting Started

[Eloquent](https://laravel.com/docs/5.3/eloquent)

## Introduction

## Defining Models

All Eloquent models extends `Illuminate\Database\Eloquent\Model` class

> php artisan make:model User

database migration 포함하려면

```php
php artisan make:model User --migration

php artisan make:model User -m
```

### Eloquent Model Conventions

```php
<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Flight extends Model
{
    //
}
```

#### Table Names

By Convention, the "snake case", plural name of the class => table name

custom table name을 사용할 경우:

```php
<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Flight extends Model
{
    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'my_flights';
}
```

#### Primary Keys

primary key로 `id`를 사용하는 게 convention

`$primaryKey`를 override해서 custom으로 사용할 수 있음.

#### Timestamps

Default로 Eloquent는 `created_at`이랑 `updated_at`이 존재하기를 기대함.

그렇지 않을 경우:

```php
<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Flight extends Model
{
    /**
     * Indicates if the model should be timestamped.
     *
     * @var bool
     */
    public $timestamps = false;
}
```

format을 변경할 경우:

```php
<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Flight extends Model
{
    /**
     * The storage format of the model's date columns.
     *
     * @var string
     */
    protected $dateFormat = 'U';
}
```

#### Database Connection

모든 Eloquent model은 default database connection

변경할 경우:

```php
<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Flight extends Model
{
    /**
     * The connection name for the model.
     *
     * @var string
     */
    protected $connection = 'connection-name';
}
```

## Retrieving Models

#### Adding Additional Constraints

Eloquent model은 query builder로 동작하기에 constraint를 추가할 수 있고, 결과를 얻기 위해 `get` method를 사용해야 함.

```php
$flights = App\Flight::where('active', 1)
               ->orderBy('name', 'desc')
               ->take(10)
               ->get();
```

### Collections

(skip)

### Chunking Results

`chunk` command.

```php
Flight::chunk(200, function ($flights) {
    foreach ($flights as $flight) {
        //
    }
});
```

#### Using Cursors

```php
foreach (Flight::where('foo', 'bar')->cursor() as $flight) {
    //
}
```

## Retrieving Single Models / Aggregates

```php
// Retrieve a model by its primary key...
$flight = App\Flight::find(1);

// Retrieve the first model matching the query constraints...
$flight = App\Flight::where('active', 1)->first();
```

> $flights = App\Flight::find([1, 2, 3]);

#### Not Found Exceptions

Exception 발생하는 method, `findOrFail`, `firstOfFail`

```php
$model = App\Flight::findOrFail(1);

$model = App\Flight::where('legs', '>', 100)->firstOrFail();
```

```php
Route::get('/api/flights/{id}', function ($id) {
    return App\Flight::findOrFail($id);
});
```

### Retrieving Aggregates

```php
$count = App\Flight::where('active', 1)->count();

$max = App\Flight::where('active', 1)->max('price');
```

## Inserting & Updating Models

### Inserts

new instance & `save` method

```php
<?php

namespace App\Http\Controllers;

use App\Flight;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class FlightController extends Controller
{
    /**
     * Create a new flight instance.
     *
     * @param  Request  $request
     * @return Response
     */
    public function store(Request $request)
    {
        // Validate the request...

        $flight = new Flight;

        $flight->name = $request->name;

        $flight->save();
    }
}
```

### Updates

`save` method

#### Mass Updates

* Mass updates 시에는 saved 혹은 updated event가 발생하지 않음.

### Mass Assignment

`$fillable`
white list

#### Guarding Attributes

`guarded`
black list

```php
<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Flight extends Model
{
    /**
     * The attributes that aren't mass assignable.
     *
     * @var array
     */
    protected $guarded = ['price'];
}
```

all attributes mass assignable

```php
/**
 * The attributes that aren't mass assignable.
 *
 * @var array
 */
protected $guarded = [];
```

### Other Creation Methods

`firstOrCreate`
`firstOrNew`

## Deleting Models

`delete` method

#### Deleting An Existing Model By key

```php
App\Flight::destroy(1);

App\Flight::destroy([1, 2, 3]);

App\Flight::destroy(1, 2, 3);
```

#### Deleting Models By Query

> $deletedRows = App\Flight::where('active', 0)->delete();

* mass deleting은 deleting 혹은 deleted event를 발생하지 않음.

### Soft Deleting

`deleted_at` attribute.
non-null 이면 soft deleted

```php
Schema::table('flights', function ($table) {
    $table->softDeletes();
});
```

```php
if ($flight->trashed()) {
    //
}
```

### Querying Soft Deleted Models

#### Including Soft Deleted Models

`withTrashed` method

```php
$flights = App\Flight::withTrashed()
                ->where('account_id', 1)
                ->get();
```

> $flight->history()->withTrashed()->get();

#### Retrieving Only Soft Deleted Models

`onlyTrashed` method

```php
$flights = App\Flight::onlyTrashed()
                ->where('airline_id', 1)
                ->get();
```

#### Restrogin Soft Deleted Models

`restore` method

> $flight->restore();

```php
App\Flight::withTrashed()
        ->where('airline_id', 1)
        ->restore();
```

> $flight->history()->restore();

#### Permanently Deleting Models

`forceDelete` method

```php
// Force deleting a single model instance...
$flight->forceDelete();

// Force deleting all related models...
$flight->history()->forceDelete();
```

## Query Scopes

### Global Scopes

#### Writing Global Scopes

`apply`

```php
<?php

namespace App\Scopes;

use Illuminate\Database\Eloquent\Scope;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Builder;

class AgeScope implements Scope
{
    /**
     * Apply the scope to a given Eloquent query builder.
     *
     * @param  \Illuminate\Database\Eloquent\Builder  $builder
     * @param  \Illuminate\Database\Eloquent\Model  $model
     * @return void
     */
    public function apply(Builder $builder, Model $model)
    {
        $builder->where('age', '>', 200);
    }
}
```

#### Applying Global Scopes

`addGlobalScope` method

```php
<?php

namespace App;

use App\Scopes\AgeScope;
use Illuminate\Database\Eloquent\Model;

class User extends Model
{
    /**
     * The "booting" method of the model.
     *
     * @return void
     */
    protected static function boot()
    {
        parent::boot();

        static::addGlobalScope(new AgeScope);
    }
}
```

#### Anonymous Global Scopes

```php
<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Builder;

class User extends Model
{
    /**
     * The "booting" method of the model.
     *
     * @return void
     */
    protected static function boot()
    {
        parent::boot();

        static::addGlobalScope('age', function(Builder $builder) {
            $builder->where('age', '>', 200);
        });
    }
}
```

> User::withoutGlobalScope('age')->get();

#### Removing Global Scopes

> User::withoutGlobalScope(AgeScope::class)->get();

```php
// Remove all of the global scopes...
User::withoutGlobalScopes()->get();

// Remove some of the global scopes...
User::withoutGlobalScopes([
    FirstScope::class, SecondScope::class
])->get();
```

### Local Scopes

`scope` prefix

```php
<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class User extends Model
{
    /**
     * Scope a query to only include popular users.
     *
     * @return \Illuminate\Database\Eloquent\Builder
     */
    public function scopePopular($query)
    {
        return $query->where('votes', '>', 100);
    }

    /**
     * Scope a query to only include active users.
     *
     * @return \Illuminate\Database\Eloquent\Builder
     */
    public function scopeActive($query)
    {
        return $query->where('active', 1);
    }
}
```

#### Utilizing A Local Scope

> $users = App\User::popular()->active()->orderBy('created_at')->get();

#### Dynamic Scopes

parameter로 scope

```php
<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class User extends Model
{
    /**
     * Scope a query to only include users of a given type.
     *
     * @return \Illuminate\Database\Eloquent\Builder
     */
    public function scopeOfType($query, $type)
    {
        return $query->where('type', $type);
    }
}
```

> $users = App\User::ofType('admin')->get();

## Events

`creating`, `created`, `updating`, `updated`, `saving`, `saved`, `deleting`, `deleted`, `restoring`, `restored`

```php
<?php

namespace App\Providers;

use App\User;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        User::creating(function ($user) {
            return $user->isValid();
        });
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

### Observer

```php
<?php

namespace App\Observers;

use App\User;

class UserObserver
{
    /**
     * Listen to the User created event.
     *
     * @param  User  $user
     * @return void
     */
    public function created(User $user)
    {
        //
    }

    /**
     * Listen to the User deleting event.
     *
     * @param  User  $user
     * @return void
     */
    public function deleting(User $user)
    {
        //
    }
}
```

등록 예제

```php
<?php

namespace App\Providers;

use App\User;
use App\Observers\UserObserver;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        User::observe(UserObserver::class);
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

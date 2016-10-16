# Database: Getting Started

[Database](https://laravel.com/docs/5.3/database)

## Introduction

- MySQL
- Postgres
- SQLite
- SQL Server

### Configuration

`config/database.php`

#### SQLite Configuration

`config/database.php`

```php
DB_CONNECTION=sqlite
DB_DATABASE=/absolute/path/to/database.sqlite
```

#### SQL Server Configuration

```php
'sqlsrv' => [
    'driver' => 'sqlsrv',
    'host' => env('DB_HOST', 'localhost'),
    'database' => env('DB_DATABASE', 'forge'),
    'username' => env('DB_USERNAME', 'forge'),
    'password' => env('DB_PASSWORD', ''),
    'charset' => 'utf8',
    'prefix' => '',
],
```

## Read & Write Connnections

```php
'mysql' => [
    'read' => [
        'host' => '192.168.1.1',
    ],
    'write' => [
        'host' => '196.168.1.2'
    ],
    'driver'    => 'mysql',
    'database'  => 'database',
    'username'  => 'root',
    'password'  => '',
    'charset'   => 'utf8',
    'collation' => 'utf8_unicode_ci',
    'prefix'    => '',
],
```

Read와 Write를 분리하고 싶을 때.

## Using Multiple Database Connections

`connection` method를 통해, 여러 DB에 연결할 수 있음.

> $users = DB::connection('foo')->select(...);

## Running Raw SQL Queries

### Running A Select Query

```php
<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;

class UserController extends Controller
{
    /**
     * Show a list of all of the application's users.
     *
     * @return Response
     */
    public function index()
    {
        $users = DB::select('select * from users where active = ?', [1]);

        return view('user.index', ['users' => $users]);
    }
}
```

#### Using Named Bindings

> $results = DB::select('select * from users where id = :id', ['id' => 1]);

#### Running An Insert Statement

> DB::insert('insert into users (id, name) values (?, ?)', [1, 'Dayle']);

#### Running An Update Statement

> $affected = DB::update('update users set votes = 100 where name = ?', ['John']);

#### Running A Delete Statement

> $deleted = DB::delete('delete from users');

#### Running A General Statement

> DB::statement('drop table users');

### Listening For Query Events

`listen` method.

```php
<?php

namespace App\Providers;

use Illuminate\Support\Facades\DB;
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
        DB::listen(function ($query) {
            // $query->sql
            // $query->bindings
            // $query->time
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

## Database Transactions

```php
DB::transaction(function () {
    DB::table('users')->update(['votes' => 1]);

    DB::table('posts')->delete();
});
```

#### Manually Using Transactions

> DB::beginTransaction();

> DB::rollBack();


> DB::commit();

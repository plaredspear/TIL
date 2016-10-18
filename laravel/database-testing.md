# Database Testing

[Database Testing](https://laravel.com/docs/5.3/database-testing)

## Introduction

`seeInDatabase` helper

```php
public function testDatabase()
{
    // Make call to application...

    $this->seeInDatabase('users', [
        'email' => 'sally@example.com'
    ]);
}
```

## Resetting The Database After Each Test

### Using Migrations

`DatabaseMigrations` trait

```php
<?php

use Illuminate\Foundation\Testing\WithoutMiddleware;
use Illuminate\Foundation\Testing\DatabaseMigrations;
use Illuminate\Foundation\Testing\DatabaseTransactions;

class ExampleTest extends TestCase
{
    use DatabaseMigrations;

    /**
     * A basic functional test example.
     *
     * @return void
     */
    public function testBasicExample()
    {
        $this->visit('/')
             ->see('Laravel 5');
    }
}
```

### Using Transactions

`DatabaseTransactions` trait

```php
<?php

use Illuminate\Foundation\Testing\WithoutMiddleware;
use Illuminate\Foundation\Testing\DatabaseMigrations;
use Illuminate\Foundation\Testing\DatabaseTransactions;

class ExampleTest extends TestCase
{
    use DatabaseTransactions;

    /**
     * A basic functional test example.
     *
     * @return void
     */
    public function testBasicExample()
    {
        $this->visit('/')
             ->see('Laravel 5');
    }
}
```

* default connection만 사용하기에 multiple connection을 사용할 경우 따로 다뤄야 함.

## Writing Factories

```php
$factory->define(App\User::class, function (Faker\Generator $faker) {
    return [
        'name' => $faker->name,
        'email' => $faker->email,
        'password' => bcrypt(str_random(10)),
        'remember_token' => str_random(10),
    ];
});
```

All of the files within the `factories` directory will automatically be loaded by Laravel.

### Factory States

```php
$factory->state(App\User::class, 'delinquent', function ($faker) {
    return [
        'account_status' => 'delinquent',
    ];
});
```

## Using Factories

### Creating Models

global `factory` function

First, we'll use the `make` method to create models bu not save them to the database:

```php
public function testDatabase()
{
    $user = factory(App\User::class)->make();

    // Use model in tests...
}
```

collection:

```php
// Create three App\User instances...
$users = factory(App\User::class, 3)->make();

// Create an "admin" App\User instance...
$user = factory(App\User::class, 'admin')->make();

// Create three "admin" App\User instances...
$users = factory(App\User::class, 'admin', 3)->make();
```

#### Applying States

```php
$users = factory(App\User::class, 5)->states('deliquent')->make();

$users = factory(App\User::class, 5)->states('premium', 'deliquent')->make();
```

#### Overriding Attributes

```php
$user = factory(App\User::class)->make([
    'name' => 'Abigail',
]);
```

### Persisting Models

`create` method: create & save

```php
public function testDatabase()
{
    // Create a single App\User instance...
    $user = factory(App\User::class)->create();

    // Create three App\User instances...
    $users = factory(App\User::class, 3)->create();

    // Use model in tests...
}
```

```php
$user = factory(App\User::class)->create([
    'name' => 'Abigail',
]);
```

### Relationships

`each` method:

```php
$users = factory(App\User::class, 3)
           ->create()
           ->each(function ($u) {
                $u->posts()->save(factory(App\Post::class)->make());
            });
```

#### Relations & Attribute Closures

```php
$factory->define(App\Post::class, function ($faker) {
    return [
        'title' => $faker->title,
        'content' => $faker->paragraph,
        'user_id' => function () {
            return factory(App\User::class)->create()->id;
        }
    ];
});
```

```php
$factory->define(App\Post::class, function ($faker) {
    return [
        'title' => $faker->title,
        'content' => $faker->paragraph,
        'user_id' => function () {
            return factory(App\User::class)->create()->id;
        },
        'user_type' => function (array $post) {
            return App\User::find($post['user_id'])->type;
        }
    ];
});
```

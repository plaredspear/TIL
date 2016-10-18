# Testing

[Testing](https://laravel.com/docs/5.3/testing)

## Introduction

`phpunit.xml`

## Environment

`testing` environment
- no session
- no cache data

configure `phpunit.xml`

but, make sure to clear your configuration cache using the `config:clear` Artisan command befor running your tests!

## Creating & Running Tests

`make:test` Artisan command:

> php artisan make:test UserTest

```php
<?php

use Illuminate\Foundation\Testing\WithoutMiddleware;
use Illuminate\Foundation\Testing\DatabaseMigrations;
use Illuminate\Foundation\Testing\DatabaseTransactions;

class UserTest extends TestCase
{
    /**
     * A basic test example.
     *
     * @return void
     */
    public function testExample()
    {
        $this->assertTrue(true);
    }
}
```

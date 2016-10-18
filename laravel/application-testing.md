# Application Testing

[Application Testing](https://laravel.com/docs/5.3/application-testing)

## Introduction

```php
<?php

use Illuminate\Foundation\Testing\WithoutMiddleware;
use Illuminate\Foundation\Testing\DatabaseTransactions;

class ExampleTest extends TestCase
{
    /**
     * A basic functional test example.
     *
     * @return void
     */
    public function testBasicExample()
    {
        $this->visit('/')
             ->see('Laravel 5')
             ->dontSee('Rails');
    }
}
```

`visit` make `GET` request.
`see` method assert: we should see the given text
`dontSee` method assert: should not see

`visitRoute` method:

```php
$this->visitRoute('profile');

$this->visitRoute('profile', ['user' => 1]);
```

## Interacting With Your Application

### Interacting With Links

click link:

> <a href="/about-us">About Us</a>

```php
public function testBasicExample()
{
    $this->visit('/')
         ->click('About Us')
         ->seePageIs('/about-us');
}
```

`seeRouteIs` method: correct named route

> ->seeRouteIs('profile', ['user' => 1]);

### Interacting With Forms

`type`, `select`, `check`, `attach`, `press` method

```php
<form action="/register" method="POST">
    {{ csrf_field() }}

    <div>
        Name: <input type="text" name="name">
    </div>

    <div>
        <input type="checkbox" value="yes" name="terms"> Accept Terms
    </div>

    <div>
        <input type="submit" value="Register">
    </div>
</form>
```

then

```php
public function testNewUserRegistration()
{
    $this->visit('/register')
         ->type('Taylor', 'name')
         ->check('terms')
         ->press('Register')
         ->seePageIs('/dashboard');
}
```

#### File Inputs

```php
public function testPhotoCanBeUploaded()
{
    $this->visit('/upload')
         ->attach($pathToFile, 'photo')
         ->press('Upload')
         ->see('Upload Successful!');
}
```

### Testing JSON APIs

`json`, `get`, `post`, `put`, `patch`, `delete` method

```php
<?php

class ExampleTest extends TestCase
{
    /**
     * A basic functional test example.
     *
     * @return void
     */
    public function testBasicExample()
    {
        $this->json('POST', '/user', ['name' => 'Sally'])
             ->seeJson([
                 'created' => true,
             ]);
    }
}
```

### Verifying Exact Match

```php
<?php

class ExampleTest extends TestCase
{
    /**
     * A basic functional test example.
     *
     * @return void
     */
    public function testBasicExample()
    {
        $this->json('POST', '/user', ['name' => 'Sally'])
             ->seeJsonEquals([
                 'created' => true,
             ]);
    }
}
```

### Verifying Structural Match

`seeJsonStructure` method

```php
<?php

class ExampleTest extends TestCase
{
    /**
     * A basic functional test example.
     *
     * @return void
     */
    public function testBasicExample()
    {
        $this->get('/user/1')
             ->seeJsonStructure([
                 'name',
                 'pet' => [
                     'name', 'age'
                 ]
             ]);
    }
}
```

list item

```php
<?php

class ExampleTest extends TestCase
{
    /**
     * A basic functional test example.
     *
     * @return void
     */
    public function testBasicExample()
    {
        // Assert that each user in the list has at least an id, name and email attribute.
        $this->get('/users')
             ->seeJsonStructure([
                 '*' => [
                     'id', 'name', 'email'
                 ]
             ]);
    }
}
```

nested `*` notation

```php
$this->get('/users')
     ->seeJsonStructure([
         '*' => [
             'id', 'name', 'email', 'pets' => [
                 '*' => [
                     'name', 'age'
                 ]
             ]
         ]
     ]);
```

### Sessions / Authentication

`withSession` method

```php
<?php

class ExampleTest extends TestCase
{
    public function testApplication()
    {
        $this->withSession(['foo' => 'bar'])
             ->visit('/');
    }
}
```

`actingAs` helper method

```php
<?php

class ExampleTest extends TestCase
{
    public function testApplication()
    {
        $user = factory(App\User::class)->create();

        $this->actingAs($user)
             ->withSession(['foo' => 'bar'])
             ->visit('/')
             ->see('Hello, '.$user->name);
    }
}
```

### Disabling Middleware

disable middleware: `WithoutMiddleware` trait

```php
<?php

use Illuminate\Foundation\Testing\WithoutMiddleware;
use Illuminate\Foundation\Testing\DatabaseMigrations;
use Illuminate\Foundation\Testing\DatabaseTransactions;

class ExampleTest extends TestCase
{
    use WithoutMiddleware;

    //
}
```

```php
<?php

class ExampleTest extends TestCase
{
    /**
     * A basic functional test example.
     *
     * @return void
     */
    public function testBasicExample()
    {
        $this->withoutMiddleware();

        $this->visit('/')
             ->see('Laravel 5');
    }
}
```

### Custom HTTP Requests

custom HTTP request:

```php
public function testApplication()
{
    $response = $this->call('GET', '/');

    $this->assertEquals(200, $response->status());
}
```

`POST`, `PUT`, `PATCH` request:

>    $response = $this->call('POST', '/user', ['name' => 'Taylor']);

### PHPUnit Assertions

`->assertResponseOk();`
`->assertResponseStatus($code);`
`->assertViewHas($key, $value = null);`
`->assertViewHasAll(array $bidings);`
`->assertViewMissing($key);`
`->assertRedirectedTo($uri, $with = []);`
`->assertRedirectedToRoute($name, $parameters = [], $with = []);`
`->assertRedirectedToAction($name, $parameters = [], $with = []);`
`->assertSessionHas($key, $value = null);`
`->assertSessionHasAll(array $bidings);`
`->assertSessionHasErrors($bindings = [], $format = null);`
`->assertHasOldInput();`
`->assertSessionMissing($key);`

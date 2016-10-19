# Test Database

`new Laravel`로 프로젝트를 생성하면
`config/database.php` 파일에 default 설정이 되어 있다.

database 설정 파일에서 보이는 것과 같이,
testing 환경의 database 설정이 따로 존재하지 않는다.

물론 `local`, `develop`, `stage`, `production`등 각 환경별로 추가하여 사용하면 되겠으나,
기본적으로 `test` 환경은 미리 지정해두면 어떨까하는 아쉬움이 남는다.

(매번 Ruby on Rails--RoR--와 비교하게 되는데,
`test` 환경 정도는 기본으로 세팅해둔 RoR이 더 좋아보일 수 밖에 없다.)

### config/database.php

`testing` DB 세팅을 추가해주자.

```php
        'testing' => [
            'driver' => 'sqlite',
            'database' => ':memory:',
            'prefix' => '',
        ],
```

### phpunit.xml

일단 개발 DB와 테스트 DB를 분리해야 하므로
phpunit이 동작할 때
`DB_CONNECTION` 환경 변수를 변경해주자.

> <env name="DB_CONNECTION" value="testing" />

### TestCase

테스트 케이스에서 테스트 DB를 활용할 조건을 추가해주자.

각 테스트 별로 DB를 격리시켜야하기에 매번 테스트 DB를 reset 해준다.

```php
class OrdersTest extends TestCase
{
    public function setUp()
    {
        parent::setUp();
        Artisan::call('migrate');
    }

    public function tearDown()
    {
        Artisan::call('migrate:reset');
        parent::tearDown();
    }

    ...
}
```

### 참고

- [Laravel - PHPUnit - Setting up an in memory SQLite database for testing](http://ryanstelmat.com/laravel-setting-up-an-in-memory-test-database)

- [PHPUnit](https://phpunit.de)

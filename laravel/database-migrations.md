# Database: Migrations

[Migrations](https://laravel.com/docs/5.3/migrations)

## Introduction

## Generating Migrations

`make:migration` Artisan command:

> php artisan make:migration create_users_table

`database/migrations` directory에 생성됨.

`--table`: pre-fill for table
`--create`: pre-fill for new table

## Migration Structure

```php
<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateFlightsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('flights', function (Blueprint $table) {
            $table->increments('id');
            $table->string('name');
            $table->string('airline');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::drop('flights');
    }
}
```

## Running Migrations

> php artisan migrate

#### Forcing Migrations To Run In Production

데이터 loss가 발생하는 migration은 prompt로 confirmation을 띄운다.
Production에서 이를 피하기 위한 옵션.

> php artisan migrate --force

### Rolling Back Migrations

> php artisan migrate:rollback

> php artisan migrate:rollback --step=5

> php artisan migrate:reset

#### Rollback & Migrate In Single Command

`migrate:refresh`

```php
php artisan migrate:refresh

// Refresh the database and run all database seeds...
php artisan migrate:refresh --seed
```

> php artisan migrate:refresh --step=5

## Tables

### Creating Tables

```php
Schema::create('users', function (Blueprint $table) {
    $table->increments('id');
});
```

#### Checking For Table / Column Existence

```php
if (Schema::hasTable('users')) {
    //
}

if (Schema::hasColumn('users', 'email')) {
    //
}
```

#### Connnection & Storage Engine

default connection말고 다른 database connection을 이용할 때,

```php
Schema::connection('foo')->create('users', function ($table) {
    $table->increments('id');
});
```

### Renaming / Dropping Tables

> Schema::rename($from, $to);

```php
Schema::drop('users');

Schema::dropIfExists('users');
```

#### Renaming Tables With Foreign Keys

Before renaming a table, you should verify that any foreign key constraints on the table have an explicit name in your migration files instead of letting Laravel assign a convention based name. Otherwise, the foreign key constraint name will refer to the old table name.

## Columns

### Creating Columns

```php
Schema::table('users', function ($table) {
    $table->string('email');
});
```

#### Available Column Types

`$table->bigIncrements('id');` : Incrementing ID(primary key) UNSIGNED BIG INTEGER
`$table->bigInteger('votes');` : BIGINT
`$table->binary('data');` : BLOB
`$table->boolean('confirmed');` : BOOLEAN
`$table->char('name', 4);` : CHAR
`$table->date('created_at');` : DATE
`$table->dateTime('created_at');` : DATETIME
`$table->dateTimeTz('created_at');` : DATETIME(with timezone)
`$table->decimal('amount', 5, 2);` : DECIMAL(precision, scale)
`$table->double('column', 15, 8);` : DOUBLE(15 digits precision, 8 after decimal point)
`$table->enum('choices', ['foo', 'bar']);` : ENUM
`$table->float('amount', 8, 2);` : FLOAT
`$table->increments('id');` : Incrementing ID (primary key) UNSIGNED INTEGER
`$table->integer('votes');` : INTEGER
`$table->ipAddress('visitor');` : IP address
`$table->json('options');` : JSON
`$table->jsonb('options');` : JSONB
`$table->longText('description');` : LONGTEXT
`$table->macAddress('device');` : MAC address
`$table->mediumIncrements('id');` : MEDIUMINT
`$table->mediumText('description');` : MEDIUMTEXT
`$table->morphs('taggable');` : unsigned INTEGER `taggable_id` and STRING `taggable_type`
`$table->nullableTimestamps();` : Same as `timestamps()`
`$table->rememberToken();` : `remember_token` as VARCHAR(100) NULL
`$table->smallIncrements('id');` : Incrementing ID (primary key) UNSIGNED SMALL INTEGER
`$table->smallInteger('votes');` : SMALLINT
`$table->softDeletes();` : nullable `deleted_at`
`$table->string('email');` : VARCHAR
`$table->string('name', 100);` : VARCHAR with length
`$table->text('description');` : TEXT
`$table->time('sunrise');` : TIME
`$table->timeTz('sunrise');` : TIME with timezone
`$table->tinyInteger('numbers');` : TINYINT
`$table->timestamp('added_on');` : TIMESTAMP
`$table->timestampTz('added_on');` : TIMESTAMP with timezone
`$table->timestamps();` : nullable `created_at` and `updated_at`
`$table->timestampsTz();` : nullable `created_at` and `updated_at` with timezone
`$table->unsignedBigInteger('votes');` : Unsigned BIGINT
`$table->unsignedInteger('votes');` : Unsigned INT
`$table->unsignedMediumInteger('votes');` : Unsigned MEDIUMINT
`$table->unsignedSmallInteger('votes');` : Unsigned SMALLINT
`$table->unsignedTinyInteger('votes');` : Unsigned TINYINT
`table->uuid('id');` : UUID

### Column Modifiers

`->after('column')` : Place the column "after" another column (MySQL Only)
`->comment('my comment')` : Add a comment to a column
`->default($value)` : default value
`->first()` : Place the column "first" in the table (MySQL Only)
`->nullable()` : Allow NULL
`->storedAs($expression)` : Create a stored generated column (MySQL Only)
`->unsigned()` : Set `integer` columns to `UNSIGNED`
`->virtualAs($expression)` : Create a virtual generated column (MySQL Only)

### Modifying Columns

#### Prerequisites

Doctrine DBAL library

> composer require doctrine/dbal

#### Updating Column Attributes

`change` method

```php
Schema::table('users', function ($table) {
    $table->string('name', 50)->change();
});
```

```php
Schema::table('users', function ($table) {
    $table->string('name', 50)->nullable()->change();
});
```

#### Renaming Columns

```php
Schema::table('users', function ($table) {
    $table->renameColumn('from', 'to');
});
```

### Dropping Columns

```php
Schema::table('users', function ($table) {
    $table->dropColumn('votes');
});
```

```php
Schema::table('users', function ($table) {
    $table->dropColumn(['votes', 'avatar', 'location']);
});
```

## Indexes

### Creating Indexes

column value가 분명 unique 해야 함. 

> $table->string('email')->unique();

생성 후에 정의

> $table->unique('email');

#### Available Index Type 

`$table->primary('id');` : Add a primary key
`$table->primary(['first', 'last']);` : Add composite keys
`$table->unique('email');` : Add a unique index
`$table->unique('state', 'my_index_name');` : Add a custom index name
`$gable->index('state');` : Add a basic index

### Dropping Indexes

`$table->dropPrimary('users)id_primary');` : Drop a primary key from the "users" table
`$table->dropUnique('users_email_unique');` : Drop a unique index from the "users" table
`$table->dropIndex('geo_state_index');` : Drop a basic index from the "geo" table

```php
Schema::table('geo', function ($table) {
    $table->dropIndex(['state']); // Drops index 'geo_state_index'
})
```

### Foreign Key Constraints

```php
Schema::table('posts', function ($table) {
    $table->integer('user_id')->unsigned();

    $table->foreign('user_id')->references('id')->on('users');
});
```

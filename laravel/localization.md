# Localization

[Localization](https://laravel.com/docs/5.3/localization)

## Introduction

`resourses/lang` directory

```
/resources
    /lang
        /en
            messages.php
        /es
            messages.php
```

lang file example

```php
<?php

return [
    'welcome' => 'Welcome to our application'
];
```

### Configuring The Locale

`config/app.php`

```php
Route::get('welcome/{locale}', function ($locale) {
    App::setLocale($locale);

    //
});
```

"fallback language" active language가 정상 작동을 하지 않을 경우.

> 'fallback_locale' => 'en',

### Determining The Current Locale

```php
$locale = App::getLocale();

if (App::isLocale('en')) {
    //
}
```

## Retrieving Language Lines

`trans` helper function.

`resources/lang/messages.php` language file:

> echo trans('messages.welcome');

Blade template engine을 사용할 경우

```php
{{ trans('messages.welcome') }}

@lang('messages.welcome')
```

### Replacing Parameters In Language Lines

place-holder -> prefix `:`

> 'welcome' => 'Welcome, :name',

> echo trans('messages.welcome', ['name' => 'dayle']);

place-holder의 capitalize에 따라 value 또한 영향을 받음.

### Pluralization

`|` Pluralization option.

`trans_choise`: greater than one.

> echo trans_choice('messages.apples', 10);

multiple ranges:

> 'apples' => '{0} There are none|[1,19] There are some|[20,Inf] There are many',

## Overriding Package Language Files

package의 lang file을 직접 수정하는 대신

`resources/lang/vendor/{package}/{locale}`로 override.

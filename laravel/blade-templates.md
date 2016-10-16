# Blade Templates

[Blade Templates](https://laravel.com/docs/5.3/blade)

## Introduction

Cache

`.blade.php` file extension.

`resources/views` directory.

## Template Inheritance

### Defining A Layout

```php
<!-- Stored in resources/views/layouts/app.blade.php -->

<html>
    <head>
        <title>App Name - @yield('title')</title>
    </head>
    <body>
        @section('sidebar')
            This is the master sidebar.
        @show

        <div class="container">
            @yield('content')
        </div>
    </body>
</html>
```

### Extending A Layout

```php
<!-- Stored in resources/views/child.blade.php -->

@extends('layouts.app')

@section('title', 'Page Title')

@section('sidebar')
    @parent

    <p>This is appended to the master sidebar.</p>
@endsection

@section('content')
    <p>This is my body content.</p>
@endsection
```

`sidebar` section에서 `@parent` directive로 parent에 append할 수 있음.

```php
Route::get('blade', function () {
    return view('child');
});
```

## Displaying Data

```php
Route::get('greeting', function () {
    return view('welcome', ['name' => 'Samantha']);
});
```


> Hello, {{ $name }}

PHP code를 넣을 수도 있음.

### Echoing Data If It Exists

값이 존재하는지 확실치 않을 때,

기존에는 `isset`을 활용

> {{ isset($name) ? $name : 'Default' }}

Blade에서는 편리한 short-cut을 제공함.

> {{ $name or 'Default' }}

### Displaying Unescaped Data

Blase는 `{{ }}` 안의 코드를 PHP의 `htmlentities` function으로 보내, XSS attack을 막음.
이를 원치 않을 경우

> Hello, {!! $name !!}

## Blade & JavaScript Framework

JavaScript Framework들이 "curly" brace를 사용하므로 이를 함께 사용하기 위해서,
JavaScript Framework에서 사용하는 "curly" brace 앞에 `@`을 함께 써야함.
그러면 Blade가 처리를 안 함.

### `@verbatim` Directive

만약 JavaScript가 많이 사용될 경우, `@verbatim` Directive를 사용하면 됨.

## Control Structures

### If Statements

```php
@if (count($records) === 1)
    I have one record!
@elseif (count($records) > 1)
    I have multiple records!
@else
    I don't have any records!
@endif
```

`@unless`

```php
@unless (Auth::check())
    You are not signed in.
@endunless
```

### Loops

```php
@for ($i = 0; $i < 10; $i++)
    The current value is {{ $i }}
@endfor

@foreach ($users as $user)
    <p>This is user {{ $user->id }}</p>
@endforeach

@forelse ($users as $user)
    <li>{{ $user->name }}</li>
@empty
    <p>No users</p>
@endforelse

@while (true)
    <p>I'm looping forever.</p>
@endwhile
```

`@continue`, `@break`

```php
@foreach ($users as $user)
    @if ($user->type == 1)
        @continue
    @endif

    <li>{{ $user->name }}</li>

    @if ($user->number == 5)
        @break
    @endif
@endforeach
```

```php
@foreach ($users as $user)
    @continue($user->type == 1)

    <li>{{ $user->name }}</li>

    @break($user->number == 5)
@endforeach
```

### The Loop Variable

`$loop` loop variable.

```php
@foreach ($users as $user)
    @if ($loop->first)
        This is the first iteration.
    @endif

    @if ($loop->last)
        This is the last iteration.
    @endif

    <p>This is user {{ $user->id }}</p>
@endforeach
```

nested loop: `parent`

```php
@foreach ($users as $user)
    @foreach ($user->posts as $post)
        @if ($loop->parent->first)
            This is first iteration of the parent loop.
        @endif
    @endforeach
@endforeach
```

| **Property** | **Description** |
|--------------|-----------------|
| `$loop->index` | The index of the current loop iteration (starts at 0). |
| `$loop->iteration` | The current loop iteration (starts at 1). |
| `$loop->remaining` | The iteration remaining in the loop. |
| `$loop->count` | The total number of items in the array being iterated |
| `$loop->first` | Whether this is the first iteration through the loop. |
| `$loop->last` | Whether this is the last iteration through the loop. |
| `$loop->depth` | The nesting level of the current loop. |
| `$loop->parent` | When in a nested loop, the parent's loop variable. |

### Comments

> {{-- This comment will not be present in the rendered HTML -- }}

## Including Sub-Views

```php
<div>
    @include('shared.errors')

    <form>
        <!-- Form Contents -->
    </form>
</div>
```

> @include('view.name', ['some' => 'data'])

### Rendering Views For Collections

> @each('view.name', $jobs, 'job')

fourth element: 만약 collection이 비어 있는 경우, `view.empty`를 render.

> @each('view.name', $jobs, 'job', 'view.empty')

## Stacks

```php
@push('scripts')
    <script src="/example.js"></script>
@endpush
```

```php
<head>
    <!-- Head Contents -->

    @stack('scripts')
</head>
```

## Service Injection

`@inject`

Laravel의 service container로부터 service를 inject하여 사용할 수 있음.

```php
@inject('metrics', 'App\Services\MetricsService')

<div>
    Monthly Revenue: {{ $metrics->monthlyRevenue() }}.
</div>
```

## Extending Blade

`directive` method를 이용하여 custom directive를 만들 수 있음.

```php
<?php

namespace App\Providers;

use Illuminate\Support\Facades\Blade;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Perform post-registration booting of services.
     *
     * @return void
     */
    public function boot()
    {
        Blade::directive('datetime', function($expression) {
            return "<?php echo $expression->format('m/d/Y H:i'); ?>";
        });
    }

    /**
     * Register bindings in the container.
     *
     * @return void
     */
    public function register()
    {
        //
    }
}
```

위의 Provider가 아래 코드를 생성할 것임.

> <?php echo $var->format('m/d/Y H:i'); ?>

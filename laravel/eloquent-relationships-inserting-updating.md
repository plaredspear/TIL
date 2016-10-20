# Eloquent Relationships - Inserting & Updating Related Models

[Inserting & Updating Related Models](https://laravel.com/docs/5.3/eloquent-relationships#inserting-and-updating-related-models)


## The Save Method

```php
$comment = new App\Comment(['message' => 'A new comment.']);

$post = App\Post::find(1);

$post->comments()->save($comment);
```

`saveMany` method:

```php
$post = App\Post::find(1);

$post->comments()->saveMany([
    new App\Comment(['message' => 'A new comment.']),
    new App\Comment(['message' => 'Another comment.']),
]);
```


## The Create Method

`save` method는 Eloquent model instance를 받지만,
`create` method는 `array`를 받음.

```php
$post = App\Post::find(1);

$comment = $post->comments()->create([
    'message' => 'A new comment.',
]);
```


## Belongs To Relationships

`associate` method:

```php
$account = App\Account::find(10);

$user->account()->associate($account);

$user->save();
```

`disassociate` method:

```php
$user->account()->dissociate();

$user->save();
```


## Many To Many Relationships


### Attaching / Detaching

`attach` method: inserting a record in the intermediate table

```php
$user = App\User::find(1);

$user->roles()->attach($roleId);
```

> $user->roles()->attach($roleId, ['expires' => $expires]);

`detach` method: remove the appropriate record out of the intermediate table

```php
// Detach a single role from the user...
$user->roles()->detach($roleId);

// Detach all roles from the user...
$user->roles()->detach();
```

```php
$user = App\User::find(1);

$user->roles()->detach([1, 2, 3]);

$user->roles()->attach([1 => ['expires' => $expires], 2, 3]);
```


### Syncing Associations

`sync` method: many-to-many association을 만들때 사용

> $user->roles()->sync([1, 2, 3]);

> $user->roles()->sync([1 => ['expires' => true], 2, 3]);

> $user->roles()->syncWithoutDetaching([1, 2, 3]);


### Saving Additional Data On A Pivot Table

> App\User::find(1)->roles()->save($role, ['expires' => $expires]);


### Updating A Record On A Pivot Table

```php
$user = App\User::find(1);

$user->roles()->updateExistingPivot($roleId, $attributes);
```

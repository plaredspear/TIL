# Eloquent: Relationships

[Eloquent: Relationships](https://laravel.com/docs/5.3/eloquent-relationships)

## Introduction

## Defining Relationships

> $user->posts()->where('active', 1)->get();


### One To One

`hasOne` method:

```php
<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class User extends Model
{
    /**
     * Get the phone record associated with the user.
     */
    public function phone()
    {
        return $this->hasOne('App\Phone');
    }
}
```

property

> $phone = User::find(1)->phone;

custom foreign key:

> return $this->hasOne('App\Phone', 'foreign_key');

custom key:

> return $this->hasOne('App\Phone', 'foreign_key', 'local_key');


#### Defining The Inverse Of The Relationship

`belongsTo` method:

```php
<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Phone extends Model
{
    /**
     * Get the user that owns the phone.
     */
    public function user()
    {
        return $this->belongsTo('App\User');
    }
}
```

custom foreign key:

```php
/**
 * Get the user that owns the phone.
 */
public function user()
{
    return $this->belongsTo('App\User', 'foreign_key');
}
```

custom key:

```php

/**
 * Get the user that owns the phone.
 */
public function user()
{
    return $this->belongsTo('App\User', 'foreign_key', 'other_key');
}
```


### One To Many

```php

<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Post extends Model
{
    /**
     * Get the comments for the blog post.
     */
    public function comments()
    {
        return $this->hasMany('App\Comment');
    }
}
```

```php
$comments = App\Post::find(1)->comments;

foreach ($comments as $comment) {
    //
}
```

> $comments = App\Post::find(1)->comments()->where('title', 'foo')->first();

```php
return $this->hasMany('App\Comment', 'foreign_key');

return $this->hasMany('App\Comment', 'foreign_key', 'local_key');
```

### Ont To Many (Inverse)

`belongsTo` method:

```php
<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Comment extends Model
{
    /**
     * Get the post that owns the comment.
     */
    public function post()
    {
        return $this->belongsTo('App\Post');
    }
}
```

```php
$comment = App\Comment::find(1);

echo $comment->post->title;
```

```php
/**
 * Get the post that owns the comment.
 */
public function post()
{
    return $this->belongsTo('App\Post', 'foreign_key');
}
```

```php
/**
 * Get the post that owns the comment.
 */
public function post()
{
    return $this->belongsTo('App\Post', 'foreign_key', 'other_key');
}
```

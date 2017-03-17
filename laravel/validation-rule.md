# Laravel Validation Rules

([Laravel 5.4](https://laravel.com/docs/5.4) 기준)

### [Required Without](https://laravel.com/docs/5.4/validation#rule-required-without)

조건으로 언급된 필드들이 하나라도 없다면,
타깃 필드가 반드시 필요함.

ex)

전화번호와 이메일 둘 다 없을때,
반드시 이메일을 입력해야하는 경우

```
'email' => 'required_without:phone_number,email'
```


### [Required Without All](https://laravel.com/docs/5.4/validation#rule-required-without-all)

조건으로 언급된 필드들이 모두 없을 때
타깃 필드가 반드시 필요함.

ex)

이름과 전화번호 모두 입력하지 않았을 때,
반드시 이메일을 입력해야하는 경우

```
'email' => 'required_without_all:name,phone_number'
```


# Tip: Validate Array Input 

array 입력을 받을 때,
공식 문서([Valudation #rule-array](https://laravel.com/docs/5.1/validation#rule-array)에서는 array인지 아닌지 검증하는 부분만 존재하고,
array의 nested parameter에 대한 얘기는 없다.

혹시나 하여, 아래처럼 `*`를 넣어서 확인해봤더니 기대하는 동작을 한다.

```php
public function store(Request $request) {
    $this->validate($request, [
        'items' => 'required|array',
        'items.*.quantity' => 'required',
    ]);

  ...
}
```

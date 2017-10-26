# belongs_to optional field

모델 테스트 코드를 작성하는데 reference column에서 validation error가 발생하였다.
(nullable reference)

따로 validation을 걸어준 것도 아니고,
column도 nullable하도록 처리해뒀는데..

검색을 해보니,

https://stackoverflow.com/questions/27589399/add-nullable-foreign-key-in-rails

답변 중의 링크
https://github.com/rails/rails/issues/18233
=> belongs_to는 required를 기본으로 지정하자는 DHH.

결론,
belongs_to를 사용할 때 nullable false가 기본이기에
그렇지 않은 상태로 사용할 경우 validation error를 발생한다.
nullable 하도록 사용하려면,

```
belongs_to :book, optional: false
```

`optional`을 지정해둬야 한다.

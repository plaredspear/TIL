# Label Tag의 for element

[MDN `<label>`](https://developer.mozilla.org/ko/docs/Web/HTML/Element/label)

label이랑 input을 같이 활용할 때, label을 선택하면 해당 input을 지칭할 수 있음.

```html
<label>Click me <input type="text" id="User" name="Name" /></label>
```

이렇게 감싼 형태로 해도 되지만,

```html
<label for="User">Click me</label>
<input type="text" id="User" name="Name" />
```

이렇게 `for`를 사용하여 구성할 수도 있다.

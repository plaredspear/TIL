# Tutorial Rails Vuejs

Rails + Vuejs Tutorial 프로젝트를 만들어보자.

[Using Webpack in Rails with the Webpacker Gem](https://gorails.com/episodes/using-webpack-in-rails-with-webpacker-gem)


### Rails 프로젝트 생성

Rails 프로젝트 생성

```shell
rails new tutorial-rails-vuejs
```

따로 [webpack](https://github.com/rails/webpacker)을 추가해줘야 한다.

```shell
rails webpacker:install
```


Webpack을 함께 생성할 경우

```shell
rails new tutorial-rails-vuejs --webpack
```


### 샘플을 만들어보자

app/javascript 경로에 관련된 파일을 위치하면 된다.
그러면 webpack에서 관련된 파일을 처리

Rails 프로젝트를 생성하고 바로 서버를 동작시켜서 접근해보면,

```
rails server
```

rails default page가 나온다.

이 페이지에서 app/javascript/packs/application.js의 기본 log 출력 코드의 동작유무를 확인할 수 없다.

해당 페이지는 rails에 내장된 default page이기 때문에
관련된 javascript 파일들이 링크되지 않기 때문이다.

간단하게 view, controller를 만들어 route에 추가해주고
마지막으로 app/javascript/packs/application.js의 파일을 컴파일하여 링크를 해주기 위해
app/views/layout/application.html.erb 파일에 해당 코드를 추가하여 확인해보자.


### Vue를 설치해보자

```
bin/rails webpacker:install:vue
```

single file component: 한 파일 내에 template, script, style을 모두 포함한 단일 파일

app/view/layout/application.html.erb에서 'hello_vue'를 로드하자

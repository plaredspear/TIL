# Laravel Installation

composer로 laravel을 설치하자
> composer global require "laravel/installer"

`$HOME/.composer/vendor/bin` PATH도 추가해주자

## Local Development Server

Local에서 서버 띄우기
> php artisan serve

`http://localhost:8000`로 접속하면 확인할 수 있다.

(* Homestread 세팅이므로 host에 등록해서 사용함)

## Configuration

### Public Directory

web root를 laravel project의 public 폴더로 세팅

### Configuration Files

모든 configuration file은 `config` 폴더에 있음

### Directory Permission

`storage`와 `bootstrap/cache` 디렉토리의 쓰기 권한이 있어야 함.
(* Homestead를 사용한다면 이미 되어 있음)

### Application Key

Composer나 Laravel Installer로 설치했으면, 이미 추가됨.
없으면 secure하지 않음.

### Additional Configuration

거의 다 되어 있기 때문에 그냥 개발하면 됨.


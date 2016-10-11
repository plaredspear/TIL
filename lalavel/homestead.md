# Lalavel Homestead 세팅

[Lalavel Homestead](https://laravel.com/docs/5.3/homestead)

## Introduction

Lalavel Homestead는 개발용 Vagrant box.

포함된 Software
- Ubuntu 16.04
- Git
- PHP 7.0
- Nginx
- MySQL
- MariaDB
- Sqlite3
- Postgres
- Composer
- Node (With PM2, Bower, Grunt, and Gulp)
- Redis
- Memcached
- Beanstalkd

## Installation & Setup

### First step

#### Installing The Homestead Vagrant Box

> vagrant box add laravel/homestead

* vagrant version이 낮은 경우, `vagrant up` 시에 에러 발생.
-> vagrant 최신 버전으로 업그레이드하면 해결됨.

#### Installing Homestead

repository를 clone해서 home directory에 설치.
그러면 모든 Lalavel project를 지원.

### Configuring Homestead

#### Setting Your Provider

provider 설정

#### Configuring Shared Folders

Homestead와 local machine의 공유 폴더 설정

#### Configuring Nginx Sites

Nginx의 public sites 설정

#### Host file

## Launching The Vagrant Box

> vagrant up

## Per Project Installation

개별 프로젝트당 설치

> composer require laravel/homestead --dev

> php vendor/bin/homestead make

## Installing MariaDB

MySQL을 삭제하고 MariaDB를 설치함.

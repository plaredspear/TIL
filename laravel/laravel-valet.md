# Laravel Valet

[Laravel Valet](https://laravel.com/docs/5.3/valet)

## Instroduction

Mac용 Lalavel 개발 환경.
No vagrant, No Apache, No Nginx, No `/etc/hosts` file.
local tunnel을 이용해서 공유도 가능함.

Caddy를 백그라운드에서 항상 구동하고 있음.
DnsMasq를 사용한 Valet은 `*.dev` domain을 프록시함.

Valet은 Vagrant나 Homestead를 완벽하게 대체하는 것은 아니지만, 한정된 RAM의 사용한다.

### Valet Or Homestead

fully virtualized Linux development environment가 필요하거나,
Window / Linux 사용자이면 Homestead.

그렇지 않다면 Valet.

## Installation

Homebrew가 필요함.
반드시 Apache나 Nginx 같은 80 port에 binding된 프로그램이 없어야 함.

- install or update Homebrew th the lastest version using `brew update`.
- Install PHP 7.0 using Homebrew via `brew install homebrew/php/php70`.
0 Install Valet with Composer via `composer global require laravel/valet`. Make sure the `~/.composer/vender/bin` directory is in your system's "PATH".
- Run the `valet install` command. This will configure and install Valet and DnsMasq, and register Valet's daemon to launch when your system starts.

valet은 daemon으로 자동 실행된다.

### Using Another Domain

`valet domain tld-name` command

### Database

`brew install mariadb`
`brew services start mariadb`

### Upgrading

`composer global update`

After upgrading,
`valet install`

## Serving Sites

### The `park` Command

- 새 디렉토리 생성 & 해당 디렉토리도 이동. `valet park`.
- Laravel site 생성: `laravel new blog`.
- `http://blog.dev`

### The `link` Command

디렉토리에서 단일 사이트만 serve하기 원할 경우 (전체 디렉토리가 아니라)

- `valet link app-name`. `~/.valet/Sites`에 심볼릭 링크를 생성함.
- `link` command 후에, `http://app-name.dev`

`valet links`: 링크된 목록
`valet unlink app-name`: 심볼릭 링크 삭제

### Securing Sites With TLS

Valet은 plain HTTP로 sites를 serve함.
만약, HTTP/2를 사용하여 encrypted TLS로 site를 serve하고 싶다면, `secure` command를 이용하면 된다.

> valet secure blog

> valet unsecure blog

## Sharing Sites

`valet share`

## Viewing Logs

`valet logs

## Custom Valet Drivers

skip

## Other Valet Commands

`valet forget` : Run this command from a "parked" directory to remove it from the parked directory list.
`valet path` : View all of your "parked" paths.
`valet restart` : Restart the Valet daemon.
`valet start` : Start the Valet daemon.
`valet stop` : Stop the Valet daemon.
`valet uninstall` : Uninstall the Valet daemon entirely.

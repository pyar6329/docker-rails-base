# rails base docker images

[![Run Status](https://api.shippable.com/projects/57ac9dd5c654160f00a3d2ef/badge?branch=master)](https://app.shippable.com/projects/57ac9dd5c654160f00a3d2ef)

|name|description|
|:--|:-----------|
|OS|alpine linux|
|ruby|2.3.1|
|node|6.3.1|

development: `pyar6329/rails-base:prod-2.3.1-6.3.1`

production: `pyar6329/rails-base:dev-2.3.1-6.3.1`

data container: `pyar6329/rails-base:data-latest`

Docker hub: [https://hub.docker.com/r/pyar6329/rails-base](https://hub.docker.com/r/pyar6329/rails-base)

## Using images

### development

#### docker build

1. [Dockerfileを作成してください](https://github.com/pyar6329/docker-rails-base/blob/master/sample/dev/builds/Dockerfile)
2. Dockerfileと同じディレクトリにrailsのリポジトリを `app` という名前で保存してください。

```
$ cat << EOF > Dockerfile
FROM pyar6329/rails-base:dev-2.3.1-6.3.1

ENV RAILS_ENV=development NODE_ENV=development

EXPOSE 3000
EOF
$ git clone git://railsのリポジトリ app
$ docker build .
```

#### docker run

以下のコマンドが自動的に実行されます

- npm install
- bundle install
- rake db:migrate:reset (or rails db:migrate:reset)
- rake db:seed (or rails db:seed)

#### sample

`docker-compose.yml` のサンプルです。

[https://github.com/pyar6329/docker-rails-base/blob/master/sample/dev/docker-compose.yml](https://github.com/pyar6329/docker-rails-base/blob/master/sample/dev/docker-compose.yml)

### production

#### docker build

1. [Dockerfileを作成してください](https://github.com/pyar6329/docker-rails-base/blob/master/sample/prod/builds/Dockerfile)
2. 環境変数で以下を追加してください
	- RAILS_ENV=production
	- NODE_ENV=production
	- SECRET_KEY_BASE="シークレットキー"
3. Dockerfileと同じディレクトリにrailsのリポジトリを app という名前で保存してください。

```
$ cat << EOF > Dockerfile
FROM pyar6329/rails-base:prod-2.3.1-6.3.1

ENV RAILS_ENV=production NODE_ENV=production

EXPOSE 3000
EOF
$ git clone git://railsのリポジトリ app
$ docker build .
```

#### docker run

以下のコマンドが自動的に実行されます

- npm install --production
- bundle install --without development test
- rake assets:precompile (or rails assets:precompile)
- rake db:migrate (or rails db:migrate)

#### sample

`docker-compose.yml` のサンプルです。

[https://github.com/pyar6329/docker-rails-base/blob/master/sample/prod/docker-compose.yml](https://github.com/pyar6329/docker-rails-base/blob/master/sample/prod/docker-compose.yml)

### data container

#### Installation

```
$ docker pull pyar6329/rails-base:data-latest
```

#### tools

`dockerize` がインストールされています。

#### volumes

以下のディレクトリがマウントされます

- /usr/local/sbin
- /var/lib/postgresql/data
- /etc/redis
- /etc/nginx/conf.d

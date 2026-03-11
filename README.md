# Laravelの始め方

0. Docker Desktopをインストールする

<br>
1. ターミナルにてgit cloneを行う

```bash
git clone https://github.com/shuji0425/study-laravel.git
```

<br>

2. コンポーザーのインストール

クローンを行ったディレクトリに移動

または、作成したフォルダをVScodeで開く

```bash
cd study-laravel
```

コンポーザーのインストール

```bash
cd laravel-app
composer install
```

<br>

3. .envファイルの作成

```bash
cp .env.example .env
```

<br>

4. 環境構築を行う

- Docker Desktopを開く
- docker-compose.ymlがある階層で行う

docker-compose.ymlのある階層に移動

```bash
cd ../
```

dockerを立ち上げる

```bash
docker-compose up -d --build
```

<br>

5. Dockerコンテナ内に移動

```bash
docker-compose exec app bash
```

<br>

6. アプリケーションキーの生成とキャッシュのクリア

```bash
php artisan key:generate
```

```bash
php artisan config:cache
```

<br>

7. DBにデータを入れる

```bash
php artisan migrate
```

<br>
Laravelの初期画面が表示できます。

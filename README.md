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

## 作業の進め方

1. ブランチ切り替え

```bash
git checkout -b feature/aaaa
```

**aaaには、自由な名前を入れてください。**

<br>

2. 切り替えたブランチをgit hub へプッシュ

```bash
git push origin feature/aaaa
```

**1.で作成したブランチ名をoriginの後に入力してください。**

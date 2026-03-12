# Laravel 学習用環境の作り方

このリポジトリは、Docker を使って Laravel の学習環境を作るためのものです。
ローカルに PHP や Composer を入れる必要はありません。

Mac の人は `make init` で簡単に始められます。
Windows の人は PowerShell で順番にコマンドを実行する方法が分かりやすいです。

## 事前に必要なもの

- Git
- Docker Desktop
- ターミナル

Xcode は不要です。

## Mac の人

### まず最初にやること

1. Docker Desktop を起動する
2. ターミナルを開く
3. 次のコマンドをそのまま実行する

```bash
git clone https://github.com/shuji0425/study-laravel.git
cd study-laravel
make init
```

`make init` では次の作業が自動で実行されます。

- `laravel-app/.env` の作成
- Docker コンテナの起動
- Composer パッケージのインストール
- Laravel のアプリケーションキー作成
- データベースのマイグレーション

初回は数分かかることがあります。

### 起動確認

セットアップ完了後、ブラウザで次を開いてください。

```text
http://localhost
```

Laravel の初期画面が表示されれば成功です。

### よく使うコマンド

このプロジェクトでは、基本的にルートディレクトリでコマンドを実行します。
`docker-compose.yml` がある階層です。

### コンテナを起動する

```bash
make up
```

### コンテナを停止する

```bash
make down
```

### コンテナを再ビルドして起動する

```bash
make build
```

### コンテナの状態を見る

```bash
make ps
```

### app コンテナの中に入る

```bash
make shell
```

### マイグレーションを実行する

```bash
make migrate
```

## Windows の人

Windows では `make` が最初から使えないことがあるため、PowerShell で 1 つずつ実行する方法をおすすめします。

### まず最初にやること

1. Docker Desktop を起動する
2. PowerShell を開く
3. 次のコマンドをそのまま実行する

```powershell
git clone https://github.com/shuji0425/study-laravel.git
cd study-laravel
Copy-Item laravel-app/.env.example laravel-app/.env
docker compose up -d --build
docker compose exec app composer install
docker compose exec app php artisan key:generate
docker compose exec app php artisan migrate
```

初回は数分かかることがあります。

### 起動確認

ブラウザで次を開いてください。

```text
http://localhost
```

Laravel の初期画面が表示されれば成功です。

### 補足

- Windows で `make` を使いたい場合は、WSL や GNU Make の追加インストールが必要です
- 初心者のうちは、まず PowerShell で上の手順をそのまま実行する方法で十分です

## 手動で実行したい場合

`make init` を使わずに、1つずつ実行したい場合は次の順番です。

```bash
cp laravel-app/.env.example laravel-app/.env
docker compose up -d --build
docker compose exec app composer install
docker compose exec app php artisan key:generate
docker compose exec app php artisan migrate
```

`.env` はルートではなく `laravel-app/.env` に作る点に注意してください。

## つまずきやすいポイント

### Docker Desktop が起動していない

`Cannot connect to the Docker daemon` のようなエラーが出たら、Docker Desktop を起動してください。

### `make` コマンドが使えない

- Windows では `make` が入っていないことがあります
- その場合は `make` を使わず、README の Windows 用手順を実行してください
- Mac で `make` が使える場合は、そのまま `make init` を使って問題ありません

### 画面が開かない

- ブラウザで `http://localhost` を開いているか確認する
- Mac の人は `make ps` を実行して、`app` `db` `nginx` が起動しているか確認する
- Windows の人は `docker compose ps` を実行して、`app` `db` `nginx` が起動しているか確認する

### もう一度最初からやり直したい

コンテナと DB の状態を落としてから、再度セットアップしてください。

```bash
docker compose down -v
```

`docker compose down -v` は DB データも削除します。必要なデータがある場合は実行しないでください。

その後の再セットアップは、Mac の人は `make init`、Windows の人は Windows 用手順を上からやり直してください。

## 開発の進め方

新しい作業を始めるときは、ブランチを切って進めてください。

```bash
git checkout -b feature/aaaa
git push origin feature/aaaa
```

`aaaa` の部分は、作業内容が分かる名前にしてください。
例: `feature/login-page`

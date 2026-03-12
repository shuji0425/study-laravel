.DEFAULT_GOAL := help

# 各ターゲットで共通して使うコマンドとパス
COMPOSE := docker compose
APP := app
APP_DIR := laravel-app

.PHONY: help init up down build restart logs ps shell composer-install key migrate fresh

# `make` だけ実行したときに使い方を表示
help:
	@printf '%s\n' \
	"make init              初回セットアップ" \
	"make up                コンテナ起動" \
	"make down              コンテナ停止" \
	"make build             コンテナ再ビルド" \
	"make restart           コンテナ再起動" \
	"make logs              ログ表示" \
	"make ps                コンテナ状態表示" \
	"make shell             app コンテナに入る" \
	"make composer-install  Composer 依存関係を入れる" \
	"make key               Laravel の APP_KEY を生成" \
	"make migrate           マイグレーション実行" \
	"make fresh             migrate:fresh --seed を実行"

# 初回セットアップ用
# laravel-app/.env を作成し、コンテナ起動後に Laravel の準備を行う
init:
	@test -f $(APP_DIR)/.env || cp $(APP_DIR)/.env.example $(APP_DIR)/.env
	$(COMPOSE) up -d --build
	$(COMPOSE) exec $(APP) composer install
	$(COMPOSE) exec $(APP) php artisan key:generate
	$(COMPOSE) exec $(APP) php artisan migrate --force

# コンテナをバックグラウンドで起動
up:
	$(COMPOSE) up -d

# コンテナを停止
down:
	$(COMPOSE) down

# イメージを再ビルドしてコンテナを起動
build:
	$(COMPOSE) up -d --build

# コンテナを停止してから再起動
restart: down up

# コンテナのログを表示
logs:
	$(COMPOSE) logs -f

# コンテナの状態を表示
ps:
	$(COMPOSE) ps

# app コンテナの中でシェルを開く
shell:
	$(COMPOSE) exec $(APP) bash

# app コンテナ内で Composer 依存関係をインストール
composer-install:
	$(COMPOSE) exec $(APP) composer install

# Laravel のアプリケーションキーを生成
key:
	$(COMPOSE) exec $(APP) php artisan key:generate

# データベースのマイグレーションを実行
migrate:
	$(COMPOSE) exec $(APP) php artisan migrate

# データベースを作り直して seed を実行
fresh:
	$(COMPOSE) exec $(APP) php artisan migrate:fresh --seed

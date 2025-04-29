FROM node:18-alpine AS builder

WORKDIR /app

# package.jsonとpackage-lock.jsonだけ先にコピーしてキャッシュ活用
COPY package*.json ./

# 依存関係をインストール
RUN npm install

# アプリ本体をコピー
COPY . .

# Next.jsのビルド（静的ファイルや最適化ファイルを生成）
RUN npm run build

# --- 実行ステージ（軽量） ---
FROM node:18-alpine

WORKDIR /app

# builderステージからビルド成果物をコピー
COPY --from=builder /app ./

# devDependenciesをインストールせずに、本番用依存関係だけにする
RUN npm install --omit=dev

# 環境変数で本番モードを指定
ENV NODE_ENV=production

# Next.jsアプリが使用するポート
EXPOSE 3000

# アプリを本番モードで起動
CMD ["npm", "start"
# Docker講座 

## 0-1 このtechプレゼンの進め方
 - 40分のプレゼン<br>
 ・０章-イントロダクション <br>
 ・１章-概要説明<br>
 ・２章-実演しながら使いから紹介<br>
 ・３章-まとめ<br>


## 0-2 ゴール

この40分間のTechプレゼンで、次のことが理解できるようになります：

- Dockerが解決する課題
- Dockerの基本的な仕組みと構成要素
- 仮想マシンとの違い
- コンテナ技術がもたらす開発・運用へのインパクト
- 開発現場やチームでの活用イメージ
 - プレゼンの後にgithubの専用レポジトリの中のデータをつかって各々実践<br>
 ➡ **自宅サーバーに専用のVMを用意したので、興味がある人は実際のサーバーを使ってデプロイできます！**

---

## 1-1. そもそも「Docker」とは？

### ▶ 開発現場のあるある

- 「自分の環境では動いたんだけど…」
- 開発環境・本番環境の違いによる不具合
- セットアップに時間がかかる

### ▶ Dockerを一言で説明すると...

> **「アプリケーションとその動作環境を一つのパッケージ（コンテナ）として実行できる技術」**

...とは聞いていても、普段個人開発で使っていてあまりそのメリットを体験することはあまり多くないと思います

---

## 1-2. Dockerの仕組み

Dockerがどう動いているのか？  
コンテナがどうやって作られて、動くのか？  
ここでは仕組みを**わかりやすく順番に説明**していきます。

---

### ▶ Dockerは「コンテナ」という軽量な仮想環境を作る仕組み

- Dockerは仮想マシンのようにOSごと仮想化するのではありません。
- **ホストOSのカーネルを共有しながら**、アプリケーションごとに分離された実行環境（コンテナ）を作ります。

---

### ▶ Dockerの基本構成図（イメージ）

```plaintext
[ ホストOS ]
    ↓
[ Docker Engine（デーモン）]
    ↓
[ イメージ ] → [ コンテナ ]
```



## 1-3. 仮想マシンとの違い

| 比較項目           | 仮想マシン (VM)           | Docker（コンテナ）       |
|--------------------|---------------------------|---------------------------|
| 起動時間           | 数十秒～数分               | 数秒                      |
| オーバーヘッド     | 高い（OSごと仮想化）       | 少ない（ホストOSを共用） |
| イメージサイズ     | GB単位が多い               | MB～数百MB                |
| 使用用途           | 完全な仮想環境が必要なとき | 軽量な環境分離が必要なとき|

➡ **Dockerは「速い・軽い・手軽」な仮想環境**

---

## 1-4. なぜ今Dockerが流行りなのか？

- **クラウド時代との相性がいい**  
  → AWS, GCP, Azureなど各社が対応
dockerを使えばクラウド間の環境差異を吸収したり、高速にスケーリングができる
- **CI/CDパイプラインでの活用**  
現代の開発では、コードを書いたらすぐにテストする傾向にあり、
「問題なければ自動で本番反映」といった「自動化の流れ（CI/CD）」が当たり前になっている。
Dockerを使えば、本番環境へのデプロイもDockerイメージで統一できる ため、一貫した自動化パイプラインが作れる。

- **インフラエンジニアだけでなく、全ての開発者に役立つ**
個々の開発者が自分で環境構築・運用まで簡単にできるため、チーム全体で「同じ環境」を共有できるようになり、全開発者の生産性向上ツールとなっている。

---

## 1-5. 現場での使われ方（イメージ）

- **開発環境の統一**：新しいメンバーも`docker-compose up`で即参入
- **マイクロサービス構築**：複数サービスをコンテナで管理
- **自動テスト環境の構築**：毎回クリーンな状態でテスト実行
- **スケーラブルな本番環境**：Kubernetesと連携して自動スケーリング
### ▶豆知識「dockerの導入事例」
実際の導入事例を見ていきます
#### Docker導入事例

| 企業/団体名 | 活用内容 |
|:-----------|:---------|
| **Spotify** | 音楽ストリーミングサーバーやデータパイプラインをDockerコンテナ化し、開発チームごとに独立した環境を運用。環境構築スピードとデプロイの一貫性を大幅改善。 |
| **PayPal** | アプリケーションの開発・テスト環境をDockerベースに移行し、従来の仮想マシン環境よりも90％以上の起動時間短縮。 |
| **ADP（給与・人事サービス）** | 各国ごとに異なる法律・仕様対応をコンテナ化して分離し、迅速なリリースサイクルを実現。 |



#### Kubernetes導入事例

| 企業/団体名 | 活用内容 |
|:-----------|:---------|
| **Airbnb** | 数百種類のマイクロサービスをKubernetes上で管理。オートスケールと自動復旧による可用性向上を達成。 |
| **Pinterest** | 毎日数億件以上のユーザーリクエストを処理。Kubernetesでトラフィックの急増にも自動対応できる体制を整備。 |
| **日本経済新聞社** | 記事配信システムをKubernetesへ移行。コンテンツ配信の高速化、トラフィック変動への柔軟対応を実現。 |


---
## 1-6. Dockerの中身：どうやって動く？

### 主な構成要素

- **イメージ（Image）**  
  アプリとその環境を一体化した"設計図"

- **コンテナ（Container）**  
  イメージを実行した実体。軽量な仮想環境。

- **Dockerfile**  
  イメージを自動で作るためのレシピ。

- **Docker Engine**  
  コンテナを動かす仕組みそのもの。

---

## 1-7. よくある誤解

- ❌ DockerはVMの代わり → 違います！より**軽量で目的が違う**
- ❌ Dockerを使えばセキュリティ万全 → セキュリティ設計は別途必要
- ❌ 難しそう → 基本操作だけなら**数コマンドで始められる**

---

## 1-8. dockerをどう活かす？

- 自分のアプリをDocker化してポートフォリオに
- チームで共通環境をDockerで構築・共有
- 今後の「Kubernetes」「CI/CD」「クラウド活用」にスムーズにつながる

---

## 1-9 概要まとめ

- Dockerはアプリ＋その環境をひとまとめにして動かす技術
- 軽量・高速・再現性が高く、現代の開発スタイルにマッチ
- 小規模でも導入メリットあり

---

## 1-10. 上級者向け

さらにDockerの内部構造まで理解したい方向けに、上級者向けパートを用意しました。(時間の都合上プレゼンでは扱いません)

---

### ▶ 1-10-1. Dockerのネットワーク仕組み

Dockerでは、コンテナ同士やホストとの通信を**仮想ネットワーク**で管理しています。

| 種類            | 特徴                                 |
|-----------------|------------------------------------|
| bridge（デフォルト） | 同一ホスト内コンテナ同士の通信に利用   |
| host            | ホストマシンのネットワークをそのまま使う |
| none            | ネットワークに接続しない（完全隔離）   |
| overlay         | 複数ホスト間でネットワークを構成（Swarmなど） |

#### 🔹 よく使うコマンド

- ネットワーク一覧を表示
  ```bash
  docker network ls

- 新しいネットワークを作成
```
docker network create my-network
```

- コンテナ起動時にネットワークを指定
```
docker run --network=my-network my-container
```
---
### ▶ 1-10-2. Dockerのデーモンとクライアントアーキテクチャ

Dockerは**クライアント-サーバーアーキテクチャ**を採用して動いています。  
ユーザーがコマンドを打つだけでコンテナが作られるのは、裏側でデーモンがリクエストを受け取って動いているためです。

---

#### 🔹 アーキテクチャの基本構成

| 役割            | 説明                                                  |
|-----------------|------------------------------------------------------|
| Docker CLI      | ユーザーが操作するコマンドラインツール (`docker run`など) |
| Docker Daemon   | バックグラウンドで動き、コンテナやイメージを実際に管理するサーバープロセス |
| Docker API      | CLIとデーモンの間で通信を行う仕組み。UNIXソケットやTCPで接続される |

---

#### 🔹 通信の流れ

```plaintext
[ユーザー]
  ↓ (CLIコマンド)
[Docker CLI]
  ↓ (APIリクエスト)
[Docker Daemon]
  ↓ (レスポンス)
[Docker CLI]

```

- CLIは、Docker API経由でリクエストを送信します。

- Daemonがそのリクエストを受け取り、実際にコンテナ作成・起動・削除などを行います。
- 結果をCLIに返します。

#### 🔹 デーモンが待ち受ける場所
通常：
/var/run/docker.sock（Unixドメインソケット）

ローカルのCLIとデーモンがこのソケットを介して通信します。

リモート管理時（オプション）：
TCPポート（例：2375番ポート）

設定により、リモートマシンのDockerデーモンを直接操作することも可能です。

#### 🔹 デーモンとセキュリティ
/var/run/docker.sock にアクセスできるユーザーは、root権限と同等と見なされます。

セキュリティ上、アクセス制御（dockerグループ管理やRootlessモード）を設定することが推奨されます。

### ▶ 1-10-3. コンテナのライフサイクルと状態管理

Dockerコンテナは、ただ「起動する・停止する」だけではなく、  
**ライフサイクル（生成～削除までの流れ）と、それぞれの状態**を持っています。

これを理解すると、より正しくDockerを扱うことができるようになります。
(2-0も参照)

### ▶ 1-10-4. イメージのレイヤー構造

実のところDockerイメージは単なるファイルの塊ではなく、  
**レイヤー（層）構造**によって成り立っています。

---

#### 🔹 レイヤーとは？

- **Dockerfileの各命令（FROM、RUN、COPYなど）ごとにレイヤーが作られる**
- レイヤーは読み取り専用
- 変更があった場合は、新しいレイヤーが上に積み重なる

---

#### 🔹 レイヤーの仕組み図（イメージ）

```plaintext
[ ベースイメージ ]   ← FROM
      ↓
[ パッケージインストール ]   ← RUN apt install
      ↓
[ アプリケーションファイル ] ← COPY . .
      ↓
[ 最終レイヤー：完成したイメージ ]


```
🔹 レイヤーを見るコマンド
イメージのレイヤー構造を確認するには：

```
docker history <イメージIDまたはイメージ名>
```
例：
```
docker history my-next-app
```
どのコマンドがどのレイヤーを作ったか、サイズ・日時と共に表示されます。

#### 🔹 レイヤーキャッシュの効果
Dockerは過去に作成したレイヤーをキャッシュします。

変更がないレイヤーは再ビルドせずに流用されるため、ビルドが圧倒的に速くなります。

#### 🔹 レイヤー最適化のコツ
頻繁に変わるもの（ソースコード）は最後にCOPYする

依存パッケージインストール (npm install など) はなるべく早い段階で実行する

不要ファイルはビルドに含めない（.dockerignoreを活用）

最適化例：

```Dockerfile
# 悪い例（全部まとめてコピー）
COPY . .

# 良い例（package.jsonだけ先にコピーして依存インストール）
COPY package*.json ./
RUN npm install
COPY . .
```

### ▶ 1-10-6. Dockerのセキュリティについて

Dockerは非常に便利ですが、適切なセキュリティ対策をしなければ  
**ホストシステムごと危険にさらすリスク**があります。

このセクションでは、Dockerを安全に運用するための基本知識を紹介します。

---

#### 🔹 なぜDockerのセキュリティが重要なのか？

- コンテナは**ホストカーネルを共有**しているため、  
  コンテナ内での攻撃がホストに影響を与えるリスクがある
- デフォルトでは**コンテナがほぼroot権限**で動く
- 悪意あるイメージをpullすると、脆弱性を持ち込む可能性がある

---

#### 🔹 セキュリティ対策の基本

| 対策                              | 説明                                        |
|:----------------------------------|:-------------------------------------------|
| 公式イメージや信頼できるイメージのみ使用 | 不明な作者のイメージを使わない               |
| 最小権限の原則                     | コンテナに必要最低限の権限だけを与える         |
| Rootlessモードの利用               | 非rootユーザーでDockerデーモンを動かす         |
| Dockerfileでユーザーを指定          | `USER`命令でroot以外のユーザーで実行する        |
| ネットワークやボリュームのアクセス制御 | 不要なポート・共有ディレクトリを制限する        |
| セキュリティアップデートの定期実施  | ベースイメージ・パッケージを常に最新に保つ      |
| コンテナイメージをスキャン           | 脆弱性スキャンツール（例：Trivy）を使う         |

---

#### 🔹 Dockerfileで最小権限設定の例

```Dockerfile
FROM node:18-alpine

# 通常ユーザーを作成
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# 作業ディレクトリ設定
WORKDIR /app

# アプリをコピー
COPY . .

# 権限を最小化して実行
USER appuser

CMD ["node", "app.js"]
```
- USER appuserを使うことで、root権限ではなく一般ユーザーでアプリが動くようになります。
#### 🔹 コンテナのセキュリティスキャン例（Trivy）
Trivyを使えば、イメージの脆弱性を簡単に検査できます。

```bash
trivy image my-next-app
```
脆弱なライブラリや設定ミスがないかチェックできます。

本番運用では必ず導入を検討する必要あり。

### ▶ 1-10-7. Dockerセキュリティ超実践編（AppArmor/SELinux/Capability制御など）

Dockerのセキュリティをさらに強化するために、Linuxカーネルレベルでコンテナの動作を制御する技術を取り入れます。

---

#### 🔹 AppArmor と SELinuxとは？

| 技術名         | 説明 |
|:---------------|:----|
| AppArmor       | ファイルパスベースでアクセス制御を行う（Ubuntu系に標準搭載） |
| SELinux        | セキュリティコンテキストによるアクセス制御（RHEL/CentOS系に標準搭載） |

これらを使うことで、万が一コンテナ内で侵害が発生しても、ホストシステムへの被害を最小化できます。

---

#### 🔹 AppArmorをDockerコンテナに適用する例

```bash
docker run --security-opt apparmor=docker-default nginx

```
- docker-defaultはDocker標準の緩やかなAppArmorプロファイルです。

- 独自プロファイルを作成して適用することも可能です。

#### 🔹 Capability制御（細かい権限設定）
コンテナ起動時に、必要最小限の権限だけ付与することができます。

すべてのcapabilityを削除し、必要なものだけ追加する例：

```bash
docker run --cap-drop ALL --cap-add NET_BIND_SERVICE nginx
```
--cap-drop ALLですべて削除

--cap-add NET_BIND_SERVICEで、80番/443番ポートバインドだけ許可

#### ✅ まとめ

カーネルレベルでの制御（AppArmor/SELinux）を使うとセキュリティが飛躍的に向上

Capability管理でコンテナのシステムアクセスを必要最小限にできる

### ▶ 1-10-8. Rootless Docker運用と最小権限実践例
通常、Dockerデーモンはroot権限で動きます。
しかし、本番環境では**Rootless Docker（非root運用）**を使うのが推奨されています。

#### 🔹 Rootless Dockerとは？<br>
Dockerデーモンとコンテナの両方を一般ユーザー権限で動かす仕組み
ホストシステムへの侵害リスクを大幅に低減できる

#### 🔹 Rootless Dockerのインストール例（Ubuntu）
```
sudo apt install docker-ce-rootless-extras
dockerd-rootless-setuptool.sh install
```
その後、環境変数を設定してDockerコマンドを実行できるようにします。

#### 🔹 最小権限Dockerfile実践例
```Dockerfile

FROM node:18-alpine
```
#### 通常ユーザー作成
```
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /app

COPY . .


# 通常ユーザーで実行
USER appuser

CMD ["node", "server.js"]
```
USER appuserを指定することで、コンテナ内も非rootで実行されます。

#### ✅ まとめ

Rootless Docker導入でホストセキュリティを大幅向上

コンテナ内部でも最小権限ユーザー運用を徹底するべき

▶ 1-10-9. Docker Content Trustとイメージ署名管理
イメージの改ざんやなりすましを防ぐために、Dockerには**Content Trust（DCT）**機能があります。

#### 🔹 Docker Content Trust（DCT）とは？
pullやpushを行うイメージにデジタル署名を付与/検証する仕組み

改ざんされたイメージや不正なイメージを防止できる

#### 🔹 DCTを有効化する方法
DCTを有効にするには、環境変数を設定するだけです。

```
export DOCKER_CONTENT_TRUST=1
```
その状態で、pullやpushを行うと、署名チェックが行われます。


#### 🔹 注意点
署名未対応のリポジトリ（例：一部プライベートレジストリ）ではエラーになる

本番運用では、DCT対応レジストリ（Docker Hub, Harborなど）を利用推奨

#### ✅ まとめ

Content Trustでイメージ配布時の信頼性を確保

本番環境ではDCT有効化を必須にすべき

pull/push前に環境変数設定を忘れずに！

---

# 2-0 Docker コマンド一覧

実演パートに入る前にdockerのコマンドを確認します

## 📦 イメージ関連コマンド

| コマンド                                | 説明                         |
|:----------------------------------------|:------------------------------|
| `docker pull <イメージ名>`               | イメージをリポジトリから取得     |
| `docker build -t <イメージ名> .`         | Dockerfileからイメージをビルド   |
| `docker images`                         | ローカルにあるイメージ一覧を表示 |
| `docker rmi <イメージID>`                | イメージを削除                  |
| `docker tag <元イメージ> <新しいタグ>`    | イメージに新しいタグを付ける     |

---

## 🛠️ コンテナ操作コマンド

| コマンド                                | 説明                         |
|:----------------------------------------|:------------------------------|
| `docker run -it <イメージ名>`             | コンテナを起動（対話モード）     |
| `docker run -d <イメージ名>`              | コンテナをバックグラウンド起動    |
| `docker ps`                              | 起動中のコンテナ一覧を表示        |
| `docker ps -a`                           | すべてのコンテナを表示           |
| `docker start <コンテナID>`               | コンテナを開始                   |
| `docker stop <コンテナID>`                | コンテナを停止                   |
| `docker restart <コンテナID>`             | コンテナを再起動                 |
| `docker rm <コンテナID>`                  | コンテナを削除                   |
| `docker exec -it <コンテナID> /bin/sh`    | コンテナ内でシェルを起動          |
| `docker logs <コンテナID>`                | コンテナのログを表示             |

---

## 📡 ネットワーク関連コマンド

| コマンド                                | 説明                         |
|:----------------------------------------|:------------------------------|
| `docker network ls`                     | ネットワーク一覧を表示         |
| `docker network create <ネットワーク名>` | 新しいネットワークを作成       |
| `docker network inspect <ネットワーク名>` | ネットワークの詳細を表示       |
| `docker network rm <ネットワーク名>`     | ネットワークを削除             |

---

## 💾 ボリューム関連コマンド

| コマンド                                | 説明                         |
|:----------------------------------------|:------------------------------|
| `docker volume ls`                      | ボリューム一覧を表示           |
| `docker volume create <ボリューム名>`    | 新しいボリュームを作成         |
| `docker volume inspect <ボリューム名>`   | ボリュームの詳細を表示         |
| `docker volume rm <ボリューム名>`        | ボリュームを削除               |

---

## 🧹 クリーンアップ系コマンド

| コマンド                                | 説明                         |
|:----------------------------------------|:------------------------------|
| `docker system prune`                   | 未使用のコンテナ・イメージ・ネットワークを一括削除 |
| `docker container prune`                | 停止中のコンテナを削除         |
| `docker image prune`                    | 未使用イメージを削除           |
| `docker volume prune`                   | 未使用ボリュームを削除         |
| `docker network prune`                  | 未使用ネットワークを削除        |

---

# ✅ まとめ

- **イメージ関連**：pull, build, images, rmi, tag
- **コンテナ関連**：run, ps, start, stop, rm, exec, logs
- **ネットワーク関連**：network create/ls/inspect/rm
- **ボリューム関連**：volume create/ls/inspect/rm
- **クリーンアップ**：system prune などで一括掃除！







# ２章Docker実演

## 🎯 実演の目的

- macOS上でNext.jsアプリをDocker化して起動
- DebianサーバーにDockerでデプロイ
- クライアントとサーバーの環境差を吸収できることを確認

---

## 2-1. 前提環境

### クライアント（macOS）

- Docker Desktop インストール済み
- VSCode推奨

### サーバー（Debian）

- Docker + Docker Compose インストール済み
- SSH接続できる状態

---

## 2-2. プロジェクト作成（macOS上）

```bash
npx create-next-app my-next-app
cd my-next-app

```


## 2-3. Dockerfileの作成

Next.jsアプリをDockerで動かすには、まず `Dockerfile` を用意します。

このファイルでは、アプリをどういう環境で、どんな手順でセットアップし、どのコマンドで起動するかを記述します。

以下がDockerfile

```Dockerfile
# Node.jsの軽量版イメージをベースにする（alpineは最小構成）
FROM node:18-alpine

# アプリケーションを配置するディレクトリを作成
WORKDIR /app

# パッケージ定義ファイルをコピー
COPY package*.json ./

# 依存関係をインストール
RUN npm install

# 残りのアプリケーションのコードを全てコピー
COPY . .

# アプリが使用するポート（Next.jsのデフォルトは3000）
EXPOSE 3000

# アプリを開発モードで起動
CMD ["npm", "run", "dev"]

```
## 2-4 dockerignoreの作成
.dockerignore ファイルは、Dockerに「コピーしなくていいファイル」を指示するためのファイルです。

特に開発中は node_modules や .next ディレクトリなど、イメージ内に不要な一時ファイルを除外してビルドを軽量に保ちます。


## 2-5. Dockerでビルド＆実行（ローカル：macOS）

作成したDockerfileを使って、ローカルでNext.jsアプリをDockerイメージにビルドし、実行します。

### イメージのビルド

```bash
docker build -t my-next-app .
```


コンテナの起動
``` bash
docker run -p 3000:3000 my-next-app
-p 3000:3000：ホストの3000番ポートを、コンテナの3000番ポートにマッピングします。
```
ブラウザで以下にアクセスして確認：
http://localhost:3000
## 2-6. Docker Composeの導入

Docker Composeを使うと、複数の設定（ビルド・ポート・ボリューム・環境変数など）をdocker-compose.ymlファイルで一括管理できる。

docker-compose.yml の作成

```docker-compose.yml
version: "3.8"

services:
  web:
    build: .
    ports:
      - "3000:3000"
    volumes:
      - .:/app
      - /app/node_modules
    environment:
      - NODE_ENV=development

```
docker-composeの起動
```bash
docker compose up
```
## 2-7 サーバーへのデプロイ

ローカルで作成したプロジェクトを、Debianサーバーに転送してデプロイします。

```bash
scp -r ./my-next-app username@<サーバーIP>:/home/username/

```
注:SCPコマンドはSecureShellプロトコルを利用してデータを転送するコマンドです。(-r：ディレクトリを再帰的にコピー)(username@<サーバーIP>：ログインユーザーとサーバーIPを指定)

## 2-8 サーバー上でDocker Composeによる起動

SSHでサーバーにログイン
```bash
ssh username@<サーバーIP>
```
プロジェクトフォルダに移動し、起動
```bash
cd /home/username/my-next-app
docker compose up -d
```
## 2-9 外部からの動作確認
ブラウザで次のURLにアクセスして、サーバー上のNext.jsアプリが動作しているか確認します

- http://<サーバーIP>:3000
## 2-10. 本番用Dockerfileの書き換え（任意）

開発モード（`npm run dev`）では、
- 自動リロード
- 開発者向けログ出力
など、開発に便利な機能が有効になっています。

しかし本番環境では、
- 高速な応答
- セキュリティ向上
- 安定稼働
を重視するため、**ビルド済みのコードを「本番モード」で起動**する必要があります。

そのため、本番向けにDockerfileを**マルチステージビルド**形式に書き換えます。

---

### 🎯 本番用Dockerfile（完成形）

```Dockerfile
# --- ビルドステージ ---
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
CMD ["npm", "start"]

```

それぞれのステップ解説<br>
### ① FROM node:18-alpine AS builder
ビルド専用のイメージを作成します。

AS builderと名前を付けて後で参照できるようにしています。

### ② WORKDIR /app
/appディレクトリを作業ディレクトリに設定します。

以降の操作はすべてこの中で行われます。

### ③ COPY package*.json ./
最初に package.json と package-lock.json だけをコピーします。

これにより、依存関係のインストールをキャッシュでき、ビルド時間を短縮できます。

### ④ RUN npm install
アプリの依存パッケージをインストールします。

### ⑤ COPY . .
ソースコード全体をコピーします。

この順番にすることで、もしコードだけが変更された場合でも、依存関係のインストールを再実行せずに済みます。

### ⑥ RUN npm run build
Next.jsアプリをビルドします。

静的ファイル（HTML/CSS/JSなど）や最適化ファイルが .next/ フォルダに生成されます。

### ⑦ 本番用実行ステージに切り替え
軽量化のため、ビルドとは別のクリーンなコンテナイメージを使います。

### ⑧ COPY --from=builder /app ./
ビルド成果物（アプリ全体）をコピーします。

開発時にしか使わない一時ファイルなどは含まれません。

### ⑨ RUN npm install --omit=dev
本番環境に不要な devDependencies をインストールしないことで、イメージをさらに軽量化します。

### ⑩ ENV NODE_ENV=production
環境変数で「本番モード」を明示します。

本番用にNext.jsやNode.jsの挙動が最適化されます。

### ⑪ EXPOSE 3000
Next.jsはデフォルトで3000番ポートを使用します。

これによりDockerが外部公開するポートを認識します。

### ⑫ CMD ["npm", "start"]
npm startはnext startを呼び出し、ビルド済みアプリを本番モードで起動します。

## 2-11 上級者向け　NGINXも一緒に起動してみる
次に
- Next.js（本番モード）
- Nginx（リバースプロキシ＋静的配信）<br>
を一緒に起動する流れをカバーします。
(複数のアプリを起動することで本番に近い環境でdockerを利用できます。)

### 🎯 ゴール

- Next.js本番用アプリをDockerコンテナで動かす
- その前段にNginxを置き、リバースプロキシとしてHTTPS/ポート番号非表示対応を可能にする
- **複数サービスをDocker Composeでまとめて起動・管理する**



### 📁 プロジェクト構成例

```plaintext
my-next-app/
├── Dockerfile
├── docker-compose.yml
├── nginx/
│   └── default.conf
├── package.json
├── next.config.js
├── その他のNext.jsファイル
```

### ①.NEXT.js用のdockerfile作成
```dockerfile
# --- ビルドフェーズ ---
FROM node:18-alpine AS builder

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# --- 実行フェーズ ---
FROM node:18-alpine

WORKDIR /app
COPY --from=builder /app ./
RUN npm install --omit=dev

ENV NODE_ENV=production
EXPOSE 3000
CMD ["npm", "start"]
```
### ② Nginx設定ファイル（リバースプロキシ設定）
ファイル名：nginx/default.conf

```
server {
    listen 80;

    server_name _;

    location / {
        proxy_pass http://web:3000;　＃nextのポート番号
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
```
注:コンテナ間通信なので、localhostではなくサービス名webを指定します。

### ③ docker-compose.ymlの作成

```version: "3.8"

services:
  web:
    build: .
    container_name: nextjs_app
    expose:
      - "3000" # 内部だけで公開する
    environment:
      - NODE_ENV=production

  nginx:
    image: nginx:latest
    container_name: nginx_proxy
    ports:
      - "80:80"
    volumes:
      - ./nginx/default.conf:/etc/nginx/conf.d/default.conf
    depends_on:
      - web
```

### ④ 起動方法
プロジェクトディレクトリで実行：
```
docker compose up -d
```
これでWEBアプリが配信できる。


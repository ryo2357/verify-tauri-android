FROM rust:latest

RUN apt update && \
    apt install -y \
    # 必用なもの
    build-essential \
    libwebkit2gtk-4.1-dev \
    curl \
    wget \
    libssl-dev \
    libgtk-3-dev \
    libayatana-appindicator3-dev \
    librsvg2-dev \
    # 動作検証用
    x11-apps \
    # 記事で追記されていたもの
    # vim \
    clang \
    cmake 
    # 公式から
    

# フロントがRustでWASM関係の物が多い。不要そうなものは外した
# RUN rustup component add rls rust-analysis rust-src rustfmt clippy && \
#     cargo install cargo-edit cargo-watch cargo-make sqlx-cli tauri-cli trunk && \
#     rustup install nightly && \
#     rustup target add wasm32-unknown-unknown

RUN rustup component add rls rust-analysis rust-src rustfmt clippy && \
    cargo install \
        cargo-edit \
        cargo-watch \ 
        cargo-make \
        tauri-cli

RUN cargo install create-tauri-app --locked

# Node.jsのインストール
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

# pnpmのインストール
RUN npm install -g pnpm

# Android Studioのダウンロードとインストール
# gzの最新版のアドレスはどのように更新するか検証が必用
RUN wget https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2024.2.1.11/android-studio-2024.2.1.11-linux.tar.gz -O /tmp/android-studio.tar.gz \
    && tar -xzf /tmp/android-studio.tar.gz -C /opt \
    && rm /tmp/android-studio.tar.gz
# 64 ビットマシンに必要なライブラリ
# 32ビットアーキテクチャのサポートを有効にする
RUN dpkg --add-architecture i386a
RUN apt-get update && apt-get install -y libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386
RUN dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get install -y libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386


    # 環境変数の設定
ENV ANDROID_HOME /opt/android-studio
ENV PATH $ANDROID_HOME/bin:$PATH

# Android SDKとNDKのインストール
RUN yes | $ANDROID_HOME/bin/sdkmanager --licenses \
    && $ANDROID_HOME/bin/sdkmanager "platform-tools" "platforms;android-30" "build-tools;30.0.3" "ndk-bundle"


ENV RUST_BACKTRACE=1
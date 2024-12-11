# ベースイメージとしてDebianを使用
FROM debian:bullseye-slim

# 必要なツールをインストール
RUN apt-get update && apt-get install -y \
    git \
    curl \
    gnupg \
    build-essential \
    libssl-dev \
    pkg-config \
    libgtk-3-dev \
    libayatana-appindicator3-dev \
    librsvg2-dev \
    openjdk-11-jdk \
    unzip \
    android-sdk \
    android-sdk-platform-23 \
    && rm -rf /var/lib/apt/lists/*

# Rustのインストール
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Node.jsのインストール
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

# 環境変数の設定
ENV ANDROID_HOME=/usr/lib/android-sdk
ENV PATH=${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:${PATH}

# 作業ディレクトリを設定
WORKDIR /app


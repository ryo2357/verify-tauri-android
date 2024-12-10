# ベースイメージとしてDebianを使用
FROM debian:bullseye-slim

# 必要なツールをインストール
RUN apt-get update && apt-get install -y \
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
    && rm -rf /var/lib/apt/lists/*

# Rustのインストール
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Node.jsのインストール
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

# Android SDKのインストール
RUN mkdir -p /opt/android-sdk && cd /opt/android-sdk \
    && curl -o sdk-tools.zip https://dl.google.com/android/repository/commandlinetools-linux-7583922_latest.zip \
    && unzip sdk-tools.zip -d tools \
    && rm sdk-tools.zip \
    && yes | tools/bin/sdkmanager --licenses \
    && tools/bin/sdkmanager "platform-tools" "platforms;android-30" "build-tools;30.0.3"

ENV ANDROID_HOME=/opt/android-sdk
ENV PATH=${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools:${PATH}

# Tauri CLIのインストール
RUN npm install -g @tauri-apps/cli

# 作業ディレクトリを設定
WORKDIR /app

# 依存関係のインストール
RUN npm install
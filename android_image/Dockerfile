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
  cmake \
  # 公式から
  file \
  libxdo-dev


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


ENV RUST_BACKTRACE=1

# AndroidStudioの環境構築
# 64ビットに必用なライブラリ
# RUN apt-get install dpkg

RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y \
    libc6:i386 \
    libncurses5:i386 \
    libstdc++6:i386 \
    lib32z1 \
    libbz2-1.0:i386

# JAVA関係
# RUN apt install -y \
#     openjdk-11-jdk \
#     libxi6 \
#     libxrender1 \
#     libxtst6 \


RUN wget https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2024.2.1.11/android-studio-2024.2.1.11-linux.tar.gz
RUN tar -zxvf android-studio-2024.2.1.11-linux.tar.gz -C /opt

#  NDKはAndroidStudioでインストールするからいらんかも
# RUN wget -O android-ndk-r27c-linux.zip https://dl.google.com/android/repository/android-ndk-r27c-linux.zip?hl=ja
# RUN unzip android-ndk-r27c-linux.zip -d /opt/android-studio

ENV ANDROID_HOME /opt/android-studio
ENV JAVA_HOME /opt/android-studio/jbr
# AndroidStudioのGUIからインストールしているのでコントロールできない
ENV SDK_HOME /root/Android/Sdk
# ここのversion管理どうすればいい？
ENV NDK_HOME $SDK_HOME/ndk/28.0.12674087/

ENV PATH $PATH:$ANDROID_HOME/bin
# SDK系
ENV PATH $PATH:$NDK_HOME/emulator
ENV PATH $PATH:$NDK_HOME/platform-tools
# フォルダが存在していない
ENV PATH $PATH:$NDK_HOME/tools
ENV PATH $PATH:$NDK_HOME/tools/bin
# rustup target add aarch64-linux-android
# rustup toolchain install stable-aarch64-linux-android

RUN rustup target add aarch64-linux-android
# RUN rustup toolchain install stable-aarch64-linux-android ⇒解決できない必用検証が必用


# # Android Emulatorのインストール
# RUN wget -O android-emulator.zip https://dl.google.com/android/repository/emulator-linux_x64-30.9.5.zip
# RUN unzip android-emulator.zip -d /opt/android-studio/emulator

# # AVDの作成
# RUN echo "no" | /opt/android-studio/tools/bin/avdmanager create avd -n test -k "system-images;android-30;google_apis;x86_64"

# # エミュレータの起動スクリプト
# RUN echo '#!/bin/bash\n\
# /opt/android-studio/emulator/emulator -avd test -no-window -no-audio -gpu off' > /usr/local/bin/start-emulator.sh
# RUN chmod +x /usr/local/bin/start-emulator.sh

# ENV PATH $PATH:$ANDROID_HOME/emulator
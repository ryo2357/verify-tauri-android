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
  libxdo-dev \
  # 追加
  libsoup-3.0-dev \
  lld \
  libayatana-appindicator3-0.1-cil-dev \
  sudo \
  fonts-noto-cjk \
  gcc-multilib libssl-dev \
  openjdk-17-jdk-headless \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Rustの準備
RUN rustup component add rls rust-analysis rust-src rustfmt clippy && \
  cargo install \
  cargo-edit \
  cargo-watch \ 
  cargo-make \
  tauri-cli

RUN cargo install create-tauri-app --locked

ENV RUST_BACKTRACE=1

# Node.jsのインストール
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
  && apt-get install -y nodejs

# pnpmのインストール
RUN npm install -g pnpm

# Android
ENV ANDROID_HOME /home/root/Android
ENV NDK_HOME $ANDROID_HOME/ndk/27.0.11902837/

RUN mkdir -p $ANDROID_HOME/cmdline-tools \
  && curl -LO https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip?hl=ja \
  && unzip commandlinetools-linux-11076708_latest.zip \
  && mv cmdline-tools $ANDROID_HOME/cmdline-tools/latest \
  && rm commandlinetools-linux-11076708_latest.zip \
  && yes | $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager "ndk;27.0.11902837" --sdk_root=$ANDROID_HOME \
  && yes | $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager "emulator" --sdk_root=$ANDROID_HOME \
  && yes | $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager "build-tools;34.0.0" --sdk_root=$ANDROID_HOME \
  && yes | $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager "platforms;android-34" --sdk_root=$ANDROID_HOME \
  && sudo ln -s $ANDROID_HOME/ndk/27.0.11902837/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android34-clang /usr/local/bin/aarch64-linux-android-clang \
  && sudo ln -s $ANDROID_HOME/ndk/27.0.11902837/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm-ranlib /usr/local/bin/aarch64-linux-android-ranlib \
  && sudo ln -s $ANDROID_HOME/ndk/27.0.11902837/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm-ranlib /usr/local/bin/i686-linux-android-ranlib \
  && sudo ln -s $ANDROID_HOME/ndk/27.0.11902837/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm-ranlib /usr/local/bin/x86_64-linux-android-ranlib \
  && sudo ln -s $ANDROID_HOME/ndk/27.0.11902837/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm-ranlib /usr/local/bin/arm-linux-androideabi-ranlib \
  # && /home/root/.cargo/bin/rustup target add aarch64-linux-android \
  # && /home/root/.cargo/bin/rustup target add armv7-linux-androideabi \
  # && /home/root/.cargo/bin/rustup target add i686-linux-android \
  # && /home/root/.cargo/bin/rustup target add x86_64-linux-android
  && rustup target add aarch64-linux-android \
  && rustup target add armv7-linux-androideabi \
  && rustup target add i686-linux-android \
  && rustup target add x86_64-linux-android


# イメージのビルドはできるがアプリのビルドはできない
# Finished `dev` profile [unoptimized + debuginfo] target(s) in 28.99s
# Info symlinking lib "/workspace/tauri-app/src-tauri/target/aarch64-linux-android/debug/libtauri_app_lib.so" in jniLibs dir "/workspace/tauri-app/src-tauri/gen/android/app/src/main/jniLibs/arm64-v8a"
# Info "/workspace/tauri-app/src-tauri/target/aarch64-linux-android/debug/libtauri_app_lib.so" requires shared lib "libandroid.so"
# Info "/workspace/tauri-app/src-tauri/target/aarch64-linux-android/debug/libtauri_app_lib.so" requires shared lib "libdl.so"
# Info "/workspace/tauri-app/src-tauri/target/aarch64-linux-android/debug/libtauri_app_lib.so" requires shared lib "liblog.so"
# Info "/workspace/tauri-app/src-tauri/target/aarch64-linux-android/debug/libtauri_app_lib.so" requires shared lib "libm.so"
# Info "/workspace/tauri-app/src-tauri/target/aarch64-linux-android/debug/libtauri_app_lib.so" requires shared lib "libc.so"
# Info Opening Android Studio
# Error Launch failed: No such file or directory (os error 2)

# pnpm run tauri android initi
# pnpm run tauri android dev --open
# で動かない
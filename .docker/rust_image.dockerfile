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
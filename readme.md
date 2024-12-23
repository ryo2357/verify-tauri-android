# Verify-tauri-android

tauriモバイルのアンドロイド開発環境の検証

WSL2でtauriモバイルをビルドしたい

## Usage

- `.env`ファイルを作成
- `.devcontainer/devcontainer.json`の"dockerComposeFile"を調整
- devcontainerを立ち上げる

## desktop image

RustとNodeのインストールしたデスクトップアプリの開発コンテナ

SolidJSを想定してpnpmをインストールしている

WSLでのGUI表示はWSL環境の`~/.bashrc`に下記を追記

```bashrc
export DISPLAY=:0
export WAYLAND_DISPLAY=wayland-0
export XDG_RUNTIME_DIR=/mnt/wslg/runtime-dir
export PULSE_SERVER=/mnt/wslg/PulseServer
```

## android image

desktop_imageにAndroidStudioを導入したandroidアプリの開発コンテナ

SDKのインストールがAndroidStudioのGUIからでコンテナを調整する度に実行する必要がある。

解決方法を思いつかないのでコンテナでの開発は保留
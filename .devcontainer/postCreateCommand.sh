# !/bin/sh

# node_modulesディレクトリに対するアクセス権限を付与する
sudo chown node node_modules

# パッケージをインストールする
npm install -yes

# エミュレータをインストールする
avdmanager create avd -n 29_pixel_4 -k "system-images;android-29;default;x86_64" --device "pixel_4"
avdmanager create avd -n 30_pixel_5 -k "system-images;android-30;default;x86_64" --device "pixel_5"
avdmanager create avd -n 33_pixel_7 -k "system-images;android-33;default;x86_64" --device "pixel_7"

# /dev/kvmのグループIDを取得してkvmグループを設定する
KVM_GID=$(stat -c "%g" /dev/kvm)

# kvmグループが存在しない場合は作成する
if ! getent group kvm > /dev/null; then
  sudo groupadd -g $KVM_GID kvm
fi

# nodeユーザをkvmグループに追加する
sudo usermod -aG kvm node

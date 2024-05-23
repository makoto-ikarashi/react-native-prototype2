# MS提供のnodeイメージをベースとする
FROM mcr.microsoft.com/devcontainers/typescript-node:20-bullseye

# 必要なパッケージをインストールする
RUN apt-get update \
    && apt-get install libpulse0 -y \
    && apt-get install libc++1 -y \
    && apt-get install x11-apps -y \
    && apt-get install libc++abi1 -y

# 環境変数を設定する
ENV JAVA_HOME /usr/lib/jvm/java-17-openjdk-amd64
ENV ANDROID_HOME /usr/local/android-sdk
ENV ANDROID_NDK_HOME ${ANDROID_HOME}/ndk
ENV PATH ${PATH}:${JAVA_HOME}/bin
ENV PATH ${PATH}:${ANDROID_HOME}/cmdline-tools/latest/bin
ENV PATH ${PATH}:${ANDROID_HOME}/platform-tools
ENV PATH ${PATH}:${ANDROID_HOME}/emulator
ENV LD_LIBRARY_PATH ${LD_LIBRARY_PATH}:${ANDROID_HOME}/emulator/lib64/qt/lib

# JDKをインストールする
RUN apt-get install -y openjdk-17-jdk wget unzip && \
    rm -rf /var/lib/apt/lists/*

# Android cmdline-toolsをインストールする
RUN mkdir -p ${ANDROID_HOME} \
    && curl -o cmdline-tools.zip https://dl.google.com/android/repository/commandlinetools-linux-10406996_latest.zip \
    && unzip cmdline-tools.zip -d ${ANDROID_HOME} \
    && rm cmdline-tools.zip

# ANDROID_HOMEへの権限を付与する
RUN chmod 777 ${ANDROID_HOME}

# Androidビルドのため、cmdline-tools配下をlatestに配置する
RUN mkdir ${ANDROID_HOME}/wrk \
    && mv ${ANDROID_HOME}/cmdline-tools/* ${ANDROID_HOME}/wrk/ \
    && mkdir ${ANDROID_HOME}/cmdline-tools/latest \
    && mv ${ANDROID_HOME}/wrk/* ${ANDROID_HOME}/cmdline-tools/latest \
    && rmdir ${ANDROID_HOME}/wrk

# 必要なSDKコンポーネントをインストールする
RUN yes | sdkmanager --licenses \
    && sdkmanager "platform-tools" \
    # && sdkmanager "platforms;android-30" \
    # && sdkmanager "platforms;android-33" \
    && sdkmanager "platforms;android-34" \
    && sdkmanager "build-tools;34.0.0" \
    # && sdkmanager "ndk;25.1.8937393" \
    && sdkmanager "ndk;26.1.10909125" \
    # && sdkmanager "system-images;android-30;default;x86_64" \
    # && sdkmanager "system-images;android-33;default;x86_64" \
    # && sdkmanager "system-images;android-34;default;x86_64" \
    && sdkmanager "cmake;3.22.1"

# EASのCLIをインストールする
RUN npm install -g eas-cli

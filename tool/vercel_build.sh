#!/usr/bin/env bash
set -euo pipefail

FLUTTER_VERSION=3.35.6
ROOT="$(pwd)"
SDK="${ROOT}/.flutter-sdk"

if [ ! -x "${SDK}/bin/flutter" ]; then
  rm -rf "${SDK}"
  curl -fsSL -o /tmp/flutter.tar.xz \
    "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz"
  rm -rf /tmp/flutter
  tar -xJf /tmp/flutter.tar.xz -C /tmp
  mv /tmp/flutter "${SDK}"
fi

export PATH="${SDK}/bin:${PATH}"
git config --global --add safe.directory "${SDK}" || true
flutter config --enable-web --no-analytics
flutter precache --web
flutter pub get
flutter build web --release

#!/usr/bin/env bash
set -euo pipefail

FLUTTER_VERSION=3.35.6
ROOT="$(pwd)"
SDK="${ROOT}/.flutter-sdk"

if [ ! -x "${SDK}/bin/flutter" ]; then
  mkdir -p "${SDK}"
  curl -fsSL -o /tmp/flutter.tar.xz \
    "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz"
  tar -xJf /tmp/flutter.tar.xz -C "${ROOT}"
  mv "${ROOT}/flutter" "${SDK}"
fi

export PATH="${SDK}/bin:${PATH}"
git config --global --add safe.directory "${SDK}" || true
flutter config --enable-web --no-analytics
flutter precache --web
flutter pub get
flutter build web --release

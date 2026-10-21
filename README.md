# Kasa POS

Offline-first retail register. The Flutter app saves every sale in a local SQLite file, then syncs those rows when the shop is back online.

## Run

```bash
flutter pub get
dart run build_runner build
flutter run -d macos
```

## Sign in

The first launch creates one shop, **ကမ္ဘာဆိုင်**.

| Person | PIN | Opens |
| --- | --- | --- |
| မောင်မောင်, owner | 1111 | Home |
| ခင်ခင်, cashier | 2222 | Sale |

The fourth PIN digit signs in. A wrong PIN clears the boxes.

## Layout

Each feature keeps domain, data, and presentation apart.

- `lib/features/*/domain` — entities, repository contracts, use cases
- `lib/features/*/data` — SQLite reads and writes
- `lib/features/*/presentation` — screens
- `lib/core/database` — the shared `kasa.sqlite` schema

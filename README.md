# sportly

Sports team management app <-> BSc thesis project at my uni.

## Getting Started

Project uses Flutter 3.3.3

### Get dependencies

```flutter pub get```

also for iOS

```cd ios && pod install```

### Generate necessary files

```flutter pub run build_runner build --delete-conflicting-outputs```

```flutter pub run easy_localization:generate --source-dir ./assets/translations -f keys -o local_keys.g.dart -O lib/presentation/gen```

## Running

```flutter run```

## Testing

### Unit testing

```flutter test```

### Integration testing

```flutter test integration_test```

## Additional

### Generate firebase keystore

```keytool -genkey -v -keystore sportly.keystore -keyalg RSA -keysize 2048 -validity 10000 -alias androiddebugkey -storetype JKS```

```keytool -list -v -alias sportly -keystore debug.keystore```


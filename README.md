# Furio

Furkan’ın Flutter uygulamaları için geliştirdiği kişisel UI tasarım sistemi.

Tekrar kullanılabilir bileşenler, açık/koyu temalar ve Urbanist tipografisini tek bir Flutter paketinde bir araya getirir.

## Kurulum

Flutter projenizin `pubspec.yaml` dosyasına ekleyin:

```yaml
dependencies:
  flutter:
    sdk: flutter
  furio:
    git:
      url: https://github.com/furkanmulayim/furio.git
  material_ui: ^1.11.1
```

Ardından:

```sh
flutter pub get
```

Furio, Dart `^3.13.0` ve Flutter `>=3.47.0` gerektirir. Örneklerde Material bileşenleri için `material_ui` doğrudan kullanıldığı için uygulamanın bağımlılıklarına da eklenmiştir.

Belirli bir sürüme sabitlemek için Git bağımlılığına bir commit SHA'sını veya yayımlanmış etiketi `ref` olarak ekleyebilirsiniz:

```yaml
furio:
  git:
    url: https://github.com/furkanmulayim/furio.git
    ref: <commit-sha-veya-etiket>
```

Yerel geliştirmede Git bağımlılığı yerine göreli yol kullanabilirsiniz:

```yaml
furio:
  path: ../furio
```

## İçerik

| Bileşen | Özellikler |
| --- | --- |
| `FurioButton` | İkon, yüklenme göstergesi ve devre dışı durum |
| `FurioCard` | Başlık, açıklama ve özelleştirilebilir içerik |
| `FurioTextField` | Form doğrulaması, klavye ve parola seçenekleri |
| `FurioSheet` | Kaydırılabilir içerik, klavye desteği ve alt işlem butonu |

## Hızlı başlangıç

```dart
import 'package:furio/furio.dart';
import 'package:material_ui/material_ui.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Furio',
    theme: FurioTheme.light(),
    darkTheme: FurioTheme.dark(),
    themeMode: ThemeMode.system,
    home: Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: FurioCard(
          title: 'Hesap bilgileri',
          subtitle: 'Bilgilerini buradan düzenleyebilirsin.',
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const FurioTextField(label: 'Ad soyad'),
              const SizedBox(height: 16),
              FurioButton(
                label: 'Kaydet',
                icon: Icons.check,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
```

## Tema ve tipografi

`FurioTheme.light()` ve `FurioTheme.dark()`; buton, kart, metin alanı, app bar, sekme, switch, chip ve sheet görünümlerini birlikte yapılandırır.

`MaterialApp` altındaki bir `BuildContext` üzerinden renklere ve yazı stillerine erişebilirsiniz:

```dart
Text(
  'Merhaba Furio',
  style: context.typo.size24(
    color: context.color.textPrimary,
    weight: FontWeight.w600,
  ),
);
```


Temayı uygulamanıza göre değiştirebilirsiniz:

```dart
final theme = FurioTheme.light().copyWith(
  appBarTheme: FurioTheme.light().appBarTheme.copyWith(centerTitle: true),
);
```

## Bottom sheet

Bir widget içindeki `context` ile:

```dart
showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true,
  useSafeArea: true,
  showDragHandle: false,
  builder: (sheetContext) => FurioSheet(
    title: 'Filtreler',
    content: const FurioTextField(label: 'Ara'),
    onClose: () => Navigator.of(sheetContext).pop(),
    buttonText: 'Uygula',
    onButtonPressed: () => Navigator.of(sheetContext).pop(),
  ),
);
```

`isFullScreen: true` kullanılabilir yüksekliği doldurur. `isButtonDisabled: true` alt işlem butonunu devre dışı bırakır. Sheet kendi tutamacını çizdiği için modal çağrısında `showDragHandle: false` kullanılır.

## Proje yapısı

```text
lib/
├── furio.dart
├── exports/
│   ├── theme.dart
│   ├── widgets.dart
│   └── extensions.dart
└── src/
    ├── extensions/
    ├── theme/
    │   ├── colors/
    │   ├── typography/
    │   ├── shapes/
    │   ├── furio_theme.dart
    │   └── furio_widget_themes.dart
    └── widgets/
        ├── button/
        ├── card/
        ├── sheet/
        └── text_field/
assets/fonts/urbanist/
```

Tüm API için `package:furio/furio.dart` kullanın. Daha dar kapsamlı import seçenekleri de vardır:

```dart
import 'package:furio/exports/theme.dart';
import 'package:furio/exports/widgets.dart';
import 'package:furio/exports/extensions.dart';
```

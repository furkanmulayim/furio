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
| `CustomButton` | `mini` ve `big` boyutları, ikon, yüklenme göstergesi ve devre dışı durum |
| `CustomCard` | Başlık, açıklama ve özelleştirilebilir içerik |
| `CustomListTile` | Başlık, açıklama, ikon ve switch, ok veya badge gibi sağ içerik |
| `CustomTextField` | Form doğrulaması, klavye ve parola seçenekleri |
| `CustomSheet` | Kaydırılabilir içerik, klavye desteği ve alt işlem butonu |

## Hızlı başlangıç

```dart
import 'package:furio/theme/custom_theme.dart';
import 'package:furio/widgets/button/custom_button.dart';
import 'package:furio/widgets/card/custom_card.dart';
import 'package:furio/widgets/text_field/custom_text_field.dart';
import 'package:material_ui/material_ui.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Furio',
    theme: CustomTheme.light(),
    darkTheme: CustomTheme.dark(),
    themeMode: ThemeMode.system,
    home: Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: CustomCard(
          title: 'Hesap bilgileri',
          subtitle: 'Bilgilerini buradan düzenleyebilirsin.',
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const CustomTextField(label: 'Ad soyad'),
              const SizedBox(height: 16),
              CustomButton.big(
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

`CustomTheme.light()` ve `CustomTheme.dark()`; buton, kart, metin alanı, app bar, sekme, switch, chip ve sheet görünümlerini birlikte yapılandırır.

`MaterialApp` altındaki bir `BuildContext` üzerinden renklere ve yazı stillerine erişebilirsiniz:

```dart
import 'package:furio/extensions/custom_context_extension.dart';
```

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
final theme = CustomTheme.light().copyWith(
  appBarTheme: CustomTheme.light().appBarTheme.copyWith(centerTitle: true),
);
```

## Bottom sheet

Bir widget içindeki `context` ile:

```dart
import 'package:furio/widgets/sheet/custom_sheet.dart';
import 'package:furio/widgets/text_field/custom_text_field.dart';
```

```dart
showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true,
  useSafeArea: true,
  showDragHandle: false,
  builder: (sheetContext) => CustomSheet(
    title: 'Filtreler',
    content: const CustomTextField(label: 'Ara'),
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
├── extensions/
├── theme/
│   ├── colors/
│   ├── typography/
│   ├── shapes/
│   ├── custom_theme.dart
│   └── custom_widget_themes.dart
└── widgets/
    ├── button/
    ├── card/
    ├── icon/
    ├── sheet/
    └── text_field/
assets/fonts/urbanist/
```

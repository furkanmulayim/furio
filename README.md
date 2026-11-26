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
| `FurioButton` | `mini` ve `big` boyutları, ikon, yüklenme göstergesi ve devre dışı durum |
| `FurioSecondaryButton` | `FurioButton` ile aynı boyut ve davranış, temanın `border` zemin rengi |
| `FurioCard` | Başlık, açıklama ve özelleştirilebilir içerik |
| `FurioListTile` | Başlık, açıklama, ikon ve switch, ok veya badge gibi sağ içerik |
| `FurioTextField` | Form doğrulaması, klavye ve parola seçenekleri |
| `FurioSheet` | Kaydırılabilir içerik, klavye desteği ve alt işlem butonu |
| `FurioDatePicker` | Bottom sheet içinde `past`, `future` veya `any` modunda gün seçimi sunar. |
| `FurioIcon` | SVG ikonları belirlenen boyut ve renkte, isteğe bağlı çerçeveyle gösterir. |
| `FurioSegmentedButton` | Yatay seçenekler arasında tek seçim yapmayı sağlar ve seçimi animasyonla vurgular. |
| `FurioSelectField` | Seçenekleri bottom sheet içinde açar ve seçili değeri alanda gösterir. |
| `FurioSnackBar` | İkonlu bildirim mesajını isteğe bağlı bir işlemle gösterir. |

## Hızlı başlangıç

```dart
import 'package:furio/theme/custom_theme.dart';
import 'package:furio/widgets/button/furio_button.dart';
import 'package:furio/widgets/card/furio_card.dart';
import 'package:furio/widgets/text_field/furio_text_field.dart';
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
        child: FurioCard(
          title: 'Hesap bilgileri',
          subtitle: 'Bilgilerini buradan düzenleyebilirsin.',
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const FurioTextField(label: 'Ad soyad'),
              const SizedBox(height: 16),
              FurioButton.big(
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
import 'package:furio/widgets/sheet/furio_sheet.dart';
import 'package:furio/widgets/text_field/furio_text_field.dart';
```

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
    ├── date_picker/
    ├── icon/
    ├── list_tile/
    ├── segmented_button/
    ├── select_field/
    ├── sheet/
    ├── snack_bar/
    └── text_field/
assets/fonts/urbanist/
```

# FPS Jank Flash widget

A flutter widget that flashes when flutter fails to render a frame in a certain timeframe

[![lesnitsky.dev](https://lesnitsky.dev/icons/shield.svg?hash=96)](https://lesnitsky.dev?utm_source=fps_jank_flash_widget)
[![GitHub stars](https://img.shields.io/github/stars/lesnitsky/fps_jank_flash_widget.svg?style=social)](https://github.com/lesnitsky/fps_jank_flash_widget)
[![Twitter Follow](https://img.shields.io/twitter/follow/lesnitsky_dev.svg?label=Follow%20me&style=social)](https://twitter.com/lesnitsky_dev)

## Installation

```sh
flutter pub add fps_jank_flash_widget
flutter packages get
```

## Usage

```dart
import 'package:fps_jank_flash_widget/fps_jank_flash_widget.dart';

void main() {
  const frameBudget = Duration(milliseconds: 17); // 60 fps
  FPSJankFlash.frameBudget = frameBudget;

  runApp(FPSJankFlash.overlay(child: const MyApp()));
}
```

`FPSJankFlash` could be used directly:

```dart
import 'package:fps_jank_flash_widget/fps_jank_flash_widget.dart';

class SomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
         children: [
            /// ... your widgets,
          ],
        ),
        const FPSJankFlash(),
      ]
    );
  }
}
```

You can also use a `JankObserver`:

```dart
import 'package:fps_jank_flash_widget/fps_jank_flash_widget.dart';

void main() {
  JankObserver.addListener(() {
    print('jank detected');
  });

  runApp(YourApp());
}
```

If you're testing the app on a higher refresh rate displays, override the frame duration budget:

```dart
import 'package:fps_jank_flash_widget/fps_jank_flash_widget.dart';


void main() {
  const refreshRate = 120;
  final budgetMs = 1000 ~/ refreshRate;
  FPSJankFlash.frameBudget = Duration(milliseconds: budgetMs);

  runApp(FPSJankFlash.overlay(child: const MyApp()));
}
```

## License

MIT

[![lesnitsky.dev](https://lesnitsky.dev/icons/shield.svg?hash=96)](https://lesnitsky.dev?utm_source=fps_jank_flash_widget)
[![GitHub stars](https://img.shields.io/github/stars/lesnitsky/fps_jank_flash_widget.svg?style=social)](https://github.com/lesnitsky/fps_jank_flash_widget)
[![Twitter Follow](https://img.shields.io/twitter/follow/lesnitsky_dev.svg?label=Follow%20me&style=social)](https://twitter.com/lesnitsky_dev)

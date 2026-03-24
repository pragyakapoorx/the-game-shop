# thegameshop

## Getting Started

```
the-game-shop/
├── .gitignore
├── .metadata
├── README.md
├── analysis_options.yaml
├── android/
│   ├── .gitignore
│   ├── app/
│   │   ├── build.gradle.kts
│   │   └── src/
│   │       ├── debug/
│   │       │   └── AndroidManifest.xml
│   │       ├── main/
│   │       │   ├── AndroidManifest.xml
│   │       │   ├── kotlin/
│   │       │   │   └── com/
│   │       │   │       └── example/
│   │       │   │           └── thegameshop_flutter/
│   │       │   │               └── MainActivity.kt
│   │       │   └── res/
│   │       │       ├── drawable-v21/
│   │       │       │   └── launch_background.xml
│   │       │       ├── drawable/
│   │       │       │   └── launch_background.xml
│   │       │       ├── mipmap-hdpi/
│   │       │       │   └── ic_launcher.png
│   │       │       ├── mipmap-mdpi/
│   │       │       │   └── ic_launcher.png
│   │       │       ├── mipmap-xhdpi/
│   │       │       │   └── ic_launcher.png
│   │       │       ├── mipmap-xxhdpi/
│   │       │       │   └── ic_launcher.png
│   │       │       ├── mipmap-xxxhdpi/
│   │       │       │   └── ic_launcher.png
│   │       │       ├── values-night/
│   │       │       │   └── styles.xml
│   │       │       └── values/
│   │       │           └── styles.xml
│   │       └── profile/
│   │           └── AndroidManifest.xml
│   ├── build.gradle.kts
│   ├── gradle.properties
│   ├── gradle/
│   │   └── wrapper/
│   │       └── gradle-wrapper.properties
│   └── settings.gradle.kts
├── ios/
│   ├── .gitignore
│   ├── Flutter/
│   │   ├── AppFrameworkInfo.plist
│   │   ├── Debug.xcconfig
│   │   └── Release.xcconfig
│   ├── Runner.xcodeproj/
│   │   ├── project.pbxproj
│   │   ├── project.xcworkspace/
│   │   │   ├── contents.xcworkspacedata
│   │   │   └── xcshareddata/
│   │   │       ├── IDEWorkspaceChecks.plist
│   │   │       └── WorkspaceSettings.xcsettings
│   │   └── xcshareddata/
│   │       └── xcschemes/
│   │           └── Runner.xcscheme
│   ├── Runner.xcworkspace/
│   │   ├── contents.xcworkspacedata
│   │   └── xcshareddata/
│   │       ├── IDEWorkspaceChecks.plist
│   │       └── WorkspaceSettings.xcsettings
│   ├── Runner/
│   │   ├── AppDelegate.swift
│   │   ├── Assets.xcassets/
│   │   │   ├── AppIcon.appiconset/
│   │   │   │   ├── Contents.json
│   │   │   │   ├── Icon-App-1024x1024@1x.png
│   │   │   │   ├── Icon-App-20x20@1x.png
│   │   │   │   ├── Icon-App-20x20@2x.png
│   │   │   │   ├── Icon-App-20x20@3x.png
│   │   │   │   ├── Icon-App-29x29@1x.png
│   │   │   │   ├── Icon-App-29x29@2x.png
│   │   │   │   ├── Icon-App-29x29@3x.png
│   │   │   │   ├── Icon-App-40x40@1x.png
│   │   │   │   ├── Icon-App-40x40@2x.png
│   │   │   │   ├── Icon-App-40x40@3x.png
│   │   │   │   ├── Icon-App-60x60@2x.png
│   │   │   │   ├── Icon-App-60x60@3x.png
│   │   │   │   ├── Icon-App-76x76@1x.png
│   │   │   │   ├── Icon-App-76x76@2x.png
│   │   │   │   └── Icon-App-83.5x83.5@2x.png
│   │   │   └── LaunchImage.imageset/
│   │   │       ├── Contents.json
│   │   │       ├── LaunchImage.png
│   │   │       ├── LaunchImage@2x.png
│   │   │       ├── LaunchImage@3x.png
│   │   │       └── README.md
│   │   ├── Base.lproj/
│   │   │   ├── LaunchScreen.storyboard
│   │   │   └── Main.storyboard
│   │   ├── Info.plist
│   │   ├── Runner-Bridging-Header.h
│   │   └── SceneDelegate.swift
│   └── RunnerTests/
│       └── RunnerTests.swift
├── lib/
│   ├── app.dart
│   ├── core/
│   │   ├── clippers/
│   │   │   └── chamfer_clipper.dart
│   │   └── theme/
│   │       ├── cyber_colors.dart
│   │       ├── theme_data.dart
│   │       └── typography.dart
│   ├── features/
│   │   ├── arcade/
│   │   │   ├── arcade_section.dart
│   │   │   ├── crypt_maze/
│   │   │   │   └── crypt_maze_game.dart
│   │   │   ├── dungeon_duel/
│   │   │   │   ├── components/
│   │   │   │   │   └── player.dart
│   │   │   │   └── dungeon_duel_game.dart
│   │   │   ├── utils/
│   │   │   │   └── sprite_data.dart
│   │   │   └── widgets/
│   │   │       └── pixel_sprite.dart
│   │   ├── boot/
│   │   │   └── boot_screen.dart
│   │   ├── checkout/
│   │   │   ├── checkout_screen.dart
│   │   │   └── widgets/
│   │   │       ├── checkout_forms.dart
│   │   │       └── order_summary.dart
│   │   ├── game_detail/
│   │   │   ├── game_detail_screen.dart
│   │   │   └── widgets/
│   │   │       ├── detail_body.dart
│   │   │       ├── detail_hero.dart
│   │   │       └── review_section.dart
│   │   ├── library/
│   │   │   ├── library_screen.dart
│   │   │   └── widgets/
│   │   │       └── library_card.dart
│   │   ├── orders/
│   │   │   ├── orders_screen.dart
│   │   │   └── widgets/
│   │   │       └── order_accordion.dart
│   │   └── store/
│   │       ├── store_providers.dart
│   │       ├── store_screen.dart
│   │       └── widgets/
│   │           ├── hero_section.dart
│   │           └── store_controls.dart
│   ├── main.dart
│   ├── models/
│   │   ├── game.dart
│   │   └── order.dart
│   ├── providers/
│   │   ├── cart_provider.dart
│   │   ├── db_sync_provider.dart
│   │   ├── game_data_provider.dart
│   │   ├── library_provider.dart
│   │   ├── orders_provider.dart
│   │   ├── promo_provider.dart
│   │   └── reviews_provider.dart
│   └── shared/
│       ├── buttons/
│       │   ├── cyber_button.dart
│       │   └── nav_link.dart
│       ├── cards/
│       │   └── game_card.dart
│       ├── layout/
│       │   ├── hud_ticker.dart
│       │   ├── main_layout.dart
│       │   └── top_nav_bar.dart
│       └── widgets/
│           └── cyber_glitch_text.dart
├── linux/
│   ├── .gitignore
│   ├── CMakeLists.txt
│   ├── flutter/
│   │   ├── CMakeLists.txt
│   │   ├── generated_plugin_registrant.cc
│   │   ├── generated_plugin_registrant.h
│   │   └── generated_plugins.cmake
│   └── runner/
│       ├── CMakeLists.txt
│       ├── main.cc
│       ├── my_application.cc
│       └── my_application.h
├── macos/
│   ├── .gitignore
│   ├── Flutter/
│   │   ├── Flutter-Debug.xcconfig
│   │   ├── Flutter-Release.xcconfig
│   │   └── GeneratedPluginRegistrant.swift
│   ├── Runner.xcodeproj/
│   │   ├── project.pbxproj
│   │   ├── project.xcworkspace/
│   │   │   └── xcshareddata/
│   │   │       └── IDEWorkspaceChecks.plist
│   │   └── xcshareddata/
│   │       └── xcschemes/
│   │           └── Runner.xcscheme
│   ├── Runner.xcworkspace/
│   │   ├── contents.xcworkspacedata
│   │   └── xcshareddata/
│   │       └── IDEWorkspaceChecks.plist
│   ├── Runner/
│   │   ├── AppDelegate.swift
│   │   ├── Assets.xcassets/
│   │   │   └── AppIcon.appiconset/
│   │   │       ├── Contents.json
│   │   │       ├── app_icon_1024.png
│   │   │       ├── app_icon_128.png
│   │   │       ├── app_icon_16.png
│   │   │       ├── app_icon_256.png
│   │   │       ├── app_icon_32.png
│   │   │       ├── app_icon_512.png
│   │   │       └── app_icon_64.png
│   │   ├── Base.lproj/
│   │   │   └── MainMenu.xib
│   │   ├── Configs/
│   │   │   ├── AppInfo.xcconfig
│   │   │   ├── Debug.xcconfig
│   │   │   ├── Release.xcconfig
│   │   │   └── Warnings.xcconfig
│   │   ├── DebugProfile.entitlements
│   │   ├── Info.plist
│   │   ├── MainFlutterWindow.swift
│   │   └── Release.entitlements
│   └── RunnerTests/
│       └── RunnerTests.swift
├── pubspec.lock
├── pubspec.yaml
├── test/
│   └── widget_test.dart
├── web/
│   ├── favicon.png
│   ├── icons/
│   │   ├── Icon-192.png
│   │   ├── Icon-512.png
│   │   ├── Icon-maskable-192.png
│   │   └── Icon-maskable-512.png
│   ├── index.html
│   └── manifest.json
└── windows/
    ├── .gitignore
    ├── CMakeLists.txt
    ├── flutter/
    │   ├── CMakeLists.txt
    │   ├── generated_plugin_registrant.cc
    │   ├── generated_plugin_registrant.h
    │   └── generated_plugins.cmake
    └── runner/
        ├── CMakeLists.txt
        ├── Runner.rc
        ├── flutter_window.cpp
        ├── flutter_window.h
        ├── main.cpp
        ├── resource.h
        ├── resources/
        │   └── app_icon.ico
        ├── runner.exe.manifest
        ├── utils.cpp
        ├── utils.h
        ├── win32_window.cpp
        └── win32_window.h
```

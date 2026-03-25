# thegameshop

## Getting Started

```
the-game-shop/
├── README.md
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
├── pubspec.lock
├── pubspec.yaml
├── test/
│   └── widget_test.dart

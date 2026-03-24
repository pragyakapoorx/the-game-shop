// lib/providers/db_sync_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum DbSyncState { connected, saving, error }

class DbSyncNotifier extends Notifier<DbSyncState> {
  @override
  DbSyncState build() => DbSyncState.connected;

  Future<void> triggerSave() async {
    state = DbSyncState.saving;
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    state = DbSyncState.connected;
  }
}

final dbSyncProvider = NotifierProvider<DbSyncNotifier, DbSyncState>(() {
  return DbSyncNotifier();
});
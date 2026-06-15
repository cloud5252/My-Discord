// viewService.dart

import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/chat_view.dart';
import 'package:my_discord/ui/views/home/man_hub/friends_hub/fraind_hub_view.dart';
import 'package:stacked/stacked.dart';

class ViewService with ListenableServiceMixin {
  final _currentView = ReactiveValue<Widget>(const FraindHubView());
  final _currentTitle = ReactiveValue<String>("Friends");
  set currentId(String? value) => _currentId = value;
  String? _currentId;
  String? get currentId => _currentId;

  Widget get currentView => _currentView.value;
  String get currentTitle => _currentTitle.value;

  final ValueNotifier<bool> showProfileNotifier = ValueNotifier(true);
  bool get showProfile => showProfileNotifier.value;

  void toggleProfile() {
    showProfileNotifier.value = !showProfileNotifier.value;
  }

  Box get _prefsBox => Hive.box('prefs_box');

  ViewService() {
    listenToReactiveValues([_currentView, _currentTitle]);
    _restoreLastView();
  }
  void resetToDefault() {
    _currentId = null;
    _currentView.value = const FraindHubView();
    _currentTitle.value = "Friends";
  }

  void _restoreLastView() {
    final lastId = _prefsBox.get('last_chat_id') as String?;
    final lastName = _prefsBox.get('last_chat_name') as String?;

    if (lastId == null || lastName == null) return;

    _currentId = lastId;
    _currentView.value = ChatView(
      chatWithId: lastId,
      chatWithName: lastName,
    );
    _currentTitle.value = lastName;
  }

  void setView(Widget view, {String title = "Friends", String? id}) {
    if (_currentId == id && _currentTitle.value == title) return;

    _currentId = id;
    _currentView.value = view;
    _currentTitle.value = title;

    if (id != null) {
      _prefsBox.put('last_chat_id', id);
      _prefsBox.put('last_chat_name', title);
    } else {
      _prefsBox.delete('last_chat_id');
      _prefsBox.delete('last_chat_name');
    }
  }
}

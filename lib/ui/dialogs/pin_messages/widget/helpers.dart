bool isOnlyEmojis(String text) {
  final emojiRegex = RegExp(
    r'^(\s|[\u{1F300}-\u{1FAFF}]|[\u{2600}-\u{27BF}]|[\u{1F1E6}-\u{1F1FF}]|[\u{2000}-\u{206F}]|\uFE0F)+$',
    unicode: true,
  );
  return emojiRegex.hasMatch(text.trim()) && text.trim().isNotEmpty;
}

double getMessageFontSize(String text) {
  final trimmed = text.trim();
  if (isOnlyEmojis(trimmed)) {
    final emojiCount = trimmed.runes.length;
    if (emojiCount <= 8) return 40;
  }
  return 15;
}

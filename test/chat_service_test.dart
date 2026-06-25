import 'package:flutter_test/flutter_test.dart';
import 'package:my_discord/service/chat_service/chat_service.dart';

void main() {
  group('getChatRoomId', () {
    test('same input order produces same room id', () {
      final id1 = getChatRoomId('uidA', 'uidB');
      final id2 = getChatRoomId('uidB', 'uidA');
      expect(id1, equals(id2));
    });

    test('produces correctly sorted id', () {
      final id = getChatRoomId('zzz', 'aaa');
      
      expect(id, equals('aaa_zzz'));
    });
  });
}

import 'package:hive_ce/hive.dart';
import 'package:my_discord/models/hive_user_model.dart';

class HiveService {
  final _friendsBox = Hive.box<HiveUserModel>('friends_box');

  List<HiveUserModel> getCachedFriends() {
    return _friendsBox.values.toList();
  }

  Stream<BoxEvent> watchFriends() {
    return _friendsBox.watch();
  }
}

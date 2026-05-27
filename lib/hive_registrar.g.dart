import 'package:hive_ce/hive.dart';
import 'package:my_discord/models/hive_user_model.dart';

extension HiveRegistrar on HiveInterface {
  void registerAdapters() {
    registerAdapter(HiveUserModelAdapter());
  }
}

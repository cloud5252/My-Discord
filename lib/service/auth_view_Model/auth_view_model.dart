import 'package:stacked/stacked.dart';

class AuthViewModel extends BaseViewModel {
  bool _isRegisterMode = false;
  bool get isRegisterMode => _isRegisterMode;

  void toggleMode() {
    _isRegisterMode = !_isRegisterMode;
    notifyListeners();
  }
}

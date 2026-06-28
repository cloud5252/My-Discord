import 'package:flutter/material.dart';
import 'package:my_discord/service/FB_Auth/Authentication.dart';
import 'package:my_discord/ui/views/log_in/widget/drop_down_overlay.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_discord/app/app.locator.dart';
import 'package:my_discord/app/app.router.dart';

class SignupViewmodel extends BaseViewModel implements Initialisable {
  final TextEditingController Emailcontroller = TextEditingController();
  final TextEditingController displaynamecontroller = TextEditingController();
  final TextEditingController usernamecontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final ScrollController dropdownScrollController = ScrollController();
  final ScrollController monthScrollController = ScrollController();
  final ScrollController dayScrollController = ScrollController();
  final ScrollController yearScrollController = ScrollController();
  final ScrollController signUpController = ScrollController();

  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _auth = locator<Authentication>();

  final LayerLink monthLink = LayerLink();
  final LayerLink dayLink = LayerLink();
  final LayerLink yearLink = LayerLink();

  final FocusNode emailFocus = FocusNode();
  final FocusNode displaynameFocus = FocusNode();
  final FocusNode usernameFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  bool _emailTouched = false;
  bool _usernameTouched = false;
  bool _passwordTouched = false;
  bool get showEmailError => _emailTouched && Emailcontroller.text.isEmpty;
  bool get showUsernameError =>
      _usernameTouched && usernamecontroller.text.isEmpty;
  bool get showPasswordError =>
      _passwordTouched && passwordcontroller.text.isEmpty;
  bool get isEmailFocused => emailFocus.hasFocus;
  bool get isDisplaynameFocused => displaynameFocus.hasFocus;
  bool get isUsernameFocused => usernameFocus.hasFocus;
  bool get isPasswordFocused => passwordFocus.hasFocus;

  @override
  void initialise() {
    emailFocus.addListener(notifyListeners);
    displaynameFocus.addListener(notifyListeners);
    usernameFocus.addListener(notifyListeners);
    passwordFocus.addListener(notifyListeners);
    Emailcontroller.addListener(_onEmailChanged);
    usernamecontroller.addListener(_onUsernameChanged);
    passwordcontroller.addListener(_onPasswordChanged);
  }

  void _onEmailChanged() {
    if (Emailcontroller.text.isNotEmpty) _emailTouched = true;
    notifyListeners();
  }

  void _onUsernameChanged() {
    if (usernamecontroller.text.isNotEmpty) _usernameTouched = true;
    notifyListeners();
  }

  void _onPasswordChanged() {
    if (passwordcontroller.text.isNotEmpty) _passwordTouched = true;
    notifyListeners();
  }

  @override
  void dispose() {
    Emailcontroller.dispose();
    displaynamecontroller.dispose();
    usernamecontroller.dispose();
    passwordcontroller.dispose();
    emailFocus.dispose();
    displaynameFocus.dispose();
    usernameFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
    dropdownScrollController.dispose();
    monthScrollController.dispose();
    dayScrollController.dispose();
    yearScrollController.dispose();
  }

  void _onItemSelected(String type, String item) {
    if (type == 'month') selectedMonth = item;
    if (type == 'day') selectedDay = item;
    if (type == 'year') selectedYear = item;

    _overlayEntry?.remove();
    _overlayEntry = null;
    _isMonthOpen = false;
    _isDayOpen = false;
    _isYearOpen = false;

    notifyListeners();
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _isMonthOpen = false;
    _isDayOpen = false;
    _isYearOpen = false;
  }

  bool _isEmailOptIn = false;
  bool get isEmailOptIn => _isEmailOptIn;

  void toggleEmailOptIn(bool value) {
    _isEmailOptIn = value;
    notifyListeners();
  }

  bool _isTermsAccepted = false;
  bool get isTermsAccepted => _isTermsAccepted;

  void toggleTermsAccepted(bool value) {
    _isTermsAccepted = value;
    notifyListeners();
  }

  Future<void> register() async {
    if (passwordcontroller.text.isEmpty) return;
    setBusy(true);
    try {
      await _auth.createdAccount(
        usernamecontroller.text,
        Emailcontroller.text,
        passwordcontroller.text,
        displaynamecontroller.text,
      );
      await Future.delayed(const Duration(milliseconds: 500));
      _navigationService.replaceWithHomeView();
    } catch (e) {
      await _dialogService.showDialog(
        title: 'Error',
        description: e.toString(),
      );
    } finally {
      setBusy(false);
    }
  }

  String? selectedMonth;
  String? selectedDay;
  String? selectedYear;

  bool _isMonthOpen = false;
  bool _isDayOpen = false;
  bool _isYearOpen = false;

  bool get isMonthOpen => _isMonthOpen;
  bool get isDayOpen => _isDayOpen;
  bool get isYearOpen => _isYearOpen;

  OverlayEntry? _overlayEntry;

  void toggleDropdown(
      String type, BuildContext context, LayerLink link, List<String> items) {
    if (_overlayEntry != null) {
      bool isSame = (_isMonthOpen && type == 'month') ||
          (_isDayOpen && type == 'day') ||
          (_isYearOpen && type == 'year');

      _closeDropdown();

      if (isSame) return;
    }

    _openDropdown(type, context, link, items);
  }

  void _openDropdown(
      String type, BuildContext context, LayerLink link, List<String> items) {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    _isMonthOpen = type == 'month';
    _isDayOpen = type == 'day';
    _isYearOpen = type == 'year';
    notifyListeners();

    final ScrollController controller = type == 'month'
        ? monthScrollController
        : type == 'day'
            ? dayScrollController
            : yearScrollController;

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: _closeDropdown,
              behavior: HitTestBehavior.opaque,
              child: const ColoredBox(color: Colors.transparent),
            ),
          ),
          DropdownOverlay(
            key: ValueKey(type),
            link: link,
            width: size.width,
            items: items,
            type: type,
            selectedMonth: selectedMonth,
            selectedDay: selectedDay,
            selectedYear: selectedYear,
            onSelect: _onItemSelected,
            scrollController: controller,
          ),
        ],
      ),
    );

    overlay.insert(_overlayEntry!);
  }

  final List<String> dayItems = List.generate(31, (i) => '${i + 1}');
  final List<String> yearItems =
      List.generate(2026 - 1990 + 1, (i) => '${2026 - i}');
  final List<String> monthItems = const [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
}

import 'package:flutter/material.dart';
import 'package:my_discord/ui/common/app_colors.dart';

class SignupTextfield extends StatelessWidget {
  final String hinttext;
  final String helpertext;
  final bool obsecurtext;
  final bool isFocused;
  final FocusNode focusNode;
  final TextEditingController controller;
  final bool showError;

  const SignupTextfield({
    required this.controller,
    required this.obsecurtext,
    required this.hinttext,
    required this.helpertext,
    required this.isFocused,
    required this.focusNode,
    this.showError = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TextFieldWithHover(
          focusNode: focusNode,
          controller: controller,
          obsecurtext: obsecurtext,
          hinttext: hinttext,
          showError: showError,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedSize(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              child: showError
                  ? const Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          Icon(Icons.error_sharp,
                              color: Color(0xFFf56f5b), size: 18),
                          SizedBox(width: 2),
                          Text(
                            'Required',
                            style: TextStyle(
                              color: Color(0xFFf56f5b),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              child: isFocused && helpertext.isNotEmpty
                  ? TweenAnimationBuilder<double>(
                      key: ValueKey(isFocused),
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 600),
                      builder: (context, value, child) => Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, (1 - value) * 10),
                          child: child,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          helpertext,
                          style: const TextStyle(
                            color: Color(0xFFB5BAC1),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ],
    );
  }
}

class _TextFieldWithHover extends StatefulWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final bool obsecurtext;
  final String hinttext;
  final bool showError;

  const _TextFieldWithHover({
    required this.focusNode,
    required this.controller,
    required this.obsecurtext,
    required this.hinttext,
    required this.showError,
  });

  @override
  State<_TextFieldWithHover> createState() => _TextFieldWithHoverState();
}

class _TextFieldWithHoverState extends State<_TextFieldWithHover> {
  bool _isHovered = false;

  Color get _borderColor {
    if (widget.showError) return const Color(0xFFf56f5b);
    if (_isHovered) return const Color(0xFF6d6f78);
    return greyColor;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: TextField(
        focusNode: widget.focusNode,
        onTapOutside: (event) {},
        cursorWidth: 1,
        cursorHeight: 20,
        cursorColor: whiteColor,
        style: const TextStyle(fontSize: 18, color: whiteColor),
        controller: widget.controller,
        obscureText: widget.obsecurtext,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          hoverColor: Colors.transparent,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: _borderColor),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color:
                  widget.showError ? const Color(0xFFf56f5b) : focusBordercolor,
              width: 1.80,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          fillColor: textfieldfilledColor,
          filled: true,
          hintText: widget.hinttext,
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
      ),
    );
  }
}

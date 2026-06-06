import 'package:flutter/material.dart';
import 'package:my_discord/ui/common/app_colors.dart';

class SiginButton extends StatelessWidget {
  final String text;
  final void Function()? ontap;
  final bool isBusy;
  const SiginButton({
    required this.ontap,
    required this.text,
    required this.isBusy,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: loginButtonColor,
        ),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 1),
        child: Center(
          child: isBusy
              ? const _ThreeDotsIndicator()
              : Text(
                  text,
                  style: const TextStyle(fontSize: 15),
                ),
        ),
      ),
    );
  }
}

class _ThreeDotsIndicator extends StatefulWidget {
  const _ThreeDotsIndicator();

  @override
  State<_ThreeDotsIndicator> createState() => _ThreeDotsIndicatorState();
}

class _ThreeDotsIndicatorState extends State<_ThreeDotsIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 18,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(3, (index) {
              final delay = index / 3;
              final value = (_controller.value - delay) % 1.0;
              final opacity = value < 0.5 ? value * 2 : (1.0 - value) * 2;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: Opacity(
                  opacity: opacity.clamp(0.2, 1.0),
                  child: const CircleAvatar(
                    radius: 3,
                    backgroundColor: Colors.white,
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}

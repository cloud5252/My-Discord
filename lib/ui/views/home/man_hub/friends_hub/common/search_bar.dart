import 'package:flutter/material.dart';
import 'package:my_discord/ui/views/home/man_hub/friends_hub/fraind_hub_view_model.dart';

class FriendsSearchBar extends StatelessWidget {
  final FraindHubViewModel viewModel;
  const FriendsSearchBar({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 36,
      child: TextField(
        style: const TextStyle(color: Colors.white, fontSize: 14),
        cursorColor: Colors.white,
        onChanged: viewModel.onSearchChanged,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hoverColor: Colors.transparent,
          filled: true,
          fillColor: Colors.transparent,
          hintText: 'Search',
          hintStyle: const TextStyle(color: Color(0xFFffffff), fontSize: 14),
          prefixIcon:
              const Icon(Icons.search, color: Color(0xFFffffff), size: 18),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Color(0xFF00A8FC), width: 0.3),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Color(0xFF00A8FC), width: 0.8),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(
              color: Color(0xFF00A8FC),
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:my_discord/ui/views/home/man_hub/friends_hub/fraind_hub_view_model.dart';

class FriendsSearchBar extends StatelessWidget {
  final FraindHubViewModel viewModel;
  const FriendsSearchBar({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        height: 36,
        decoration: BoxDecoration(
          color: const Color(0xFF202225),
          borderRadius: BorderRadius.circular(4),
        ),
        child: TextField(
          style: const TextStyle(color: Colors.white, fontSize: 14),
          cursorColor: Colors.white,
          onChanged: viewModel.onSearchChanged,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            hoverColor: Colors.transparent,
            fillColor: const Color(0xFF17171a),
            filled: true,
            hintText: 'Search',
            hintStyle: const TextStyle(color: Color(0xFF72767D), fontSize: 14),
            prefixIcon:
                const Icon(Icons.search, color: Color(0xFF72767D), size: 18),
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide:
                  const BorderSide(color: Color(0xFF3e4fed), width: 2.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}

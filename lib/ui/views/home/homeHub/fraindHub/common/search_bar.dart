import 'package:flutter/material.dart';
import 'package:my_discord/ui/views/home/homeHub/fraindHub/fraind_hub_view_model.dart';

class FriendsSearchBar extends StatelessWidget {
  final FraindHubViewModel viewModel;
  const FriendsSearchBar({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        height: 36,
        decoration: BoxDecoration(
          color: const Color(0xFF202225),
          borderRadius: BorderRadius.circular(4),
        ),
        child: TextField(
          style: const TextStyle(color: Colors.white, fontSize: 14),
          cursorColor: Colors.white,
          onChanged: viewModel.onSearchChanged,
          decoration: const InputDecoration(
            hintText: 'Search',
            hintStyle: TextStyle(color: Color(0xFF72767D), fontSize: 14),
            prefixIcon: Icon(Icons.search, color: Color(0xFF72767D), size: 18),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 8),
          ),
        ),
      ),
    );
  }
}

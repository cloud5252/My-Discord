import 'package:flutter/material.dart';
import 'package:my_discord/ui/views/home/home_viewmodel.dart';
import 'package:stacked/stacked.dart';
 
class ChatPopupMenu extends ViewModelWidget<HomeViewModel> {
  const ChatPopupMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return PopupMenuButton<String>(
      splashRadius: 20,
      position: PopupMenuPosition.under,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      icon: const Icon(Icons.more_vert, color: Colors.white),
      color: const Color(0xFF13181c),
      onSelected: viewModel.onMenuSelected,
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'Advertise',
          child: Text('Advertise', style: TextStyle(color: Colors.white)),
        ),
        const PopupMenuItem(
          value: 'new group',
          child: Text('New Group', style: TextStyle(color: Colors.white)),
        ),
        const PopupMenuItem(
          value: 'Business broadcasts',
          child: Text('Business broadcasts',
              style: TextStyle(color: Colors.white)),
        ),
        const PopupMenuItem(
          value: 'Communities',
          child: Text('Communities', style: TextStyle(color: Colors.white)),
        ),
        const PopupMenuItem(
          value: 'Label',
          child: Text('Label', style: TextStyle(color: Colors.white)),
        ),
        const PopupMenuItem(
          value: 'Linked devices',
          child: Text('Linked devices', style: TextStyle(color: Colors.white)),
        ),
        const PopupMenuItem(
          value: 'Starred',
          child: Text('Starred', style: TextStyle(color: Colors.white)),
        ),
        const PopupMenuItem(
          value: 'settings',
          child: Text('Settings', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}

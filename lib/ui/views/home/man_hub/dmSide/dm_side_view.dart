// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:my_discord/ui/views/home/man_hub/dmSide/dm_side_view_model.dart';
import 'package:my_discord/ui/views/home/man_hub/dmSide/widget/dm_side_fraind_widget.dart';
import 'package:my_discord/ui/common/hover_builder.dart';
import 'package:my_discord/ui/common/press_builder.dart';
import 'package:stacked/stacked.dart';

class DmSideView extends StackedView<DmSideViewModel> {
  const DmSideView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, DmSideViewModel viewModel, Widget? child) {
    return Stack(
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              color: const Color(0xFF121214),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
              ),
              border: Border(
                top: BorderSide(
                  color: Colors.grey.shade700,
                  width: 0.2,
                ),
                left: BorderSide(
                  color: Colors.grey.shade700,
                  width: 0.2,
                ),
              )),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 6),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 36,
                    width: double.infinity,
                    color: Colors.white.withOpacity(0.1),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Text(
                      'Find or start a conversation',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
              Container(
                height: 0.5,
                color: Colors.grey.shade700,
              ),
              const SizedBox(height: 6),
              _SidebarTab(
                icon: Icons.people,
                label: 'Friends',
                tab: SidebarTab.friends,
                viewModel: viewModel,
              ),
              _SidebarTab(
                icon: Icons.mark_email_unread_outlined,
                label: 'Message Requests',
                tab: SidebarTab.messageRequests,
                viewModel: viewModel,
              ),
              _SidebarTab(
                icon: Icons.monetization_on_outlined,
                label: 'Nitro',
                tab: SidebarTab.nitro,
                viewModel: viewModel,
              ),
              _SidebarTab(
                icon: Icons.storefront_outlined,
                label: 'Shop',
                tab: SidebarTab.shop,
                viewModel: viewModel,
                badge: 'NEW',
              ),
              _SidebarTab(
                icon: Icons.checklist_outlined,
                label: 'Quests',
                tab: SidebarTab.quests,
                viewModel: viewModel,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 8, 4),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Direct Messages',
                        style: TextStyle(
                          color: Color(0xFF80848E),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    Icon(Icons.add, color: Color(0xFF80848E), size: 18),
                  ],
                ),
              ),
              const Expanded(
                child: DmSideFraindWidget(),
              ),
            ],
          ),
        ),
        // Positioned(
        //   bottom: 5,
        //   right: 5,
        //   left: 5,
        //   child: _BottomUserBar(),
        // )
      ],
    );
  }

  @override
  DmSideViewModel viewModelBuilder(BuildContext context) => DmSideViewModel();
}

class _SidebarTab extends StatelessWidget {
  final IconData icon;
  final String label;
  final SidebarTab tab;
  final DmSideViewModel viewModel;
  final String? badge;

  const _SidebarTab({
    Key? key,
    required this.icon,
    required this.label,
    required this.tab,
    required this.viewModel,
    this.badge,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isActive = viewModel.activeTab == tab;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
      child: HoverBuilder(
        builder: (isHovered) => PressBuilder(
          onTap: () => viewModel.onTabTap(tab),
          builder: (isPressed) => Container(
            decoration: BoxDecoration(
              color: isPressed
                  ? const Color(0xFF363638)
                  : isActive
                      ? const Color(0xFF2c2c30)
                      : isHovered
                          ? const Color(0xFF1e1e1f)
                          : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                children: [
                  Icon(
                    icon,
                    size: 18,
                    color: const Color(0xFF96979e),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      label,
                      style: TextStyle(
                        color: isActive || isHovered || isPressed
                            ? Colors.white
                            : const Color(0xFF96979e),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  if (badge != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFF5865F2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        badge!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

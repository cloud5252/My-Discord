import 'package:flutter/material.dart';
import 'package:my_discord/ui/views/home/man_hub/dmSide/dm_side_view_model.dart';
import 'package:my_discord/ui/views/home/man_hub/dmSide/widget/dm_side_fraind_widget.dart';
import 'package:stacked/stacked.dart';

class DmSideView extends StackedView<DmSideViewModel> {
  const DmSideView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, DmSideViewModel viewModel, Widget? child) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xFF121214),
          borderRadius: BorderRadius.circular(4),
          border: Border(
              left: BorderSide(
            color: Colors.grey.shade700,
            width: 0.1,
          ))),
      child: Column(
        children: [
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade900),
                  color: const Color(0xFF1d1d1e),
                  borderRadius: BorderRadius.circular(10)),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                child: Center(
                  child: Text(
                    'Find or start a conversation',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Divider(
            thickness: 0.5,
            color: Colors.grey.shade700,
          ),
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
          const _BottomUserBar(),
        ],
      ),
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
    required this.icon,
    required this.label,
    required this.tab,
    required this.viewModel,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    final bool isActive = viewModel.activeTab == tab;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
      child: Material(
        color: isActive ? const Color(0xFF35373C) : Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        child: InkWell(
          onTap: () => viewModel.onTabTap(tab),
          borderRadius: BorderRadius.circular(4),
          hoverColor: const Color(0xFF2E3035), // ✅ Ab dikhega
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              children: [
                Icon(icon,
                    color: isActive ? Colors.white : const Color(0xFF80848E),
                    size: 18),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(label,
                      style: TextStyle(
                        color:
                            isActive ? Colors.white : const Color(0xFFDBDEE1),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      )),
                ),
                if (badge != null)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFF5865F2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(badge!,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w700)),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomUserBar extends StatelessWidget {
  const _BottomUserBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      color: const Color(0xFF232428),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Stack(
            children: [
              const CircleAvatar(
                radius: 16,
                backgroundColor: Color(0xFF5865F2),
                child: Icon(Icons.person, color: Colors.white, size: 16),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: const Color(0xFF747F8D),
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: const Color(0xFF232428), width: 2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Programer',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600)),
                Text('Invisible',
                    style: TextStyle(color: Color(0xFF80848E), fontSize: 11)),
              ],
            ),
          ),
          const Icon(Icons.mic_off_outlined,
              color: Color(0xFF80848E), size: 18),
          const SizedBox(width: 8),
          const Icon(Icons.headset_outlined,
              color: Color(0xFF80848E), size: 18),
          const SizedBox(width: 8),
          const Icon(Icons.settings_outlined,
              color: Color(0xFF80848E), size: 18),
        ],
      ),
    );
  }
}

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:my_discord/ui/common/hover_builder.dart';

class DropdownOverlay extends StatelessWidget {
  final LayerLink link;
  final double width;
  final List<String> items;
  final String type;
  final String? selectedMonth;
  final String? selectedDay;
  final String? selectedYear;
  final Function(String, String) onSelect;
  final ScrollController scrollController;

  const DropdownOverlay({
    super.key,
    required this.link,
    required this.width,
    required this.items,
    required this.type,
    required this.selectedMonth,
    required this.selectedDay,
    required this.selectedYear,
    required this.onSelect,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      width: width,
      child: CompositedTransformFollower(
        link: link,
        showWhenUnlinked: false,
        offset: const Offset(0, -255),
        child: RepaintBoundary(
          child: Material(
            color: Colors.transparent,
            child: Container(
              height: 250,
              decoration: BoxDecoration(
                color: const Color(0xFF3c3d45),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                border: Border.all(
                  color: const Color(0xFF3c3d45),
                  width: 1.5,
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(
                    scrollbars: false,
                  ),
                  child: RawScrollbar(
                    controller: scrollController,
                    thumbVisibility: true,
                    thickness: 8,
                    radius: const Radius.circular(4),
                    thumbColor: const Color(0xFF7d7e87),
                    child: ListView.builder(
                      controller: scrollController,
                      key: ValueKey(type),
                      padding: const EdgeInsets.only(right: 6),
                      itemCount: items.length,
                      itemExtent: 50,
                      cacheExtent: 500,
                      addAutomaticKeepAlives: false,
                      addRepaintBoundaries: false,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        final isSelected =
                            (type == 'month' && item == selectedMonth) ||
                                (type == 'day' && item == selectedDay) ||
                                (type == 'year' && item == selectedYear);
                        return HoverBuilder(
                          key: ValueKey(item),
                          builder: (isHovered) => GestureDetector(
                            onTap: () => onSelect(type, item),
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFF575969).withOpacity(0.3)
                                    : isHovered
                                        ? const Color(0xFF575969)
                                            .withOpacity(0.3)
                                        : Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      item,
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.white
                                            : const Color(0xFFB5BAC1),
                                        fontSize: 14,
                                        fontWeight: isSelected
                                            ? FontWeight.w600
                                            : FontWeight.normal,
                                      ),
                                    ),
                                    if (isSelected)
                                      const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

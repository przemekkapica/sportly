import 'package:flutter/material.dart';

class ScrollOrFitBottom extends StatelessWidget {
  const ScrollOrFitBottom({
    Key? key,
    required this.scrollableContent,
    required this.bottomContent,
    required this.controller,
  }) : super(key: key);

  final List<Widget> scrollableContent;
  final Widget bottomContent;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: CustomScrollView(
        controller: controller,
        physics: const RangeMaintainingScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(scrollableContent),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: bottomContent,
            ),
          ),
        ],
      ),
    );
  }
}

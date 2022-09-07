import 'package:flutter/material.dart';
import 'hidable_controller_ext.dart';

class Hidable extends StatefulWidget with PreferredSizeWidget {
  final Widget child;

  final List<ScrollController> controllers;

  final bool wOpacity;

  final Size preferredWidgetSize;

  const Hidable({
    Key? key,
    required this.child,
    required this.controllers,
    this.wOpacity = true,
    this.preferredWidgetSize = const Size.fromHeight(56),
  }) : super(key: key);

  @override
  State<Hidable> createState() => _HidableState();

  @override
  Size get preferredSize => preferredWidgetSize;
}

class _HidableState extends State<Hidable> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final hidable =
        widget.controllers.hidable(widget.preferredWidgetSize.height);

    return ValueListenableBuilder<bool>(
      valueListenable: hidable.stickinessNotifier,
      builder: (_, isStickinessEnabled, __) {
        if (isStickinessEnabled) return hidableCard(1.0, hidable);

        return ValueListenableBuilder<double>(
          valueListenable: hidable.sizeNotifier,
          builder: (_, height, __) => hidableCard(height, hidable),
        );
      },
    );
  }

  Widget hidableCard(double factor, hidable) {
    return Align(
      heightFactor: factor,
      alignment: const Alignment(0, -1),
      child: SizedBox(
        height: hidable.size,
        child: widget.wOpacity
            ? Opacity(opacity: factor, child: widget.child)
            : widget.child,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

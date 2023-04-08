import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_icons/flutter_svg_icons.dart';
import 'package:second_task_data_usage/assets/colors/project_colors.dart';
import 'package:second_task_data_usage/assets/icons/project_icons.dart';

class TelegramLikeSwipeAnimation extends StatefulWidget {
  final Widget child;
  final VoidCallback? onSwipe;
  final double threshold;
  final double startingDragExtent;
  final double maxDragExtent;
  final bool isCompleted;

  const TelegramLikeSwipeAnimation({
    required this.child,
    this.onSwipe,
    this.isCompleted = false,
    this.threshold = 64.0,
    this.startingDragExtent = 40.0,
    this.maxDragExtent = 100.0,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TelegramLikeSwipeAnimationState();
  }
}

class _TelegramLikeSwipeAnimationState extends State<TelegramLikeSwipeAnimation> with TickerProviderStateMixin {
  double _dragExtent = 0.0;
  late AnimationController _moveController;
  late Animation<Offset> _moveChildAnimation;

  late final Animation<Offset> _moveIconAnimation;

  @override
  void initState() {
    super.initState();
    _moveController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _moveChildAnimation =
        Tween<Offset>(begin: Offset.zero, end: const Offset(1.0, 0.0))
            .animate(_moveController);
    _moveIconAnimation =
        Tween<Offset>(begin: const Offset(-1, 0), end: const Offset(8, 0))
            .animate(_moveController);

    var controllerValue = 0.0;
    _moveController.animateTo(controllerValue);
  }

  @override
  void dispose() {
    _moveController.dispose();
    super.dispose();
  }

  void _handleDragMoving(DragUpdateDetails details) {
    double delta = details.primaryDelta ?? 0;
    var oldDragExtent = _dragExtent;
    _dragExtent += delta;

    if (oldDragExtent.sign != _dragExtent.sign) {
      _updateMoveAnimation();
    }

    setState(() {});
    var movePastThresholdPixels = widget.threshold;
    var newPos = _dragExtent / context.size!.width;

    if (_dragExtent > movePastThresholdPixels) {
      double tresholds = _dragExtent / movePastThresholdPixels;

      num reducedThreshold = math.pow(tresholds, 0.3);

      double adjustedPixelPos = movePastThresholdPixels * reducedThreshold;
      newPos = adjustedPixelPos / context.size!.width;
    }

    _moveController.value = newPos;
  }

  void _handleDragEnd(DragEndDetails details) {
    _moveController.animateTo(0.0, duration: const Duration(milliseconds: 200));
    if (_dragExtent >= widget.maxDragExtent && widget.onSwipe != null) {
      widget.onSwipe!();
    }
    setState(() {
      _dragExtent = 0.0;
    });
  }

  void _updateMoveAnimation() {
    double end = _dragExtent.sign;
    _moveChildAnimation =
        Tween<Offset>(begin: const Offset(0.0, 0.0), end: Offset(end, 0.0))
            .animate(_moveController);
  }

  double _getAnimationCompletness() {
    return 1 /
        (widget.maxDragExtent - widget.startingDragExtent) *
        (_dragExtent - widget.startingDragExtent);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        child: Row(
          children: [
            _dragExtent >= widget.startingDragExtent
                ? SlideTransition(
                    position: _moveIconAnimation,
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: const BoxDecoration(
                        color: ProjectColors.inputBackgroundColor,
                        shape: BoxShape.circle,
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: SvgIcon(
                              size: 18.r,
                              icon: SvgIconData(
                                widget.isCompleted
                                    ? ProjectIcons.iCross
                                    : ProjectIcons.iOk,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(3.0.r),
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                ProjectColors.textColorSecondarySubTitle,
                              ),
                              value: _getAnimationCompletness(),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
      SlideTransition(
        position: _moveChildAnimation,
        child: SizedBox(width: 330.w, child: widget.child),
      ),
    ];

    return GestureDetector(
      onHorizontalDragUpdate: _handleDragMoving,
      onHorizontalDragEnd: _handleDragEnd,
      behavior: HitTestBehavior.opaque,
      child: Stack(
        alignment: AlignmentDirectional.centerStart,
        children: children,
      ),
    );
  }
}

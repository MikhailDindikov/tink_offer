import 'dart:math';

import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart'
    as custSeg;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart' as svg;
import 'package:get/get.dart';
import 'package:tink_offer/tink_screens/tink_appbar.dart';
import 'package:tink_offer/tink_screens/tink_calculator/tink_calculator_credit_page.dart';
import 'package:tink_offer/tink_screens/tink_calculator/tink_calculator_deposit_page.dart';
import 'package:tink_offer/tink_screens/tink_main/tink_main_screen.dart';
import 'package:tink_offer/tink_screens/tink_profile/tink_profile_screen.dart';

class TinkCalculatorScreen extends StatefulWidget {
  final GlobalKey<InnerDrawerState> drawerKey;
  const TinkCalculatorScreen({required this.drawerKey, super.key});

  @override
  State<TinkCalculatorScreen> createState() => _TinkCalculatorScreenState();
}

class _TinkCalculatorScreenState extends State<TinkCalculatorScreen> {
  RxInt curSlide = 1.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(24, 24, 24, 1),
      appBar: TinkAppBar(widget.drawerKey),  body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Align(
            alignment: Alignment.center,
            child: Text(
              'Financial Calculators',
              style: TextStyle(
                fontFamily: 'Sarabun',
                fontSize: 32,
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(245, 247, 248, 1),
              ),
            ),
          ),
          const SizedBox(
            height: 27,
          ),
          CustomSlidingSegmentedControl(
            innerPadding: EdgeInsets.zero,
            padding: 20,
            height: 48,
            children: {
              1: Padding(
                padding:
                    EdgeInsets.only(left: 20, top: 8, right: 20, bottom: 10),
                child: Obx(
                  () => Text(
                    'Credit',
                    style: TextStyle(
                      fontFamily: 'Sarabun',
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: curSlide.value == 1
                          ? Color.fromRGBO(36, 36, 36, 1)
                          : Color.fromRGBO(142, 142, 147, 1),
                    ),
                  ),
                ),
              ),
              2: Padding(
                padding:
                    EdgeInsets.only(left: 20, top: 8, right: 20, bottom: 10),
                child: Obx(
                  () => Text(
                    'Deposit',
                    style: TextStyle(
                      fontFamily: 'Sarabun',
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: curSlide.value == 2
                          ? Color.fromRGBO(36, 36, 36, 1)
                          : Color.fromRGBO(142, 142, 147, 1),
                    ),
                  ),
                ),
              ),
            },
            decoration: BoxDecoration(
              color: Color.fromRGBO(142, 142, 147, 0.25),
              borderRadius: BorderRadius.circular(200),
            ),
            thumbDecoration: BoxDecoration(
              color: Color.fromRGBO(255, 219, 39, 1),
              borderRadius: BorderRadius.circular(200),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.3),
                  blurRadius: 4.0,
                  spreadRadius: 1.0,
                  offset: Offset(
                    0.0,
                    2.0,
                  ),
                ),
              ],
            ),
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInToLinear,
            onValueChanged: (value) {
              curSlide.value = value;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Obx(
                    () => IndexedStack(
                      index: (curSlide.value - 1).obs.value,
                      children: [
                        TinkCaculatorCreditPage(),
                        TinkCaculatorDepositPage(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomSlidingSegmentedControl<T> extends StatefulWidget {
  const CustomSlidingSegmentedControl({
    super.key,
    required this.children,
    required this.onValueChanged,
    this.isDisabled = false,
    this.initialValue,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.easeInOut,
    this.innerPadding = const EdgeInsets.all(2.0),
    this.padding = 12,
    this.fixedWidth,
    this.decoration = const BoxDecoration(color: CupertinoColors.systemGrey5),
    this.thumbDecoration = const BoxDecoration(color: Colors.white),
    this.isStretch = false,
    this.fromMax = false,
    this.isShowDivider = false,
    this.dividerSettings = const custSeg.DividerSettings(),
    this.clipBehavior = Clip.none,
    this.height = 40,
    this.controller,
    this.customSegmentSettings,
    this.onHoverSegment,
    this.onTapSegment,
  }) : assert(children.length != 0);

  /// Decoration main panel
  final BoxDecoration? decoration;

  /// Decoraton animation panel
  final BoxDecoration? thumbDecoration;

  // Segment items map
  final Map<T, Widget> children;

  /// On change current segment
  final ValueChanged<T> onValueChanged;

  final void Function(T value, bool isHover)? onHoverSegment;

  /// Speed animation panel
  final Duration duration;

  /// Curve for animated panel
  final Curve curve;

  final EdgeInsets innerPadding;

  /// Item padding
  final double padding;

  /// fixed width items
  final double? fixedWidth;

  final bool isShowDivider;

  final custSeg.DividerSettings dividerSettings;

  /// `true` if the switch control is disabled, default to `false`
  final bool isDisabled;

  /// Stretches CustomSlidingSegmentedControl to full width
  final bool isStretch;

  /// Initial segment
  final T? initialValue;

  /// Get the largest element, while the rest of the elements get its size
  final bool fromMax;

  /// for container
  final Clip clipBehavior;

  /// if the function returns `false`, there will be no transition to the segment
  ///
  /// in this function, you can add a check by clicking on a segment
  final bool Function(T? segment)? onTapSegment;

  /// height panel
  final double? height;

  final custSeg.CustomSegmentedController<T>? controller;

  final custSeg.CustomSegmentSettings? customSegmentSettings;

  @override
  _CustomSlidingSegmentedControlState<T> createState() =>
      _CustomSlidingSegmentedControlState();
}

class _CustomSlidingSegmentedControlState<T>
    extends State<CustomSlidingSegmentedControl<T>> {
  T? current;
  double? height;
  double offset = 0.0;
  Map<T?, double> sizes = {};
  bool hasTouch = false;
  double? maxSize;
  List<Cache<T>> cacheItems = [];

  @override
  void initState() {
    widget.controller?.addListener(_controllerTap);
    super.initState();
    initialize();
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_controllerTap);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant CustomSlidingSegmentedControl<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    final changeInitial = oldWidget.initialValue != widget.initialValue;

    final changeChildrenLength =
        oldWidget.children.length != widget.children.length;

    if (changeInitial || changeChildrenLength) {
      hasTouch = true;
      initialize(oldCurrent: current, isChangeInitial: changeInitial);
      for (final cache in cacheItems) {
        calculateSize(
          size: cache.size,
          item: cache.item,
          isCacheEnabled: false,
        );
      }
    }
  }

  void initialize({
    T? oldCurrent,
    bool isChangeInitial = false,
  }) {
    final List<T?> _list = widget.children.keys.toList();
    final _index = _list.indexOf(widget.initialValue);
    final _keys = _list.toList();

    if (!isChangeInitial && oldCurrent != null) {
      current = oldCurrent;
    } else {
      if (widget.initialValue != null) {
        current = _keys[_index];
      } else {
        current = _keys.first;
      }
    }
  }

  void calculateSize(
      {required Size size,
      required MapEntry<T?, Widget> item,
      required bool isCacheEnabled}) {
    height ??= size.height;
    final Map<T?, double> _temp = {};
    _temp.putIfAbsent(item.key, () => widget.fixedWidth ?? size.width);

    setState(() {
      if (isCacheEnabled) {
        cacheItems.add(Cache<T>(item: item, size: size));
      }
      sizes = {...sizes, ..._temp};
      if (widget.fromMax) {
        maxSize = sizes.values.toList().reduce(max);
      }
      final _offset = computeOffset<T>(
        current: current,
        items: widget.children.keys.toList(),
        sizes: sizes.values.toList(),
      );
      offset = _offset;
    });
  }

  void _controllerTap() {
    if (widget.controller!.value == null ||
        current == widget.controller!.value) {
      return;
    }

    final entry = widget.children.entries
        .where(
          (element) => element.key == widget.controller!.value,
        )
        .toList();
    if (entry.isEmpty) {
      return;
    }

    onTapItem(entry.first);
  }

  void onTapItem(MapEntry<T?, Widget> item) {
    // when the switch control is disabled
    // do nothing on tap item

    if (widget.onTapSegment?.call(item.key) == false) {
      return;
    }
    if (widget.isDisabled) {
      return;
    }
    if (!hasTouch) {
      setState(() => hasTouch = true);
    }
    setState(() => current = item.key);
    final List<T?> _keys = widget.children.keys.toList();
    final _offset = computeOffset<T>(
      current: current,
      items: _keys,
      sizes: sizes.values.toList(),
    );
    setState(() => offset = _offset);
    final _value = _keys[_keys.indexOf(current)]!;
    widget.onValueChanged(_value);
    widget.controller?.value = current;
  }

  Widget _segmentItem(MapEntry<T, Widget> item) {
    return InkWell(
      onHover: (isHover) => widget.onHoverSegment?.call(item.key, isHover),
      onTap: () => onTapItem(item),
      mouseCursor: widget.customSegmentSettings?.mouseCursor,
      hoverColor: widget.customSegmentSettings?.hoverColor,
      overlayColor: widget.customSegmentSettings?.overlayColor,
      radius: widget.customSegmentSettings?.radius,
      splashColor: Colors.transparent,
      splashFactory: widget.customSegmentSettings?.splashFactory,
      highlightColor: Colors.transparent,
      borderRadius: widget.customSegmentSettings?.borderRadius,
      child: Container(
        height: widget.height,
        width: maxSize ?? widget.fixedWidth,
        padding: EdgeInsets.symmetric(horizontal: widget.padding),
        child: Center(child: item.value),
      ),
    );
  }

  Widget _dividerItem(int index, MapEntry<T?, double> item) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final currentIndex = widget.children.keys.toList().indexOf(current!);

    int? prevIndex;
    if (currentIndex > 0) {
      prevIndex = isRtl ? currentIndex + 1 : currentIndex - 1;
    }

    final isHideDivider = (index == prevIndex ||
            index == currentIndex ||
            (isRtl && index == currentIndex + 1)) &&
        widget.dividerSettings.isHideAutomatically;
    final isVisible = isRtl
        ? item.key != widget.children.keys.first
        : item.key != widget.children.keys.last;

    return IgnorePointer(
      child: SizedBox(
        height: widget.height,
        width: item.value,
        child: Stack(
          children: [
            if (isVisible)
              Positioned(
                top: widget.dividerSettings.indent,
                bottom: widget.dividerSettings.endIndent,
                right: 0,
                child: Transform.translate(
                  offset: Offset(widget.dividerSettings.thickness / 2, 0),
                  child: AnimatedContainer(
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.zero,
                    curve: widget.dividerSettings.curve ?? widget.curve,
                    duration:
                        widget.dividerSettings.duration ?? widget.duration,
                    width: isHideDivider ? 0 : widget.dividerSettings.thickness,
                    decoration: widget.dividerSettings.decoration ??
                        BoxDecoration(
                          color: Theme.of(context).dividerColor,
                        ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget layout() {
    return Container(
      height: widget.height,
      clipBehavior: widget.clipBehavior,
      decoration: widget.decoration,
      padding: widget.innerPadding,
      child: Stack(
        children: [
          if (widget.isShowDivider && widget.children.length > 1)
            Row(
              children: sizes.entries
                  .toList()
                  .asMap()
                  .entries
                  .map((item) => _dividerItem(item.key, item.value))
                  .toList(),
            ),
          AnimationPanel<T>(
            hasTouch: hasTouch,
            offset: offset,
            height: height,
            width: sizes[current],
            duration: widget.duration,
            curve: widget.curve,
            decoration: widget.thumbDecoration,
          ),
          Row(
            children: [
              for (final item in widget.children.entries) ...[
                MeasureSize(
                  onChange: (value) {
                    calculateSize(
                      size: value,
                      item: item,
                      isCacheEnabled: true,
                    );
                  },
                  child: widget.isStretch
                      ? Expanded(child: _segmentItem(item))
                      : _segmentItem(item),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.isStretch)
              Expanded(
                child: layout(),
              )
            else
              layout(),
          ],
        );
      },
    );
  }
}

class AnimationPanel<T> extends StatelessWidget {
  const AnimationPanel({
    super.key,
    required this.offset,
    required this.width,
    required this.height,
    required this.hasTouch,
    required this.duration,
    required this.curve,
    this.decoration,
  });

  final double offset;
  final double? width;
  final double? height;
  final Duration duration;
  final Curve curve;
  final bool hasTouch;
  final BoxDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final _offset = isRtl ? offset * -1 : offset;

    return AnimatedContainer(
      transform: Matrix4.translationValues(_offset, 0, 0),
      duration: hasTouch == false ? Duration.zero : duration,
      curve: curve,
      width: width,
      decoration: decoration,
      height: height,
    );
  }
}

class MeasureSize extends StatefulWidget {
  final Widget child;
  final Function(Size size) onChange;

  const MeasureSize({
    Key? key,
    required this.onChange,
    required this.child,
  }) : super(key: key);

  @override
  _MeasureSizeState createState() => _MeasureSizeState();
}

class _MeasureSizeState extends State<MeasureSize> {
  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);
    return Container(
      key: widgetKey,
      child: widget.child,
    );
  }

  GlobalKey<State<StatefulWidget>> widgetKey = GlobalKey();
  Size? oldSize;

  void postFrameCallback(Duration d) {
    final context = widgetKey.currentContext;
    if (context == null) return;

    final Size? newSize = context.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    widget.onChange(newSize ?? Size.zero);
  }
}

double computeOffset<T>({
  required List<double> sizes,
  required List<T?> items,
  T? current,
}) {
  if (sizes.isNotEmpty && sizes.length == items.length) {
    return sizes
        .getRange(0, items.indexOf(current))
        .fold<double>(0, (previousValue, element) => previousValue + element);
  } else {
    return 0;
  }
}

class Cache<T> {
  final MapEntry<T?, Widget> item;
  final Size size;

  Cache({
    required this.item,
    required this.size,
  });

  @override
  bool operator ==(Object other) {
    if (other is Cache) {
      return identical(size, other.size) && identical(item, other.item);
    }
    return false;
  }

  @override
  int get hashCode => size.hashCode ^ item.hashCode;
}

// ignore_for_file: deprecated_member_use

import 'dart:math';

import 'package:flutter/cupertino.dart' as cup;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tink_offer/tink_navigators/tink_calculator_navigator.dart';
import 'package:tink_offer/tink_navigators/tink_calendar_navigator.dart';
import 'package:tink_offer/tink_navigators/tink_events_navigator.dart';
import 'package:tink_offer/tink_navigators/tink_payments_navigator.dart';
import 'package:tink_offer/tink_navigators/tink_premuim_navigator.dart';
import 'package:tink_offer/tink_navigators/tink_summary_navigator.dart';
import 'package:tink_offer/tink_screens/tink_drawer.dart';

class TinkMainScreen extends StatefulWidget {
  const TinkMainScreen({super.key});

  @override
  State<TinkMainScreen> createState() => _TinkMainScreenState();
}

class _TinkMainScreenState extends State<TinkMainScreen> {
  @override
  Widget build(BuildContext context) {
    final tinkController = CupertinoTabController();
    int tinkSelectedScreen = 0;
    final GlobalKey<InnerDrawerState> _innerDrawerKey =
        GlobalKey<InnerDrawerState>();

    return WillPopScope(
      onWillPop: () async => false,
      child: InnerDrawer(
        key: _innerDrawerKey,
        rightChild: SizedBox(width: 270, child: TinkDrawer()),
        leftChild: null,
        proportionalChildArea: true,
        swipe: false,
        scaffold: CupertinoTabScaffold(
          controller: tinkController,
          backgroundColor: const Color.fromRGBO(24, 24, 24, 1),
          tabBar: cup.CupertinoTabBar(
            height: 83,
            onTap: (index) {
              if (tinkSelectedScreen == index) {
                switch (index) {
                  case 0:
                    Get.offNamedUntil<void>(
                      '/payments',
                      (route) => true,
                      id: 0,
                    );
                    break;
                  case 1:
                    Get.offNamedUntil<void>(
                      '/events',
                      (route) => true,
                      id: 1,
                    );
                    break;
                  case 2:
                    Get.offNamedUntil<void>(
                      '/calendar',
                      (route) => true,
                      id: 2,
                    );
                    break;
                  case 3:
                    Get.offNamedUntil<void>(
                      '/summary',
                      (route) => true,
                      id: 3,
                    );
                    break;
                  case 4:
                    Get.offNamedUntil<void>(
                      '/calculator',
                      (route) => true,
                      id: 4,
                    );
                    break;
                  case 5:
                    Get.offNamedUntil<void>(
                      '/premium',
                      (route) => true,
                      id: 5,
                    );
                    break;
                }
              }

              tinkSelectedScreen = index;
            },
            backgroundColor: const Color.fromRGBO(12, 12, 12, 1),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                activeIcon: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: SvgPicture.asset(
                    'tassets/icons/payments.svg',
                    color: const Color.fromRGBO(255, 219, 39, 1),
                  ),
                ),
                icon: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: SvgPicture.asset(
                    'tassets/icons/payments.svg',
                    color: const Color.fromRGBO(111, 111, 116, 1),
                  ),
                ),
              ),
              BottomNavigationBarItem(
                activeIcon: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: SvgPicture.asset(
                    'tassets/icons/events.svg',
                    color: const Color.fromRGBO(255, 219, 39, 1),
                  ),
                ),
                icon: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: SvgPicture.asset(
                    'tassets/icons/events.svg',
                    color: const Color.fromRGBO(111, 111, 116, 1),
                  ),
                ),
              ),
              BottomNavigationBarItem(
                activeIcon: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: SvgPicture.asset(
                    'tassets/icons/calendar.svg',
                    color: const Color.fromRGBO(255, 219, 39, 1),
                  ),
                ),
                icon: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: SvgPicture.asset(
                    'tassets/icons/calendar.svg',
                    color: const Color.fromRGBO(111, 111, 116, 1),
                  ),
                ),
              ),
              BottomNavigationBarItem(
                activeIcon: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: SvgPicture.asset(
                    'tassets/icons/summary.svg',
                    color: const Color.fromRGBO(255, 219, 39, 1),
                  ),
                ),
                icon: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: SvgPicture.asset(
                    'tassets/icons/summary.svg',
                    color: const Color.fromRGBO(111, 111, 116, 1),
                  ),
                ),
              ),
              BottomNavigationBarItem(
                activeIcon: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: SvgPicture.asset(
                    'tassets/icons/calculator.svg',
                    color: const Color.fromRGBO(255, 219, 39, 1),
                  ),
                ),
                icon: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: SvgPicture.asset(
                    'tassets/icons/calculator.svg',
                    color: const Color.fromRGBO(111, 111, 116, 1),
                  ),
                ),
              ),
              BottomNavigationBarItem(
                activeIcon: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: SvgPicture.asset(
                    'tassets/icons/premium.svg',
                    color: const Color.fromRGBO(255, 219, 39, 1),
                  ),
                ),
                icon: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: SvgPicture.asset(
                    'tassets/icons/premium.svg',
                    color: const Color.fromRGBO(111, 111, 116, 1),
                  ),
                ),
              ),
            ],
          ),
          tabBuilder: (ctx, index) => Builder(
            builder: (ctx) {
              switch (index) {
                case 0:
                  return cup.CupertinoTabView(
                    builder: (context) => cup.CupertinoPageScaffold(
                      child: TinkPaymentsNavigator(
                        drawerKey: _innerDrawerKey,
                      ),
                    ),
                  );
                case 1:
                  return cup.CupertinoTabView(
                    builder: (context) => cup.CupertinoPageScaffold(
                      child: TinkEventsNavigator(
                        drawerKey: _innerDrawerKey,
                      ),
                    ),
                  );
                case 2:
                  return cup.CupertinoTabView(
                    builder: (context) => cup.CupertinoPageScaffold(
                      child: TinkCalendarNavigator(
                        drawerKey: _innerDrawerKey,
                      ),
                    ),
                  );
                case 3:
                  return cup.CupertinoTabView(
                    builder: (context) => cup.CupertinoPageScaffold(
                      child: TinkSummaryNavigator(
                        drawerKey: _innerDrawerKey,
                      ),
                    ),
                  );
                case 4:
                  return cup.CupertinoTabView(
                    builder: (context) => cup.CupertinoPageScaffold(
                      child: TinkCalculatorNavigator(
                        drawerKey: _innerDrawerKey,
                      ),
                    ),
                  );
                case 5:
                  return cup.CupertinoTabView(
                    builder: (context) => cup.CupertinoPageScaffold(
                      child: TinkPremiumNavigator(
                        drawerKey: _innerDrawerKey,
                      ),
                    ),
                  );
                default:
                  return cup.CupertinoTabView(
                    builder: (context) => cup.CupertinoPageScaffold(
                      child: Container(),
                    ),
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}

class CupertinoTabController extends ChangeNotifier {
  /// Creates a [CupertinoTabController] to control the tab index of [CupertinoTabScaffold]
  /// and [CupertinoTabBar].
  ///
  /// The [initialIndex] defaults to 0. The value must be greater than or equal
  /// to 0, and less than the total number of tabs.
  CupertinoTabController({int initialIndex = 0})
      : _index = initialIndex,
        assert(initialIndex >= 0);

  bool isDisposed = false;

  /// The index of the currently selected tab.
  ///
  /// Changing the value of [index] updates the actively displayed tab of the
  /// [CupertinoTabScaffold] controlled by this [CupertinoTabController], as well
  /// as the currently selected tab item of its [CupertinoTabScaffold.tabBar].
  ///
  /// The value must be greater than or equal to 0, and less than the total
  /// number of tabs.
  int get index => _index;
  int _index;
  set index(int value) {
    assert(value >= 0);
    if (_index == value) {
      return;
    }
    _index = value;
    notifyListeners();
  }

  @mustCallSuper
  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}

class CupertinoTabScaffold extends StatefulWidget {
  /// Creates a layout for applications with a tab bar at the bottom.
  CupertinoTabScaffold({
    super.key,
    required this.tabBar,
    required this.tabBuilder,
    this.controller,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = true,
    this.restorationId,
  }) : assert(
          controller == null || controller.index < tabBar.items.length,
          "The CupertinoTabController's current index ${controller.index} is "
          'out of bounds for the tab bar with ${tabBar.items.length} tabs',
        );

  /// The [tabBar] is a [CupertinoTabBar] drawn at the bottom of the screen
  /// that lets the user switch between different tabs in the main content area
  /// when present.
  ///
  /// The [CupertinoTabBar.currentIndex] is only used to initialize a
  /// [CupertinoTabController] when no [controller] is provided. Subsequently
  /// providing a different [CupertinoTabBar.currentIndex] does not affect the
  /// scaffold or the tab bar's active tab index. To programmatically change
  /// the active tab index, use a [CupertinoTabController].
  ///
  /// If [CupertinoTabBar.onTap] is provided, it will still be called.
  /// [CupertinoTabScaffold] automatically also listen to the
  /// [CupertinoTabBar]'s `onTap` to change the [controller]'s `index`
  /// and change the actively displayed tab in [CupertinoTabScaffold]'s own
  /// main content area.
  ///
  /// If translucent, the main content may slide behind it.
  /// Otherwise, the main content's bottom margin will be offset by its height.
  ///
  /// By default [tabBar] disables text scaling to match the native iOS behavior.
  /// To override this behavior, wrap each of the [tabBar]'s items inside a
  /// [MediaQuery] with the desired [TextScaler].
  final cup.CupertinoTabBar tabBar;

  /// Controls the currently selected tab index of the [tabBar], as well as the
  /// active tab index of the [tabBuilder]. Providing a different [controller]
  /// will also update the scaffold's current active index to the new controller's
  /// index value.
  ///
  /// Defaults to null.
  final CupertinoTabController? controller;

  /// An [IndexedWidgetBuilder] that's called when tabs become active.
  ///
  /// The widgets built by [IndexedWidgetBuilder] are typically a
  /// [CupertinoTabView] in order to achieve the parallel hierarchical
  /// information architecture seen on iOS apps with tab bars.
  ///
  /// When the tab becomes inactive, its content is cached in the widget tree
  /// [Offstage] and its animations disabled.
  ///
  /// Content can slide under the [tabBar] when they're translucent.
  /// In that case, the child's [BuildContext]'s [MediaQuery] will have a
  /// bottom padding indicating the area of obstructing overlap from the
  /// [tabBar].
  final IndexedWidgetBuilder tabBuilder;

  /// The color of the widget that underlies the entire scaffold.
  ///
  /// By default uses [CupertinoTheme]'s `scaffoldBackgroundColor` when null.
  final Color? backgroundColor;

  /// Whether the body should size itself to avoid the window's bottom inset.
  ///
  /// For example, if there is an onscreen keyboard displayed above the
  /// scaffold, the body can be resized to avoid overlapping the keyboard, which
  /// prevents widgets inside the body from being obscured by the keyboard.
  ///
  /// Defaults to true.
  final bool resizeToAvoidBottomInset;

  /// Restoration ID to save and restore the state of the [CupertinoTabScaffold].
  ///
  /// This property only has an effect when no [controller] has been provided:
  /// If it is non-null (and no [controller] has been provided), the scaffold
  /// will persist and restore the currently selected tab index. If a
  /// [controller] has been provided, it is the responsibility of the owner of
  /// that controller to persist and restore it, e.g. by using a
  /// [RestorableCupertinoTabController].
  ///
  /// The state of this widget is persisted in a [RestorationBucket] claimed
  /// from the surrounding [RestorationScope] using the provided restoration ID.
  ///
  /// See also:
  ///
  ///  * [RestorationManager], which explains how state restoration works in
  ///    Flutter.
  final String? restorationId;

  @override
  State<CupertinoTabScaffold> createState() => _CupertinoTabScaffoldState();
}

class _CupertinoTabScaffoldState extends State<CupertinoTabScaffold>
    with RestorationMixin {
  RestorableCupertinoTabController? _internalController;
  CupertinoTabController get _controller =>
      widget.controller ?? _internalController!.value;

  @override
  String? get restorationId => widget.restorationId;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    _restoreInternalController();
  }

  void _restoreInternalController() {
    if (_internalController != null) {
      registerForRestoration(_internalController!, 'controller');
      _internalController!.value.addListener(_onCurrentIndexChange);
    }
  }

  @override
  void initState() {
    super.initState();
    _updateTabController();
  }

  void _updateTabController([CupertinoTabController? oldWidgetController]) {
    if (widget.controller == null && _internalController == null) {
      // No widget-provided controller: create an internal controller.
      _internalController = RestorableCupertinoTabController(
          initialIndex: widget.tabBar.currentIndex);
      if (!restorePending) {
        _restoreInternalController(); // Also adds the listener to the controller.
      }
    }
    if (widget.controller != null && _internalController != null) {
      // Use the widget-provided controller.
      unregisterFromRestoration(_internalController!);
      _internalController!.dispose();
      _internalController = null;
    }
    if (oldWidgetController != widget.controller) {
      // The widget-provided controller has changed: move listeners.
      if (oldWidgetController?.isDisposed == false) {
        oldWidgetController!.removeListener(_onCurrentIndexChange);
      }
      widget.controller?.addListener(_onCurrentIndexChange);
    }
  }

  void _onCurrentIndexChange() {
    assert(
      _controller.index >= 0 && _controller.index < widget.tabBar.items.length,
      "The $runtimeType's current index ${_controller.index} is "
      'out of bounds for the tab bar with ${widget.tabBar.items.length} tabs',
    );

    // The value of `_controller.index` has already been updated at this point.
    // Calling `setState` to rebuild using `_controller.index`.
    setState(() {});
  }

  @override
  void didUpdateWidget(CupertinoTabScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _updateTabController(oldWidget.controller);
    } else if (_controller.index >= widget.tabBar.items.length) {
      // If a new [tabBar] with less than (_controller.index + 1) items is provided,
      // clamp the current index.
      _controller.index = widget.tabBar.items.length - 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData existingMediaQuery = MediaQuery.of(context);
    MediaQueryData newMediaQuery = MediaQuery.of(context);

    Widget content = _TabSwitchingView(
      currentTabIndex: _controller.index,
      tabCount: widget.tabBar.items.length,
      tabBuilder: widget.tabBuilder,
    );
    EdgeInsets contentPadding = EdgeInsets.zero;

    if (widget.resizeToAvoidBottomInset) {
      // Remove the view inset and add it back as a padding in the inner content.
      newMediaQuery = newMediaQuery.removeViewInsets(removeBottom: true);
      contentPadding =
          EdgeInsets.only(bottom: existingMediaQuery.viewInsets.bottom);
    }

    // Only pad the content with the height of the tab bar if the tab
    // isn't already entirely obstructed by a keyboard or other view insets.
    // Don't double pad.
    if (!widget.resizeToAvoidBottomInset ||
        widget.tabBar.preferredSize.height >
            existingMediaQuery.viewInsets.bottom) {
      // TODO(xster): Use real size after partial layout instead of preferred size.
      // https://github.com/flutter/flutter/issues/12912
      final double bottomPadding = widget.tabBar.preferredSize.height +
          existingMediaQuery.padding.bottom;

      // If tab bar opaque, directly stop the main content higher. If
      // translucent, let main content draw behind the tab bar but hint the
      // obstructed area.
      if (widget.tabBar.opaque(context)) {
        contentPadding = EdgeInsets.only(bottom: bottomPadding);
        newMediaQuery = newMediaQuery.removePadding(removeBottom: true);
      } else {
        newMediaQuery = newMediaQuery.copyWith(
          padding: newMediaQuery.padding.copyWith(
            bottom: bottomPadding,
          ),
        );
      }
    }

    content = MediaQuery(
      data: newMediaQuery,
      child: Padding(
        padding: contentPadding,
        child: content,
      ),
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: cup.CupertinoDynamicColor.maybeResolve(
                widget.backgroundColor, context) ??
            cup.CupertinoTheme.of(context).scaffoldBackgroundColor,
      ),
      child: Stack(
        children: <Widget>[
          // The main content being at the bottom is added to the stack first.
          content,
          MediaQuery.withNoTextScaling(
            child: Align(
              alignment: Alignment.bottomCenter,
              // Override the tab bar's currentIndex to the current tab and hook in
              // our own listener to update the [_controller.currentIndex] on top of a possibly user
              // provided callback.
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                child: widget.tabBar.copyWith(
                  currentIndex: _controller.index,
                  onTap: (int newIndex) {
                    _controller.index = newIndex;
                    // Chain the user's original callback.
                    widget.tabBar.onTap?.call(newIndex);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    if (widget.controller?.isDisposed == false) {
      _controller.removeListener(_onCurrentIndexChange);
    }
    _internalController?.dispose();
    super.dispose();
  }
}

class _TabSwitchingView extends StatefulWidget {
  const _TabSwitchingView({
    required this.currentTabIndex,
    required this.tabCount,
    required this.tabBuilder,
  }) : assert(tabCount > 0);

  final int currentTabIndex;
  final int tabCount;
  final IndexedWidgetBuilder tabBuilder;

  @override
  _TabSwitchingViewState createState() => _TabSwitchingViewState();
}

class _TabSwitchingViewState extends State<_TabSwitchingView> {
  final List<bool> shouldBuildTab = <bool>[];
  final List<FocusScopeNode> tabFocusNodes = <FocusScopeNode>[];

  // When focus nodes are no longer needed, we need to dispose of them, but we
  // can't be sure that nothing else is listening to them until this widget is
  // disposed of, so when they are no longer needed, we move them to this list,
  // and dispose of them when we dispose of this widget.
  final List<FocusScopeNode> discardedNodes = <FocusScopeNode>[];

  @override
  void initState() {
    super.initState();
    shouldBuildTab.addAll(List<bool>.filled(widget.tabCount, false));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _focusActiveTab();
  }

  @override
  void didUpdateWidget(_TabSwitchingView oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Only partially invalidate the tabs cache to avoid breaking the current
    // behavior. We assume that the only possible change is either:
    // - new tabs are appended to the tab list, or
    // - some trailing tabs are removed.
    // If the above assumption is not true, some tabs may lose their state.
    final int lengthDiff = widget.tabCount - shouldBuildTab.length;
    if (lengthDiff > 0) {
      shouldBuildTab.addAll(List<bool>.filled(lengthDiff, false));
    } else if (lengthDiff < 0) {
      shouldBuildTab.removeRange(widget.tabCount, shouldBuildTab.length);
    }
    _focusActiveTab();
  }

  // Will focus the active tab if the FocusScope above it has focus already. If
  // not, then it will just mark it as the preferred focus for that scope.
  void _focusActiveTab() {
    if (tabFocusNodes.length != widget.tabCount) {
      if (tabFocusNodes.length > widget.tabCount) {
        discardedNodes.addAll(tabFocusNodes.sublist(widget.tabCount));
        tabFocusNodes.removeRange(widget.tabCount, tabFocusNodes.length);
      } else {
        tabFocusNodes.addAll(
          List<FocusScopeNode>.generate(
            widget.tabCount - tabFocusNodes.length,
            (int index) => FocusScopeNode(
                debugLabel:
                    '$CupertinoTabScaffold Tab ${index + tabFocusNodes.length}'),
          ),
        );
      }
    }
    FocusScope.of(context).setFirstFocus(tabFocusNodes[widget.currentTabIndex]);
  }

  @override
  void dispose() {
    for (final FocusScopeNode focusScopeNode in tabFocusNodes) {
      focusScopeNode.dispose();
    }
    for (final FocusScopeNode focusScopeNode in discardedNodes) {
      focusScopeNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: List<Widget>.generate(widget.tabCount, (int index) {
        final bool active = index == widget.currentTabIndex;
        shouldBuildTab[index] = active || shouldBuildTab[index];

        return HeroMode(
          enabled: active,
          child: Offstage(
            offstage: !active,
            child: TickerMode(
              enabled: active,
              child: FocusScope(
                node: tabFocusNodes[index],
                child: Builder(builder: (BuildContext context) {
                  return shouldBuildTab[index]
                      ? widget.tabBuilder(context, index)
                      : const SizedBox.shrink();
                }),
              ),
            ),
          ),
        );
      }),
    );
  }
}

/// A [RestorableProperty] that knows how to store and restore a
/// [CupertinoTabController].
///
/// The [CupertinoTabController] is accessible via the [value] getter. During
/// state restoration, the property will restore [CupertinoTabController.index]
/// to the value it had when the restoration data it is getting restored from
/// was collected.
class RestorableCupertinoTabController
    extends RestorableChangeNotifier<CupertinoTabController> {
  /// Creates a [RestorableCupertinoTabController] to control the tab index of
  /// [CupertinoTabScaffold] and [CupertinoTabBar].
  ///
  /// The `initialIndex` defaults to zero. The value must be greater than or
  /// equal to zero, and less than the total number of tabs.
  RestorableCupertinoTabController({int initialIndex = 0})
      : assert(initialIndex >= 0),
        _initialIndex = initialIndex;

  final int _initialIndex;

  @override
  CupertinoTabController createDefaultValue() {
    return CupertinoTabController(initialIndex: _initialIndex);
  }

  @override
  CupertinoTabController fromPrimitives(Object? data) {
    assert(data != null);
    return CupertinoTabController(initialIndex: data! as int);
  }

  @override
  Object? toPrimitives() {
    return value.index;
  }
}

// InnerDrawer is based on Drawer.
// The source code of the Drawer has been re-adapted for Inner Drawer.

// more details:
// https://github.com/flutter/flutter/blob/master/packages/flutter/lib/src/material/drawer.dart

/// Signature for the callback that's called when a [InnerDrawer] is
/// opened or closed.
typedef InnerDrawerCallback = void Function(bool isOpened);

/// Signature for when a pointer that is in contact with the screen and moves to the right or left
/// values between 1 and 0
typedef InnerDragUpdateCallback = void Function(
    double value, InnerDrawerDirection? direction);

/// The possible position of a [InnerDrawer].
enum InnerDrawerDirection {
  start,
  end,
}

/// Animation type of a [InnerDrawer].
enum InnerDrawerAnimation {
  static,
  linear,
  quadratic,
}

//width before initState
const double _kWidth = 400;
const double _kMinFlingVelocity = 365.0;
const double _kEdgeDragWidth = 20.0;
const Duration _kBaseSettleDuration = Duration(milliseconds: 246);

class InnerDrawer extends StatefulWidget {
  const InnerDrawer(
      {GlobalKey? key,
      this.leftChild,
      this.rightChild,
      required this.scaffold,
      this.offset = const IDOffset.horizontal(0.4),
      this.scale = const IDOffset.horizontal(1),
      this.proportionalChildArea = true,
      this.borderRadius = 0,
      this.onTapClose = false,
      this.tapScaffoldEnabled = false,
      this.swipe = true,
      this.swipeChild = false,
      this.duration,
      this.velocity = 1,
      this.boxShadow,
      this.colorTransitionChild,
      this.colorTransitionScaffold,
      this.leftAnimationType = InnerDrawerAnimation.static,
      this.rightAnimationType = InnerDrawerAnimation.static,
      this.backgroundDecoration,
      this.innerDrawerCallback,
      this.onDragUpdate})
      : assert(leftChild != null || rightChild != null),
        super(key: key);

  /// Left child
  final Widget? leftChild;

  /// Right child
  final Widget? rightChild;

  /// A Scaffold is generally used but you are free to use other widgets
  final Widget scaffold;

  /// When the [InnerDrawer] is open, it's possible to set the offset of each of the four cardinal directions
  final IDOffset offset;

  /// When the [InnerDrawer] is open to the left or to the right
  /// values between 1 and 0. (default 1)
  final IDOffset scale;

  /// The proportionalChild Area = true dynamically sets the width based on the selected offset.
  /// On false it leaves the width at 100% of the screen
  final bool proportionalChildArea;

  /// edge radius when opening the scaffold - (defalut 0)
  final double borderRadius;

  /// Closes the open scaffold
  final bool tapScaffoldEnabled;

  /// Closes the open scaffold
  final bool onTapClose;

  /// activate or deactivate the swipe. NOTE: when deactivate, onTap Close is implicitly activated
  final bool swipe;

  /// activate or deactivate the swipeChild. NOTE: when deactivate, onTap Close is implicitly activated
  final bool swipeChild;

  /// duration animation controller
  final Duration? duration;

  /// possibility to set the opening and closing velocity
  final double velocity;

  /// BoxShadow of scaffold open
  final List<BoxShadow>? boxShadow;

  ///Color of gradient background
  final Color? colorTransitionChild;

  ///Color of gradient background
  final Color? colorTransitionScaffold;

  /// Static or Linear or Quadratic
  final InnerDrawerAnimation leftAnimationType;

  /// Static or Linear or Quadratic
  final InnerDrawerAnimation rightAnimationType;

  /// Color of the main background
  final Decoration? backgroundDecoration;

  /// Optional callback that is called when a [InnerDrawer] is open or closed.
  final InnerDrawerCallback? innerDrawerCallback;

  /// when a pointer that is in contact with the screen and moves to the right or left
  final InnerDragUpdateCallback? onDragUpdate;

  @override
  InnerDrawerState createState() => InnerDrawerState();
}

class InnerDrawerState extends State<InnerDrawer>
    with SingleTickerProviderStateMixin {
  ColorTween _colorTransitionChild =
      ColorTween(begin: Colors.transparent, end: Colors.black54);
  ColorTween _colorTransitionScaffold =
      ColorTween(begin: Colors.black54, end: Colors.transparent);

  double _initWidth = _kWidth;
  Orientation _orientation = Orientation.portrait;
  InnerDrawerDirection? _position;

  @override
  void initState() {
    _position = _leftChild != null
        ? InnerDrawerDirection.start
        : InnerDrawerDirection.end;

    _controller = AnimationController(
        value: 1,
        duration: widget.duration ?? _kBaseSettleDuration,
        vsync: this)
      ..addListener(_animationChanged)
      ..addStatusListener(_animationStatusChanged);
    super.initState();
  }

  @override
  void dispose() {
    _historyEntry?.remove();
    _controller.dispose();
    _focusScopeNode.dispose();
    super.dispose();
  }

  void _animationChanged() {
    setState(() {
      // The animation controller's state is our build state, and it changed already.
    });
    if (widget.colorTransitionChild != null)
      _colorTransitionChild = ColorTween(
          begin: widget.colorTransitionChild!.withOpacity(0.0),
          end: widget.colorTransitionChild);

    if (widget.colorTransitionScaffold != null)
      _colorTransitionScaffold = ColorTween(
          begin: widget.colorTransitionScaffold,
          end: widget.colorTransitionScaffold!.withOpacity(0.0));

    if (widget.onDragUpdate != null && _controller.value < 1) {
      widget.onDragUpdate!((1 - _controller.value), _position);
    }
  }

  LocalHistoryEntry? _historyEntry;
  final FocusScopeNode _focusScopeNode = FocusScopeNode();

  void _ensureHistoryEntry() {
    if (_historyEntry == null) {
      final ModalRoute<dynamic>? route = ModalRoute.of(context);
      if (route != null) {
        _historyEntry = LocalHistoryEntry(onRemove: _handleHistoryEntryRemoved);
        route.addLocalHistoryEntry(_historyEntry!);
        FocusScope.of(context).setFirstFocus(_focusScopeNode);
      }
    }
  }

  void _animationStatusChanged(AnimationStatus status) {
    final bool opened = _controller.value < 0.5 ? true : false;

    switch (status) {
      case AnimationStatus.reverse:
        break;
      case AnimationStatus.forward:
        break;
      case AnimationStatus.dismissed:
        if (_previouslyOpened != opened) {
          _previouslyOpened = opened;
          if (widget.innerDrawerCallback != null)
            widget.innerDrawerCallback!(opened);
        }
        _ensureHistoryEntry();
        break;
      case AnimationStatus.completed:
        if (_previouslyOpened != opened) {
          _previouslyOpened = opened;
          if (widget.innerDrawerCallback != null)
            widget.innerDrawerCallback!(opened);
        }
        _historyEntry?.remove();
        _historyEntry = null;
    }
  }

  void _handleHistoryEntryRemoved() {
    _historyEntry = null;
    close();
  }

  late AnimationController _controller;

  void _handleDragDown(DragDownDetails details) {
    _controller.stop();
    //_ensureHistoryEntry();
  }

  final GlobalKey _drawerKey = GlobalKey();

  double get _width {
    return _initWidth;
  }

  double get _velocity {
    return widget.velocity;
  }

  /// get width of screen after initState
  void _updateWidth() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox? box =
          _drawerKey.currentContext!.findRenderObject() as RenderBox?;
      //final RenderBox box = context.findRenderObject();
      if (box != null &&
          box.hasSize &&
          box.size.width > 300)
        setState(() {
          _initWidth = box.size.width;
        });
    });
  }

  bool _previouslyOpened = false;

  void _move(DragUpdateDetails details) {
    double delta = details.primaryDelta! / _width;

    if (delta > 0 && _controller.value == 1 && _leftChild != null)
      _position = InnerDrawerDirection.start;
    else if (delta < 0 && _controller.value == 1 && _rightChild != null)
      _position = InnerDrawerDirection.end;

    double offset = _position == InnerDrawerDirection.start
        ? widget.offset.left
        : widget.offset.right;

    double ee = 1;
    if (offset <= 0.2)
      ee = 1.7;
    else if (offset <= 0.4)
      ee = 1.2;
    else if (offset <= 0.6) ee = 1.05;

    offset = 1 -
        (pow(offset / ee, 1 / 2)
            as double); //(num.parse(pow(offset/2,1/3).toStringAsFixed(1)));

    switch (_position) {
      case InnerDrawerDirection.end:
        break;
      case InnerDrawerDirection.start:
        delta = -delta;
        break;
      default:
    }
    switch (Directionality.of(context)) {
      case TextDirection.rtl:
        _controller.value -= delta + (delta * offset);
        break;
      case TextDirection.ltr:
        _controller.value += delta + (delta * offset);
        break;
    }

    final bool opened = _controller.value < 0.5 ? true : false;
    if (opened != _previouslyOpened && widget.innerDrawerCallback != null)
      widget.innerDrawerCallback!(opened);
    _previouslyOpened = opened;
  }

  void _settle(DragEndDetails details) {
    if (_controller.isDismissed) return;
    if (details.velocity.pixelsPerSecond.dx.abs() >= _kMinFlingVelocity) {
      double visualVelocity =
          (details.velocity.pixelsPerSecond.dx + _velocity) / _width;

      switch (_position) {
        case InnerDrawerDirection.end:
          break;
        case InnerDrawerDirection.start:
          visualVelocity = -visualVelocity;
          break;

        default:
      }
      switch (Directionality.of(context)) {
        case TextDirection.rtl:
          _controller.fling(velocity: -visualVelocity);
          break;
        case TextDirection.ltr:
          _controller.fling(velocity: visualVelocity);
          break;
        default:
      }
    } else if (_controller.value < 0.5) {
      open();
    } else {
      close();
    }
  }

  void open({InnerDrawerDirection? direction}) {
    if (direction != null) _position = direction;
    _controller.fling(velocity: -_velocity);
  }

  void close({InnerDrawerDirection? direction}) {
    if (direction != null) _position = direction;
    _controller.fling(velocity: _velocity);
  }

  /// Open or Close InnerDrawer
  void toggle({InnerDrawerDirection? direction}) {
    if (_previouslyOpened)
      close(direction: direction);
    else
      open(direction: direction);
  }

  final GlobalKey _gestureDetectorKey = GlobalKey();

  /// Outer Alignment
  AlignmentDirectional? get _drawerOuterAlignment {
    switch (_position) {
      case InnerDrawerDirection.start:
        return AlignmentDirectional.centerEnd;
      case InnerDrawerDirection.end:
        return AlignmentDirectional.centerStart;
      default:
        return null;
    }
  }

  /// Inner Alignment
  AlignmentDirectional? get _drawerInnerAlignment {
    switch (_position) {
      case InnerDrawerDirection.start:
        return AlignmentDirectional.centerStart;
      case InnerDrawerDirection.end:
        return AlignmentDirectional.centerEnd;
      default:
        return null;
    }
  }

  /// returns the left or right animation type based on InnerDrawerDirection
  InnerDrawerAnimation get _animationType {
    return _position == InnerDrawerDirection.start
        ? widget.leftAnimationType
        : widget.rightAnimationType;
  }

  /// returns the left or right scale based on InnerDrawerDirection
  double get _scaleFactor {
    return _position == InnerDrawerDirection.start
        ? widget.scale.left
        : widget.scale.right;
  }

  /// returns the left or right offset based on InnerDrawerDirection
  double get _offset {
    return _position == InnerDrawerDirection.start
        ? widget.offset.left
        : widget.offset.right;
  }

  /// return width with specific offset
  double get _widthWithOffset {
    return (_width / 2) - (_width / 2) * _offset;
    //NEW
    //return _width  - _width * _offset;
  }

  /// return swipe
  bool get _swipe {
    //NEW
    //if( _offset == 0 ) return false;
    return widget.swipe;
  }

  /// return swipeChild
  bool get _swipeChild {
    //NEW
    //if( _offset == 0 ) return false;
    return widget.swipeChild;
  }

  /// Scaffold
  Widget _scaffold() {
    assert(widget.borderRadius >= 0);

    final Widget? invC = _invisibleCover();

    final widgets = [widget.scaffold];
    if (invC != null) {
      widgets.add(invC);
    }

    final Widget scaffoldChild = Stack(
      children: widgets.toList(),
    );

    Widget container = Container(
        key: _drawerKey,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
                widget.borderRadius * (1 - _controller.value)),
            boxShadow: widget.boxShadow ??
                [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 5,
                  )
                ]),
        child: widget.borderRadius != 0
            ? ClipRRect(
                borderRadius: BorderRadius.circular(
                    (1 - _controller.value) * widget.borderRadius),
                child: scaffoldChild)
            : scaffoldChild);

    if (_scaleFactor < 1)
      container = Transform.scale(
        alignment: _drawerInnerAlignment,
        scale: ((1 - _scaleFactor) * _controller.value) + _scaleFactor,
        child: container,
      );

    // Vertical translate
    if ((widget.offset.top > 0 || widget.offset.bottom > 0)) {
      final double translateY = MediaQuery.of(context).size.height *
          (widget.offset.top > 0 ? -widget.offset.top : widget.offset.bottom);
      container = Transform.translate(
        offset: Offset(0, translateY * (1 - _controller.value)),
        child: container,
      );
    }

    return container;
  }

  ///Disable the scaffolding tap when the drawer is open
  Widget? _invisibleCover() {
    final Container container = Container(
      color: _colorTransitionScaffold.evaluate(_controller),
    );
    if (_controller.value != 1.0 && !widget.tapScaffoldEnabled)
      return BlockSemantics(
        child: GestureDetector(
          // On Android, the back button is used to dismiss a modal.
          excludeFromSemantics: defaultTargetPlatform == TargetPlatform.android,
          onTap: widget.onTapClose || !_swipe ? close : null,
          child: Semantics(
            label: MaterialLocalizations.of(context).modalBarrierDismissLabel,
            child: container,
          ),
        ),
      );
    return null;
  }

  Widget? get _leftChild {
    return widget.leftChild;
  }

  Widget? get _rightChild {
    return widget.rightChild;
  }

  /// return widget with specific animation
  Widget _animatedChild() {
    Widget? child =
        _position == InnerDrawerDirection.start ? _leftChild : _rightChild;
    if (_swipeChild) {
      child = GestureDetector(
        onHorizontalDragUpdate: _move,
        onHorizontalDragEnd: _settle,
        child: child,
      );
    }
    final Widget container = Container(
      width: widget.proportionalChildArea ? _width - _widthWithOffset : _width,
      height: MediaQuery.of(context).size.height,
      child: child,
    );

    switch (_animationType) {
      case InnerDrawerAnimation.linear:
        return Align(
          alignment: _drawerOuterAlignment!,
          widthFactor: 1 - (_controller.value),
          child: container,
        );
      case InnerDrawerAnimation.quadratic:
        return Align(
          alignment: _drawerOuterAlignment!,
          widthFactor: 1 - (_controller.value / 2),
          child: container,
        );
      default:
        return container;
    }
  }

  /// Trigger Area
  Widget? _trigger(AlignmentDirectional alignment, Widget? child) {
    final bool drawerIsStart = _position == InnerDrawerDirection.start;
    final EdgeInsets padding = MediaQuery.of(context).padding;
    double dragAreaWidth = drawerIsStart ? padding.left : padding.right;

    if (Directionality.of(context) == TextDirection.rtl)
      dragAreaWidth = drawerIsStart ? padding.right : padding.left;
    dragAreaWidth = max(dragAreaWidth, _kEdgeDragWidth);

    if (_controller.status == AnimationStatus.completed &&
        _swipe &&
        child != null)
      return Align(
        alignment: alignment,
        child: Container(color: Colors.transparent, width: dragAreaWidth),
      );
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    //assert(debugCheckHasMaterialLocalizations(context));

    /// initialize the correct width
    if (_initWidth == 400 ||
        MediaQuery.of(context).orientation != _orientation) {
      _updateWidth();
      _orientation = MediaQuery.of(context).orientation;
    }

    /// wFactor depends of offset and is used by the second Align that contains the Scaffold
    final double offset = 0.5 - _offset * 0.5;
    //NEW
    //final double offset = 1 - _offset * 1;
    final double wFactor = (_controller.value * (1 - offset)) + offset;

    return Container(
      decoration: widget.backgroundDecoration ??
          BoxDecoration(
            color: Theme.of(context).backgroundColor,
          ),
      child: Stack(
        alignment: _drawerInnerAlignment!,
        children: <Widget>[
          FocusScope(node: _focusScopeNode, child: _animatedChild()),
          GestureDetector(
            key: _gestureDetectorKey,
            onTap: () {},
            onHorizontalDragDown: _swipe ? _handleDragDown : null,
            onHorizontalDragUpdate: _swipe ? _move : null,
            onHorizontalDragEnd: _swipe ? _settle : null,
            excludeFromSemantics: true,
            child: RepaintBoundary(
              child: Stack(
                children: <Widget>[
                  ///Gradient
                  Container(
                    width: _controller.value == 0 ||
                            _animationType == InnerDrawerAnimation.linear
                        ? 0
                        : null,
                    color: _colorTransitionChild.evaluate(_controller),
                  ),
                  Align(
                    alignment: _drawerOuterAlignment!,
                    child: Align(
                        alignment: _drawerInnerAlignment!,
                        widthFactor: wFactor,
                        child: RepaintBoundary(child: _scaffold())),
                  ),

                  ///Trigger
                ].toList() as List<Widget>,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

///An immutable set of offset in each of the four cardinal directions.
class IDOffset {
  const IDOffset.horizontal(
    double horizontal,
  )   : left = horizontal,
        top = 0.0,
        right = horizontal,
        bottom = 0.0;

  const IDOffset.only({
    this.left = 0.0,
    this.top = 0.0,
    this.right = 0.0,
    this.bottom = 0.0,
  })  : assert(top >= 0.0 &&
            top <= 1.0 &&
            left >= 0.0 &&
            left <= 1.0 &&
            right >= 0.0 &&
            right <= 1.0 &&
            bottom >= 0.0 &&
            bottom <= 1.0),
        assert(top >= 0.0 && bottom == 0.0 || top == 0.0 && bottom >= 0.0);

  /// The offset from the left.
  final double left;

  /// The offset from the top.
  final double top;

  /// The offset from the right.
  final double right;

  /// The offset from the bottom.
  final double bottom;
}

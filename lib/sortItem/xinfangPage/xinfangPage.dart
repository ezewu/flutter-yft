import 'package:flutter/material.dart';
import 'dart:ui' as ui show ImageFilter;
import 'dart:async';

import '../../template/search.dart';
import './query_data.dart';

class XinfangPage extends StatelessWidget {
  DropdownHeader buildDropdownHeader({DropdownMenuHeadTapCallback onTap}) {
    return DropdownHeader(
      height: 45.0,
      onTap: onTap,
      titles: [quyu[1], jiage[2], zx[1], label[0]],
    );
  }

  Widget buildCheckItem(BuildContext context, dynamic data, bool selected) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Text(
            defaultGetItemLabel(data),
            style: selected
                ? TextStyle(
                    fontSize: 14.0,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w400)
                : TextStyle(fontSize: 14.0),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: selected
                  ? Icon(
                      Icons.check,
                      color: Theme.of(context).primaryColor,
                    )
                  : null,
            ),
          )
        ],
      ),
    );
  }

  final double kDropdownMenuItemHeight = 45.0;

  DropdownMenu buildDropdownMenu() {
    return DropdownMenu(maxMenuHeight: kDropdownMenuItemHeight * 4, menus: [
      DropdownMenuBuilder(builder: (BuildContext context) {
        return DropdownListMenu(
          selectedIndex: 1,
          data: quyu,
          itemBuilder: buildCheckItem,
        );
      }),
      DropdownMenuBuilder(builder: (BuildContext context) {
        return DropdownListMenu(
          selectedIndex: 1,
          data: jiage,
          itemBuilder: buildCheckItem,
        );
      }),
      DropdownMenuBuilder(builder: (BuildContext context) {
        return DropdownListMenu(
          selectedIndex: 1,
          data: zx,
          itemBuilder: buildCheckItem,
        );
      }),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('新房'),
        elevation: 0.0,
      ),
      body: DefaultDropdownMenuController(
        onSelected: ({int menuIndex, int index, int subIndex, dynamic data}) {
          print('object $menuIndex  $index  $subIndex  $data');
        },
        child: Column(
          children: <Widget>[
            Opacity(
              opacity:1.0,
              child: search(),
            ),
            Opacity(
              opacity: 1.0,
              child: buildDropdownHeader(),
            ),
            Expanded(
              child: Stack(
                children: <Widget>[
                  // ListView(
                  //   children: <Widget>[
                  //     Text("datadatadatadatadatad"),
                  //     Text("datadatadatadatadata"),
                  //     Text("datadatadatadatadata"),
                  //     Text("datadatadatadatadata"),
                  //     Text("datadatadatadatadata"),
                  //     Text("datadatadatadatadata"),
                  //     Text("datadatadatadatadata"),
                  //   ],
                  // ),
                  buildDropdownMenu(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

/*
**********************************************
**********************************************
******************  调用 **********************
**********************************************
**********************************************
*/

class DefaultDropdownMenuController extends StatefulWidget {
  final Widget child;
  final DropdownMenuOnSelected onSelected;

  DefaultDropdownMenuController({
    Key key,
    @required this.child,
    this.onSelected,
  }) : super(key: key);

  // 总的触发器？
  static DropdownMenuController of(BuildContext context) {
    final _DropdownMenuControllerScope scope =
        context.inheritFromWidgetOfExactType(_DropdownMenuControllerScope);
    return scope?.controller;
  }

  @override
  _DefaultDropdownMenuControllerState createState() =>
      _DefaultDropdownMenuControllerState();
}

class _DefaultDropdownMenuControllerState
    extends State<DefaultDropdownMenuController> {
  // 总的触发器？
  DropdownMenuController _controller;

  @override
  void initState() {
    super.initState();
    // 总的触发器？
    _controller = new DropdownMenuController();
    _controller.addListener(_onController);
  }

  void _onController() {
    switch (_controller.event) {
      case DropdownEvent.SELECT:
        {
          if (widget.onSelected == null) return;
          widget.onSelected(
            data: _controller.data,
            menuIndex: _controller.menuIndex,
            index: _controller.index,
            subIndex: _controller.subIndex,
          );
        }
        break;
      case DropdownEvent.ACTIVE:
        break;
      case DropdownEvent.HIDE:
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.removeListener(_onController);
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _DropdownMenuControllerScope(
      controller: _controller,
      enabled: TickerMode.of(context),
      child: widget.child,
    );
  }
}

class _DropdownMenuControllerScope extends InheritedWidget {
  final DropdownMenuController controller;
  final bool enabled;

  const _DropdownMenuControllerScope(
      {Key key, this.controller, this.enabled, Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(_DropdownMenuControllerScope old) {
    return enabled != old.enabled || controller != old.controller;
  }
}

/*
**********************************************
**********************************************
******************  公用 **********************
**********************************************
**********************************************
*/
// 返回的数据类型
typedef void DropdownMenuOnSelected(
    {int menuIndex, int index, int subIndex, dynamic data});

// 头部的回调函数
typedef void DropdownMenuHeadTapCallback(int index);

enum DropdownEvent {
  // 菜单隐藏
  HIDE,
  // 菜单激活
  ACTIVE,
  // 菜单选中
  SELECT
}

// 总的触发器？
class DropdownMenuController extends ChangeNotifier {
  DropdownEvent event;
  int menuIndex;
  dynamic data;
  int index;
  int subIndex;
  // 菜单隐藏
  void hide() {
    event = DropdownEvent.HIDE;
    notifyListeners();
  }

// 菜单激活
  void show(int index) {
    event = DropdownEvent.ACTIVE;
    menuIndex = index;
    notifyListeners();
  }

  // 菜单选中
  void select(dynamic data, {int index, int subIndex}) {
    event = DropdownEvent.SELECT;
    this.data = data;
    this.index = index;
    this.subIndex = subIndex;
    notifyListeners();
  }
}

/*
**********************************************
**********************************************
******************  父类 **********************
**********************************************
**********************************************
*/
abstract class DropdownWidget extends StatefulWidget {
  final DropdownMenuController controller;
  DropdownWidget({Key key, this.controller}) : super(key: key);

  @override
  DropdownState<DropdownWidget> createState();
}

abstract class DropdownState<T extends DropdownWidget> extends State<T> {
  DropdownMenuController controller;

  void _onController() {
    onEvent(controller.event);
  }

  void onEvent(DropdownEvent event);

  @override
  void dispose() {
    super.dispose();
    if (controller != null) {
      controller.removeListener(_onController);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (controller == null) {
      if (widget.controller == null) {
        controller = DefaultDropdownMenuController.of(context);
      } else {
        controller = widget.controller;
      }
      if (controller != null) {
        controller.addListener(_onController);
      }
    }
  }

  @override
  void didUpdateWidget(T oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != null) {
      if (controller != null) {
        controller.removeListener(_onController);
      }
      controller = widget.controller;
      controller.addListener(_onController);
    }
  }
}

/*
**********************************************
**********************************************
******************  头部 **********************
**********************************************
**********************************************
*/

// 待研究
typedef String GetItemLabel(dynamic data);
// 待研究
String defaultGetItemLabel(dynamic data) {
  if (data is String) return data;
  return data["name"];
}

class DropdownHeader extends DropdownWidget {
  // 展示的数组
  final List<dynamic> titles;

  // 头部的回调
  final DropdownMenuHeadTapCallback onTap;
  // 头部的高
  final double height;
// 待研究
  final GetItemLabel getItemLabel;

  DropdownHeader(
      {Key key,
      @required this.titles,
      DropdownMenuController controller,
      this.onTap,
      double height,
      GetItemLabel getItemLabel})
      : getItemLabel = getItemLabel ?? defaultGetItemLabel,
        height = height ?? 46.0,
        assert(titles != null && titles.length > 0),
        super(key: key, controller: controller);

  DropdownState<DropdownWidget> createState() => _DropdownHeaderState();
}

class _DropdownHeaderState extends DropdownState<DropdownHeader> {
  int _activeIndex;
  List<dynamic> _titles;

  @override
  void initState() {
    super.initState();
    _titles = widget.titles;
  }

  Widget buildItem(
      BuildContext context, dynamic item, bool selected, int index) {
    final Color primaryColor = Theme.of(context).primaryColor;
    final Color unselectdColor = Theme.of(context).unselectedWidgetColor;
    final GetItemLabel getItemLabel = widget.getItemLabel;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: index == 0
                ? null
                : Border(
                    left: Divider.createBorderSide(context),
                  ),
          ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  getItemLabel(item),
                  style: TextStyle(
                    color: selected ? primaryColor : unselectdColor,
                  ),
                ),
                Icon(
                  selected ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: selected ? primaryColor : unselectdColor,
                )
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        if (widget.onTap != null) {
          return widget.onTap(index);
        }
        if (controller != null) {
          if (_activeIndex == index) {
            controller.hide();
            setState(() {
              _activeIndex = null;
            });
          } else {
            controller.show(index);
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [];
    final int activeIndex = _activeIndex;
    final List<dynamic> titles = _titles;
    final double height = widget.height;

    for (int i = 0; i < titles.length; i++) {
      list.add(buildItem(context, titles[i], i == activeIndex, i));
    }

    list = list.map((Widget widget) => Expanded(child: widget)).toList();

    final Decoration decoration = BoxDecoration(
      border: Border(
        bottom: Divider.createBorderSide(context),
      ),
    );

    return DecoratedBox(
      decoration: decoration,
      child: SizedBox(
        child: Row(
          children: list,
        ),
        height: height,
      ),
    );
  }

  @override
  void onEvent(DropdownEvent event) {
    switch (event) {
      case DropdownEvent.SELECT:
        {
          if (_activeIndex == null) return;

          setState(() {
            _activeIndex = null;
            String label = widget.getItemLabel(controller.data);
            _titles[controller.menuIndex] = label;
          });
        }
        break;
      case DropdownEvent.HIDE:
        {
          if (_activeIndex == null) return;
          setState(() {
            _activeIndex = null;
          });
        }
        break;
      case DropdownEvent.ACTIVE:
        {
          if (_activeIndex == controller.menuIndex) return;
          setState(() {
            _activeIndex = controller.menuIndex;
          });
        }
        break;
    }
  }
}

/*
**********************************************
**********************************************
******************  条件 **********************
**********************************************
**********************************************
*/

enum DropdownMenuShowHideSwitchStyle {
  directHideAnimationShow,
  directHideDirectShow,
  animationHideAnimationShow,
  animationShowUntilAnimationHideComplete,
}

class DropdownMenu extends DropdownWidget {
  final List<DropdownMenuBuilder> menus;
  final Duration hideDuration;
  final Duration showDuration;
  final Curve showCurve;
  final Curve hideCurve;
  final double blur;
  final VoidCallback onHide;
  final DropdownMenuShowHideSwitchStyle switchStyle;
  final double maxMenuHeight;

  DropdownMenu(
      {Key key,
      @required this.menus,
      DropdownMenuController controller,
      Duration hideDuration,
      Duration showDuration,
      this.onHide,
      this.blur,
      this.maxMenuHeight,
      Curve hideCurve,
      this.switchStyle: DropdownMenuShowHideSwitchStyle
          .animationShowUntilAnimationHideComplete,
      Curve showCurve})
      : hideDuration = hideDuration ?? Duration(milliseconds: 150),
        showDuration = showDuration ?? Duration(milliseconds: 300),
        showCurve = showCurve ?? Curves.fastOutSlowIn,
        hideCurve = hideCurve ?? Curves.fastOutSlowIn,
        super(key: key, controller: controller) {
    assert(menus != null);
  }

  @override
  DropdownState<DropdownMenu> createState() => _DropdownMenuState();
}

class _DropdownMenuState extends DropdownState<DropdownMenu>
    with TickerProviderStateMixin {
  List<_DropdownAnimation> _dropdownAnimations;
  bool _show;
  List<int> _showing;
  AnimationController _fadeController;
  Animation<double> _fadeAnimation;
  int _activeIndex;

  @override
  void initState() {
    super.initState();
    _showing = [];
    _dropdownAnimations = [];
    for (int i = 0; i < widget.menus.length; i++) {
      _dropdownAnimations.add(_DropdownAnimation(this));
    }
    _updateHeights();
    _show = false;
    _fadeController = AnimationController(vsync: this);
    _fadeAnimation = Tween(
      begin: 0.0,
      end: 50000.0,
    ).animate(_fadeController);
  }

  @override
  void dispose() {
    super.dispose();
    for (int i = 0; i < _dropdownAnimations.length; i++) {
      _dropdownAnimations[i].dispose();
    }
  }

  @override
  void didUpdateWidget(DropdownMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateHeights();
  }

  void _updateHeights() {
    for (int i = 0; i < widget.menus.length; i++) {
      _dropdownAnimations[i].height =
          _ensureHeight(_getHeight(widget.menus[i]));
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [];
    if (_show) {
      list.add(FadeTransition(
        opacity: _fadeAnimation,
        child: GestureDetector(
          onTap: onHide,
          child: _buildBackground(context),
        ),
      ));
    }

    for (int i = 0; i < widget.menus.length; i++) {
      list.add(RelativePositionedTransition(
        rect: _dropdownAnimations[i].rect,
        size: Size(10.0, -200.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            color: Colors.red,
            child: createMenu(context, widget.menus[i], i),
          ),
        ),
      ));
    }

    return Stack(
      fit: StackFit.expand,
      children: list,
    );
  }

  Widget createMenu(BuildContext context, DropdownMenuBuilder menu, int i) {
    DropdownMenuBuilder builder = menu;
    print(
        "---------->>>  ${_showing.contains(i) ? builder.builder(context) : null}");

    return ClipRect(
      // clipper: SizeClipper(),

      child: SizedBox(
          height: _ensureHeight(builder.height),
          child: Padding(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: _showing.contains(i) ? builder.builder(context) : null,
          )),
    );
  }

  Widget _buildBackground(BuildContext context) {
    Widget container = Container(
      color: Colors.black26,
    );

    container = BackdropFilter(
      filter: ui.ImageFilter.blur(
        sigmaY: 30.0,
        sigmaX: 10.0,
      ),
      child: container,
    );
    return container;
  }

  TickerFuture onHide({bool dispatch: true}) {
    if (_activeIndex != null) {
      int index = _activeIndex;
      _activeIndex = null;
      TickerFuture future = _hide(index);
      if (dispatch) {
        if (controller != null) {
          controller.hide();
        }
      }
      _fadeController.animateTo(0.0,
          duration: widget.hideDuration, curve: widget.hideCurve);

      future.whenComplete(() {
        setState(() {
          _show = false;
        });
      });
      return future;
    }
    return TickerFuture.complete();
  }

  TickerFuture _hide(int index) {
    TickerFuture future = _dropdownAnimations[index]
        .animateTo(0.0, duration: widget.hideDuration, curve: widget.hideCurve);
    return future;
  }

  TickerFuture _handleShow(int index, bool animation) {
    _activeIndex = index;
    setState(() {
      _show = true;
    });

    _fadeController.animateTo(1.0,
        duration: widget.showDuration, curve: widget.showCurve);
    return _dropdownAnimations[index]
        .animateTo(1.0, duration: widget.showDuration, curve: widget.showCurve);
  }

  Future<void> onShow(int index) {
    assert(index >= 0 && index < _dropdownAnimations.length);
    if (!_showing.contains(index)) {
      _showing.add(index);
    }

    if (_activeIndex != null) {
      if (_activeIndex == index) {
        return onHide();
      }
      switch (widget.switchStyle) {
        case DropdownMenuShowHideSwitchStyle.directHideAnimationShow:
          {
            _dropdownAnimations[_activeIndex].value = 0.0;
            _dropdownAnimations[index].value = 1.0;
            _activeIndex = index;
            setState(() {
              _show = true;
            });
            return Future.value(null);
          }
          break;
        case DropdownMenuShowHideSwitchStyle.animationHideAnimationShow:
          {
            _hide(_activeIndex);
          }
          break;
        case DropdownMenuShowHideSwitchStyle.directHideDirectShow:
          {
            _dropdownAnimations[_activeIndex].value = 0.0;
          }
          break;
        case DropdownMenuShowHideSwitchStyle
            .animationShowUntilAnimationHideComplete:
          {
            return _hide(_activeIndex).whenComplete(() {
              return _handleShow(index, true);
            });
          }
          break;
      }
    }

    return _handleShow(index, true);
  }

  @override
  void onEvent(DropdownEvent event) {
    switch (event) {
      case DropdownEvent.SELECT:
      case DropdownEvent.HIDE:
        {
          onHide(dispatch: false);
        }
        break;
      case DropdownEvent.ACTIVE:
        {
          print("controller.menuIndex     ${controller.menuIndex}");
          return;
          onShow(controller.menuIndex);
        }
        break;
    }
  }

  double _getHeight(dynamic menu) {
    DropdownMenuBuilder builder = menu as DropdownMenuBuilder;
    return builder.height;
  }

//限定高度在maxMenuHeight
  double _ensureHeight(double height) {
    final double maxMenuHeight = widget.maxMenuHeight;
    assert(height != null || maxMenuHeight != null,
        "DropdownMenu.maxMenuHeight and DropdownMenuBuilder.height must not both null");
    if (maxMenuHeight != null) {
      if (height == null) return maxMenuHeight;
      return height > maxMenuHeight ? maxMenuHeight : height;
    }
    return height;
  }
}

class _DropdownAnimation {
  Animation<Rect> rect;
  AnimationController animationController;
  RectTween position;
  _DropdownAnimation(TickerProvider provider) {
    animationController = AnimationController(vsync: provider);
  }

  set height(double value) {
    position = RectTween(
      begin: Rect.fromLTRB(0.0, -value, 0.0, 0.0),
      end: Rect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    );
    rect = position.animate(animationController);
  }

  set value(double value) {
    animationController.dispose();
  }

  void dispose() {
    animationController.dispose();
  }

  TickerFuture animateTo(double value, {Duration duration, Curve curve}) {
    return animationController.animateTo(value,
        duration: duration * 10, curve: curve);
  }
}

class SizeClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0.0, 0.0, size.width, size.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return false;
  }
}

class DropdownMenuBuilder {
  final WidgetBuilder builder;
  final double height;

  DropdownMenuBuilder({@required this.builder, this.height})
      : assert(builder != null);
}

/*
**********************************************
**********************************************
******************  公用 **********************
**********************************************
**********************************************
*/

typedef Widget MenuItemBuilder<T>(BuildContext context, T data, bool selected);

class DropdownListMenu<T> extends DropdownWidget {
  final List<T> data;
  final int selectedIndex;
  final MenuItemBuilder itemBuilder;
  final double itemExtent;

  DropdownListMenu(
      {this.data, this.selectedIndex, this.itemBuilder, this.itemExtent: 45.5});

  @override
  DropdownState<DropdownWidget> createState() => _MenuListState<T>();
}

class _MenuListState<T> extends DropdownState<DropdownListMenu<T>> {
  int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemExtent: widget.itemExtent,
      itemBuilder: buildItem,
      itemCount: widget.data.length,
    );
  }

  Widget buildItem(BuildContext context, int index) {
    final List<T> list = widget.data;
    final T data = list[index];
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: widget.itemBuilder(context, data, index == _selectedIndex),
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
        assert(controller != null);

        controller.select(data, index: index);
      },
    );
  }

  @override
  void onEvent(DropdownEvent event) {
    switch (event) {
      case DropdownEvent.SELECT:
      case DropdownEvent.HIDE:
        {}
        break;
      case DropdownEvent.ACTIVE:
        {}
        break;
    }
  }
}

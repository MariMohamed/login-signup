import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login_signin/core/app_assets.dart';
import 'package:login_signin/core/app_colors.dart';

class Counter extends StatefulWidget {
  final int? initNumber;
  final Function(int)? counterCallback;
  final Function? increaseCallback;
  final Function? decreaseCallback;
  const Counter({
    super.key,
    this.counterCallback,
    this.increaseCallback,
    this.decreaseCallback,
    this.initNumber,
  });
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  late int _currentCount;
  late Function _counterCallback;
  late Function _increaseCallback;
  late Function _decreaseCallback;
  final int _minNumber = 1;

  @override
  void initState() {
    _currentCount = widget.initNumber ?? 1;
    _counterCallback = widget.counterCallback ?? (int number) {};
    _increaseCallback = widget.increaseCallback ?? () {};
    _decreaseCallback = widget.decreaseCallback ?? () {};
    _minNumber;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
      child: Row(
        spacing: 16,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _createIncrementDicrementButton(
            SvgPicture.asset(AppAssets.minus),
            () => _dicrement(),
          ),
          Text(
            _currentCount.toString(),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          _createIncrementDicrementButton(
            SvgPicture.asset(AppAssets.plus),
            () => _increment(),
          ),
        ],
      ),
    );
  }

  void _increment() {
    setState(() {
      _currentCount++;
      _counterCallback(_currentCount);
      _increaseCallback();
    });
  }

  void _dicrement() {
    setState(() {
      if (_currentCount > _minNumber) {
        _currentCount--;
        _counterCallback(_currentCount);
        _decreaseCallback();
      }
    });
  }

  Widget _createIncrementDicrementButton(Widget icon, VoidCallback onPressed) {
    return RawMaterialButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      constraints: BoxConstraints(minWidth: 20.0, minHeight: 20.0),
      onPressed: onPressed,
      elevation: 2.0,
      shape: CircleBorder(),
      child: icon,
    );
  }
}

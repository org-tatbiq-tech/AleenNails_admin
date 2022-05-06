import 'package:appointments/utils/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';

class OverPopupPage extends StatefulWidget {
  final Offset showOffset;
  final Size buttonSize;
  final Widget child;

  OverPopupPage({
    Key? key,
    required this.showOffset,
    required this.buttonSize,
    required this.child,
  }) : super(key: key);

  @override
  _OverPopupPageState createState() => _OverPopupPageState();
}

class _OverPopupPageState extends State<OverPopupPage>
    with TickerProviderStateMixin {
  double opacity = 0;
  double top = Device.screenHeight;
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 400),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  void _show(bool isVisible) {
    isVisible ? _controller.forward() : _controller.reverse();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _show(true);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
      body: Stack(
        children: [
          Positioned.fill(child: GestureDetector(
            onTap: () {
              _show(false);
              Navigator.of(context).pop();
            },
          )),
          Positioned(
              top: widget.showOffset.dy - rSize(60),
              left: widget.showOffset.dx + widget.buttonSize.width / 2,
              child: ScaleTransition(
                scale: _animation,
                alignment: Alignment.bottomLeft,
                child: Container(
                  height: rSize(50),
                  padding: EdgeInsets.symmetric(
                    horizontal: rSize(20),
                    // vertical: rSize(10),
                  ),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).shadowColor,
                          blurRadius: 2,
                          offset:
                              const Offset(0, 1), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        rSize(10),
                      )),
                  child: widget.child,
                ),
              ))
        ],
      ),
    );
  }
}

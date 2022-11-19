import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/material.dart';

class CustomToggle extends StatelessWidget {
  final double width;
  final double height;
  final double xAlign;
  final Function setXAlign;
  const CustomToggle({
    Key? key,
    required this.width,
    required this.height,
    required this.xAlign,
    required this.setXAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onBackground,
          borderRadius: BorderRadius.circular(rSize(30)),
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              duration: const Duration(milliseconds: 500),
              alignment: Alignment(xAlign, 0),
              child: Container(
                width: width * 0.5,
                height: height,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(rSize(10)),
                ),
              ),
            ),
            GestureDetector(
                child: Align(
                  alignment: const Alignment(-1, 0),
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.transparent,
                    width: width * 0.5,
                    height: height,
                    child: Text(
                      '₪',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontSize: rSize(18),
                            color: xAlign == -1
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(context).colorScheme.primary,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                onTap: () => setXAlign(-1.0)),
            GestureDetector(
                child: Align(
                  alignment: const Alignment(1, 0),
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.transparent,
                    width: width * 0.5,
                    height: height,
                    child: Text(
                      '%',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontSize: rSize(18),
                            color: xAlign == 1
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(context).colorScheme.primary,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                onTap: () => setXAlign(1.0)),
          ],
        ),
      ),
    );
  }
}

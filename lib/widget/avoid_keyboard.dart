import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';

/// A wrapper widget which will scroll out of the way when the keyboard is showing,
/// given the keyboard overlaps an active input control which is a descendent of [child].
///
/// To use, simply wrap the elements which you want to avoid the keyboard within the
/// [AvoidKeyboard] widget. The widget will automatically detect when input elements
/// become active and scroll the viewport accordingly.
///
/// Example:
/// ```dart
/// class AvoidKeyboardExample extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return AvoidKeyboard(
///       child: Column(
///         children: [
///           TextField(),
///           TextField(),
///         ],
///       ),
///     );
///   }
/// }
/// ```
class AvoidKeyboard extends StatefulWidget {
  /// The child to wrap.
  final Widget child;
  final List<FocusNode>? focusNodes;

  /// The space between the active input control and the top of the keyboard.
  /// Must be >= 0.
  final double? spacing;

  const AvoidKeyboard({
    Key? key,
    required this.child,
    this.focusNodes,
    this.spacing,
  }) : super(key: key);

  @override
  _AvoidKeyboardState createState() => _AvoidKeyboardState();
}

class _AvoidKeyboardState extends State<AvoidKeyboard>
    with AfterLayoutMixin<AvoidKeyboard> {
  final _focusNode = FocusNode();

  double _offset = 0;

  bool _hasFocus = false;

  double get _spacing => (widget.spacing ?? 0) < 0 ? 0 : widget.spacing ?? 0;

  @override
  void afterFirstLayout(BuildContext context) {
    _focusNode.addListener(() async {
      if (!_focusNode.hasFocus) {
        _handleLoseFocus();
      }
    });

    for (final node in _focusNode.traversalDescendants) {
      node.addListener(() {
        if (node.hasFocus) {
          print("Handle focus");
          _handleFocus();
        }
      });
    }
  }

  void _handleFocus() async {
    FocusNode primaryNode;

    try {
      primaryNode = _focusNode.traversalDescendants
          .firstWhere((element) => element.hasPrimaryFocus);
    } catch (_) {
      return;
    }

    try {
      // Wait for the bottom inset to update, unless another
      // child node has already been focused.
      if (!_hasFocus) {
        await waitForKeyboardFrameUpdate();
      } else {
        await Future.delayed(Duration(milliseconds: 50)).catchError((_) {});
      }
    } catch (_) {
      // Catch possible timeout error
    }

    final viewPortBottom = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.bottom -
        _spacing;
    final nodeBottom = primaryNode.rect.bottom;

    if (nodeBottom > viewPortBottom) {
      final overlap = nodeBottom - viewPortBottom;

      setState(() {
        _offset += overlap;
        _hasFocus = true;
      });
    }
  }

  // The keyboard frame will not update immediately upon focus, therefore
  // we need to see a change in the bottom inset, before scrolling the viewport.
  Future<void> waitForKeyboardFrameUpdate() {
    final completer = Completer();
    final currentBottomInset = MediaQuery.of(context).viewInsets.bottom;

    final timer = Timer.periodic(Duration(milliseconds: 50), (_) {
      final newBottomInset = MediaQuery.of(context).viewInsets.bottom;

      if (currentBottomInset != newBottomInset) {
        completer.complete();
      }
    });

    return completer.future
        .timeout(Duration(milliseconds: 100))
        .whenComplete(() => timer.cancel());
  }

  void _handleLoseFocus() async {
    setState(() {
      _offset = 0;
      _hasFocus = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      child: ClipRect(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 160),
          curve: Curves.easeInOut,
          transform: Matrix4.translationValues(0, -_offset, 0),
          child: widget.child,
        ),
      ),
    );
  }
}

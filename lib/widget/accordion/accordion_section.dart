import 'dart:async';
import 'dart:math';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/ease_in_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:appointments/widget/accordion/accordion.dart';
import 'package:appointments/widget/accordion/controllers.dart';

class AccordionSection extends StatelessWidget with CommonParams {
  final SectionController sectionCtrl = SectionController();
  late final UniqueKey uniqueKey;
  late final int index;
  final listCtrl = Get.put(ListController());
  final bool isOpen;
  final bool isDisabled;

  /// The text to be displayed in the header
  final Widget header;

  /// The widget to be displayed as the content of the section when open
  final Widget content;

  AccordionSection({
    Key? key,
    this.index = 0,
    this.isOpen = false,
    this.isDisabled = false,
    required this.header,
    required this.content,
    Color? headerBackgroundColor,
    Color? headerBackgroundColorOpened,
    double? headerBorderRadius,
    EdgeInsets? headerPadding,
    Widget? leftIcon,
    Widget? rightIcon,
    bool? flipRightIconIfOpen = true,
    Color? contentBackgroundColor,
    Color? contentBorderColor,
    double? contentBorderWidth,
    double? contentBorderRadius,
    double? contentHorizontalPadding,
    double? contentVerticalPadding,
    double? paddingBetweenOpenSections,
    double? paddingBetweenClosedSections,
    ScrollIntoViewOfItems? scrollIntoViewOfItems,
    SectionHapticFeedback? sectionOpeningHapticFeedback,
    SectionHapticFeedback? sectionClosingHapticFeedback,
  }) : super(key: key) {
    uniqueKey = listCtrl.keys.elementAt(index);
    sectionCtrl.isSectionOpen.value = listCtrl.openSections.contains(uniqueKey);

    this.headerBackgroundColor = headerBackgroundColor;
    this.headerBackgroundColorOpened =
        headerBackgroundColorOpened ?? headerBackgroundColor;
    this.headerBorderRadius = headerBorderRadius;
    this.headerPadding = headerPadding;
    this.leftIcon = leftIcon;
    this.rightIcon = rightIcon;
    this.flipRightIconIfOpen?.value = flipRightIconIfOpen ?? true;
    this.contentBackgroundColor = contentBackgroundColor;
    this.contentBorderColor = contentBorderColor;
    this.contentBorderWidth = contentBorderWidth ?? rSize(1);
    this.contentBorderRadius = contentBorderRadius ?? rSize(15);
    this.contentHorizontalPadding = contentHorizontalPadding ?? rSize(15);
    this.contentVerticalPadding = contentVerticalPadding ?? rSize(15);
    this.paddingBetweenOpenSections = paddingBetweenOpenSections ?? rSize(15);
    this.paddingBetweenClosedSections =
        paddingBetweenClosedSections ?? rSize(15);
    this.scrollIntoViewOfItems =
        scrollIntoViewOfItems ?? ScrollIntoViewOfItems.fast;
    this.sectionOpeningHapticFeedback = sectionOpeningHapticFeedback;
    this.sectionClosingHapticFeedback = sectionClosingHapticFeedback;

    listCtrl.controllerIsOpen.stream.asBroadcastStream().listen((data) {
      sectionCtrl.isSectionOpen.value = listCtrl.openSections.contains(key);
    });
  }

  /// getter to flip the widget vertically (Icon by default)
  /// on the right of this section header to visually indicate
  /// if this section is open or closed
  get _flipQuarterTurns =>
      flipRightIconIfOpen?.value == true ? (_isOpen ? 2 : 0) : 0;

  /// getter indication the open or closed status of this section
  get _isOpen {
    final open = sectionCtrl.isSectionOpen.value;

    Timer(
      sectionCtrl.firstRun
          ? (listCtrl.initialOpeningSequenceDelay + min(index * 200, 1000))
              .milliseconds
          : 0.seconds,
      () {
        if (Accordion.sectionAnimation) {
          sectionCtrl.controller
              .fling(velocity: open ? 1 : -1, springDescription: springFast);
        } else {
          sectionCtrl.controller.value = open ? 1 : 0;
        }
        sectionCtrl.firstRun = false;
      },
    );

    return open;
  }

  /// play haptic feedback when opening/closing sections
  _playHapticFeedback(bool opening) {
    final feedback =
        opening ? sectionOpeningHapticFeedback : sectionClosingHapticFeedback;

    switch (feedback) {
      case SectionHapticFeedback.light:
        HapticFeedback.lightImpact();
        break;
      case SectionHapticFeedback.medium:
        HapticFeedback.mediumImpact();
        break;
      case SectionHapticFeedback.heavy:
        HapticFeedback.heavyImpact();
        break;
      case SectionHapticFeedback.selection:
        HapticFeedback.selectionClick();
        break;
      case SectionHapticFeedback.vibrate:
        HapticFeedback.vibrate();
        break;
      default:
    }
  }

  @override
  build(context) {
    final _borderRadius = headerBorderRadius ?? 10;

    return Obx(
      () => Column(
        key: uniqueKey,
        children: [
          EaseInAnimation(
            isDisabled: isDisabled,
            beginAnimation: 0.99,
            onTap: () {
              print(isDisabled);
              listCtrl.updateSections(uniqueKey);
              _playHapticFeedback(_isOpen);

              if (_isOpen &&
                  scrollIntoViewOfItems != ScrollIntoViewOfItems.none &&
                  listCtrl.controller.hasClients) {
                Timer(
                  250.milliseconds,
                  () {
                    listCtrl.controller.cancelAllHighlights();
                    listCtrl.controller.scrollToIndex(index,
                        preferPosition: AutoScrollPosition.middle,
                        duration:
                            (scrollIntoViewOfItems == ScrollIntoViewOfItems.fast
                                    ? .5
                                    : 1)
                                .seconds);
                  },
                );
              }
            },
            child: AnimatedContainer(
              duration: Accordion.sectionAnimation
                  ? 750.milliseconds
                  : 0.milliseconds,
              curve: Curves.easeOut,
              alignment: Alignment.center,
              padding: headerPadding,
              decoration: BoxDecoration(
                color: (_isOpen
                        ? isDisabled
                            ? lighten(headerBackgroundColorOpened!)
                            : headerBackgroundColorOpened
                        : isDisabled
                            ? lighten(headerBackgroundColor!)
                            : headerBackgroundColor) ??
                    Theme.of(context).primaryColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(_borderRadius),
                  bottom: Radius.circular(_isOpen ? 0 : _borderRadius),
                ),
              ),
              child: Row(
                children: [
                  if (leftIcon != null) leftIcon!,
                  Expanded(
                    flex: 10,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: leftIcon == null ? 0 : 15),
                      child: header,
                    ),
                  ),
                  if (rightIcon != null)
                    RotatedBox(
                        quarterTurns: _flipQuarterTurns, child: rightIcon!),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: _isOpen
                    ? paddingBetweenOpenSections!
                    : paddingBetweenClosedSections!),
            child: SizeTransition(
              sizeFactor: sectionCtrl.controller,
              child: ScaleTransition(
                scale: sectionCtrl.controller,
                child: Center(
                  child: Container(
                    // clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      color:
                          contentBorderColor ?? Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(contentBorderRadius!)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        contentBorderWidth ?? rSize(1),
                        0,
                        contentBorderWidth ?? rSize(1),
                        contentBorderWidth ?? rSize(1),
                      ),
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(
                                    contentBorderRadius! / 1.02))),
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              color: contentBackgroundColor,
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(
                                      contentBorderRadius! / 1.02))),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: contentHorizontalPadding!,
                              vertical: contentVerticalPadding!,
                            ),
                            child: Center(
                              child: content,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

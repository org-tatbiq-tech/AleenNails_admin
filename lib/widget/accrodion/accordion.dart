import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:appointments/widget/accrodion/accordion_section.dart';
import 'package:appointments/widget/accrodion/controllers.dart';

class Accordion extends StatelessWidget with CommonParams {
  final List<AccordionSection> children;
  final double paddingListHorizontal;
  final double paddingListTop;
  final double paddingListBottom;
  final bool disableScrolling;
  static bool sectionAnimation = true;
  final listCtrl = Get.put(ListController());
  

  Accordion({
    Key? key,
    int? maxOpenSections,
    required this.children,
    int? initialOpeningSequenceDelay,
    Color? headerBackgroundColor,
    Color? headerBackgroundColorOpened,
    double? headerBorderRadius,
    Widget? leftIcon,
    Widget? rightIcon,
    Widget? header,
    bool? flipRightIconIfOpen,
    Color? contentBackgroundColor,
    Color? contentBorderColor,
    double? contentBorderWidth,
    double? contentBorderRadius,
    double? contentHorizontalPadding,
    double? contentVerticalPadding,
    this.paddingListTop = 20.0,
    this.paddingListBottom = 40.0,
    this.paddingListHorizontal = 10.0,
    EdgeInsets? headerPadding,
    double? paddingBetweenOpenSections,
    double? paddingBetweenClosedSections,
    ScrollIntoViewOfItems? scrollIntoViewOfItems,
    this.disableScrolling = false,
    SectionHapticFeedback? sectionOpeningHapticFeedback,
    SectionHapticFeedback? sectionClosingHapticFeedback,
    bool? openAndCloseAnimation,
  }) : super(key: key) {
    listCtrl.initialOpeningSequenceDelay = initialOpeningSequenceDelay ?? 0;
    listCtrl.maxOpenSections = maxOpenSections ?? 1;

    int index = 0;
    for (var child in children) {
      if (child.isOpen &&
          listCtrl.openSections.length < listCtrl.maxOpenSections) {
        listCtrl.openSections.add(listCtrl.keys.elementAt(index));
      }
      index++;
    }

    this.headerBackgroundColor = headerBackgroundColor;
    this.headerBackgroundColorOpened =
        headerBackgroundColorOpened ?? headerBackgroundColor;
    this.headerBorderRadius = headerBorderRadius;
    this.leftIcon = leftIcon;
    this.rightIcon = rightIcon;
    this.flipRightIconIfOpen?.value = flipRightIconIfOpen ?? true;
    this.contentBackgroundColor = contentBackgroundColor;
    this.contentBorderColor = contentBorderColor;
    this.contentBorderWidth = contentBorderWidth;
    this.contentBorderRadius = contentBorderRadius ?? 10;
    this.contentHorizontalPadding = contentHorizontalPadding;
    this.contentVerticalPadding = contentVerticalPadding;
    this.headerPadding = headerPadding ??
        const EdgeInsets.symmetric(horizontal: 15, vertical: 7);
    this.paddingBetweenOpenSections = paddingBetweenOpenSections ?? 10;
    this.paddingBetweenClosedSections = paddingBetweenClosedSections ?? 3;
    this.scrollIntoViewOfItems = scrollIntoViewOfItems;
    this.sectionOpeningHapticFeedback =
        sectionOpeningHapticFeedback ?? SectionHapticFeedback.none;
    this.sectionClosingHapticFeedback =
        sectionClosingHapticFeedback ?? SectionHapticFeedback.none;
    sectionAnimation = openAndCloseAnimation ?? true;
  }

  @override
  build(context) {
    return ListView.builder(
      itemCount: children.length,
      controller: listCtrl.controller,
      shrinkWrap: true,
      physics: disableScrolling
          ? const NeverScrollableScrollPhysics()
          : const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.only(
        top: paddingListTop,
        bottom: paddingListBottom,
        right: paddingListHorizontal,
        left: paddingListHorizontal,
      ),
      cacheExtent: 100000,
      itemBuilder: (context, index) {
        final key = listCtrl.keys.elementAt(index);
        final child = children.elementAt(index);

        return AutoScrollTag(
          key: key,
          controller: listCtrl.controller,
          index: index,
          child: AccordionSection(
            key: key,
            index: index,
            isOpen: child.isOpen,
            scrollIntoViewOfItems: scrollIntoViewOfItems,
            headerBackgroundColor:
                child.headerBackgroundColor ?? headerBackgroundColor,
            headerBackgroundColorOpened: child.headerBackgroundColorOpened ??
                headerBackgroundColorOpened ??
                headerBackgroundColor,
            headerBorderRadius: child.headerBorderRadius ?? headerBorderRadius,
            headerPadding: child.headerPadding ?? headerPadding,
            header: child.header,
            leftIcon: child.leftIcon ?? leftIcon,
            rightIcon: child.rightIcon ??
                rightIcon ??
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white60,
                  size: 20,
                ),
            flipRightIconIfOpen:
                child.flipRightIconIfOpen?.value ?? flipRightIconIfOpen?.value,
            paddingBetweenClosedSections: child.paddingBetweenClosedSections ??
                paddingBetweenClosedSections,
            paddingBetweenOpenSections:
                child.paddingBetweenOpenSections ?? paddingBetweenOpenSections,
            content: child.content,
            contentBackgroundColor:
                child.contentBackgroundColor ?? contentBackgroundColor,
            contentBorderColor: child.contentBorderColor ?? contentBorderColor,
            contentBorderWidth: child.contentBorderWidth ?? contentBorderWidth,
            contentBorderRadius:
                child.contentBorderRadius ?? contentBorderRadius,
            contentHorizontalPadding:
                child.contentHorizontalPadding ?? contentHorizontalPadding,
            contentVerticalPadding:
                child.contentVerticalPadding ?? contentVerticalPadding,
            sectionOpeningHapticFeedback: child.sectionOpeningHapticFeedback ??
                sectionOpeningHapticFeedback,
            sectionClosingHapticFeedback: child.sectionClosingHapticFeedback ??
                sectionClosingHapticFeedback,
          ),
        );
      },
    );
  }
}

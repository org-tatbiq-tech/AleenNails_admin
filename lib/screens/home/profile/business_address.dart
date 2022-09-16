import 'package:common_widgets/utils/layout.dart';
import 'package:common_widgets/custom_app_bar.dart';

import 'package:common_widgets/custom_input_field.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BusinessAddress extends StatefulWidget {
  const BusinessAddress({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BusinessAddressState();
  }
}

class BusinessAddressState extends State<BusinessAddress> {
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _streetController.addListener(() => setState(() {}));
    _cityController.addListener(() => setState(() {}));
    _zipCodeController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _zipCodeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget renderMapLocation() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: rSize(10),
              right: rSize(10),
              bottom: rSize(5),
            ),
            child: Text(
              'Map Location',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          SizedBox(
            height: rSize(5),
          ),
          CustomInputField(
            customInputFieldProps: CustomInputFieldProps(
              controller: _zipCodeController,
              keyboardType: TextInputType.number,
            ),
          ),
        ],
      );
    }

    Widget renderZipCode() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: rSize(10),
              right: rSize(10),
              bottom: rSize(5),
            ),
            child: Text(
              'Zip Code',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          SizedBox(
            height: rSize(5),
          ),
          CustomInputField(
            customInputFieldProps: CustomInputFieldProps(
              controller: _zipCodeController,
              keyboardType: TextInputType.number,
            ),
          ),
        ],
      );
    }

    Widget renderCity() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: rSize(10),
              right: rSize(10),
              bottom: rSize(5),
            ),
            child: Text(
              'City',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          SizedBox(
            height: rSize(5),
          ),
          CustomInputField(
            customInputFieldProps: CustomInputFieldProps(
              controller: _cityController,
              keyboardType: TextInputType.text,
            ),
          ),
        ],
      );
    }

    Widget renderStreet() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: rSize(10),
              right: rSize(10),
              bottom: rSize(5),
            ),
            child: Text(
              'Street Address & Number',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          SizedBox(
            height: rSize(5),
          ),
          CustomInputField(
            customInputFieldProps: CustomInputFieldProps(
              controller: _streetController,
              keyboardType: TextInputType.text,
            ),
          ),
        ],
      );
    }

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          customAppBarProps: CustomAppBarProps(
            titleText: 'Business Location',
            barHeight: 110,
            withClipPath: true,
            withBack: true,
            customIcon: Icon(
              FontAwesomeIcons.floppyDisk,
              size: rSize(24),
            ),
            customIconTap: () => {Navigator.pushNamed(context, '/newService')},
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: rSize(30),
            vertical: rSize(40),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              renderStreet(),
              SizedBox(
                height: rSize(20),
              ),
              renderCity(),
              SizedBox(
                height: rSize(20),
              ),
              renderZipCode(),
              SizedBox(
                height: rSize(20),
              ),
              renderMapLocation(),
            ],
          ),
        ),
      ),
    );
  }
}

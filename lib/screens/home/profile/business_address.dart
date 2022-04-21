import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/custom_app_bar.dart';
import 'package:appointments/widget/custom_input_field.dart';
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
    Widget _renderMapLocation() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'Map Location',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontSize: rSize(18),
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

    Widget _renderZipCode() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'Zip Code',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontSize: rSize(18),
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

    Widget _renderCity() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'City',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontSize: rSize(18),
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

    Widget _renderStreet() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'Street Address & Number',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontSize: rSize(18),
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
              _renderStreet(),
              SizedBox(
                height: rSize(20),
              ),
              _renderCity(),
              SizedBox(
                height: rSize(20),
              ),
              _renderZipCode(),
              SizedBox(
                height: rSize(20),
              ),
              _renderMapLocation(),
            ],
          ),
        ),
      ),
    );
  }
}

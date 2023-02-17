import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/material.dart';

class RoundedDropDown extends StatelessWidget {
  final dynamic value;
  final String hint;
  final String errorText;
  final List<DropdownMenuItem<Object>> items;
  final Function onChanged;

  const RoundedDropDown(
      {Key? key,
      this.value,
      this.hint = '',
      required this.items,
      required this.onChanged,
      this.errorText = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.9),
            border: Border.all(color: Theme.of(context).colorScheme.onPrimary),
            borderRadius: BorderRadius.circular(rSize(2)),
          ),
          child: Padding(
            padding:
                EdgeInsets.fromLTRB(rSize(2), rSize(1), rSize(2), rSize(1)),
            child: DropdownButton(
              value: value,
              hint: Text(
                hint,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontSize: rSize(12)),
                overflow: TextOverflow.ellipsis,
              ),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontSize: rSize(12)),
              items: items,
              onChanged: (item) {
                onChanged(item);
              },
              isExpanded: true,
              underline: Container(),
              icon: const Icon(Icons.keyboard_arrow_down),
            ),
          ),
        ),
        if (errorText.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(left: 30, top: 10),
            child: Text(
              errorText,
              style: TextStyle(fontSize: 12, color: Colors.red[800]),
            ),
          )
      ],
    );
  }
}

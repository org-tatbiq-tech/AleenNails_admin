import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/custom_icon.dart';
import 'package:appointments/widget/custom_input_field.dart';
import 'package:appointments/widget/ease_in_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';

class SearchBar extends StatefulWidget implements PreferredSizeWidget {
  const SearchBar({Key? key, required this.onCancelSearch, required this.onSearchQueryChanged, required this.barHeight})
      : super(key: key);

  final VoidCallback onCancelSearch;
  final Function(String) onSearchQueryChanged;
  final double barHeight;

  @override
  Size get preferredSize => Device.get().isIphoneX ? Size.fromHeight(barHeight) : Size.fromHeight(barHeight - 15);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> with SingleTickerProviderStateMixin {
  String searchQuery = '';
  final TextEditingController _searchFieldController = TextEditingController();

  clearSearchQuery() {
    _searchFieldController.clear();
    widget.onSearchQueryChanged('');
  }

  @override
  void initState() {
    super.initState();
    _searchFieldController.addListener(() => setState(() {
          widget.onSearchQueryChanged(_searchFieldController.text);
        }));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(rSize(15), 0, 0, 0),
                child: CustomIcon(
                  customIconProps: CustomIconProps(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    icon: EaseInAnimation(
                      child: IconTheme(
                        data: Theme.of(context).iconTheme,
                        child: const Icon(
                          Icons.arrow_back,
                        ),
                      ),
                      onTap: widget.onCancelSearch,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(rSize(20), 0, rSize(20), 0),
                  child: CustomInputField(
                    customInputFieldProps: CustomInputFieldProps(
                      controller: _searchFieldController,
                      isSearch: true,
                      labelText: 'Search...',
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

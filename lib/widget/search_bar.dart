import 'package:appointments/widget/custom_icon.dart';
import 'package:appointments/widget/custom_input_field.dart';
import 'package:appointments/widget/ease_in_animation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SearchBar extends StatefulWidget implements PreferredSizeWidget {
  const SearchBar({
    Key? key,
    required this.onCancelSearch,
    required this.onSearchQueryChanged,
  }) : super(key: key);

  final VoidCallback onCancelSearch;
  final Function(String) onSearchQueryChanged;

  @override
  Size get preferredSize => const Size.fromHeight(65.0);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar>
    with SingleTickerProviderStateMixin {
  String searchQuery = '';
  final TextEditingController _searchFieldController = TextEditingController();

  clearSearchQuery() {
    _searchFieldController.clear();
    widget.onSearchQueryChanged('');
  }

  @override
  void initState() {
    super.initState();
    _searchFieldController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(3.w, 0, 0, 0),
                child: CustomIcon(
                  color: Theme.of(context).colorScheme.primary,
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
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(5.w, 0, 5.w, 0),
                  child: CustomInputField(
                    isSearch: true,
                    controller: _searchFieldController,
                    labelText: 'Search...',
                  ),
                ),
                // child: TextField(
                //   controller: _searchFieldController,
                //   cursorColor: Colors.white,
                //   style: Theme.of(context)
                //       .textTheme
                //       .bodyText1
                //       ?.copyWith(fontSize: 13.sp),
                //   decoration: InputDecoration(
                //     border: InputBorder.none,
                //     prefixIcon: IconTheme(
                //       data: Theme.of(context).iconTheme,
                //       child: const Icon(
                //         Icons.search,
                //       ),
                //     ),
                //     hintText: "Search...",
                //     hintStyle: Theme.of(context)
                //         .textTheme
                //         .bodyText1
                //         ?.copyWith(fontSize: 13.sp),
                //     suffixIcon: InkWell(
                //       child: IconTheme(
                //         data: Theme.of(context).iconTheme,
                //         child: const Icon(
                //           Icons.close,
                //         ),
                //       ),
                //       onTap: clearSearchQuery,
                //     ),
                //   ),
                //   onChanged: widget.onSearchQueryChanged,
                // ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

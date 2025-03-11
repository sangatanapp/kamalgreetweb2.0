import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:kamal_greet_web_2/Utils/widgets/CreationDecorations.dart';

class DynamicDropdown extends StatefulWidget {
  const DynamicDropdown({
    Key? key,
    required this.dropDownList,
    this.hintText,
    this.length,
    this.labelText,
    this.onChange,
    this.selectedValue,
    this.enabled,
  }) : super(key: key);

  final String? hintText;
  final int? length;
  final String? labelText;
  final bool? enabled;
  final Function(dynamic)? onChange;
  final dynamic selectedValue;
  final List<String> dropDownList;

  @override
  _DynamicDropdownState createState() => _DynamicDropdownState();
}

class _DynamicDropdownState extends State<DynamicDropdown> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? selectedVal = '';
    if (widget.selectedValue == '') {
      selectedVal = null;
    } else {
      selectedVal = widget.selectedValue;
    }
    return DropdownButtonHideUnderline(
      child: DropdownSearch<String>(
        popupProps: PopupProps.menu(
          searchDelay: const Duration(milliseconds: 0),
          onDismissed: () {
            _searchController.clear();
          },
          showSearchBox: widget.length! > 10 ? true : false,
          searchFieldProps: TextFieldProps(
            controller: _searchController,
            focusNode: _searchFocusNode,
            decoration: InputDecoration(
              suffixIcon: ValueListenableBuilder<TextEditingValue>(
                valueListenable: _searchController,
                builder: (context, value, _) {
                  return value.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                          },
                        )
                      : const SizedBox.shrink();
                },
              ),
              enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: const BorderSide(width: 1, color: Colors.teal),
              ),
              hintText: 'Search...',
              prefixIcon: const Icon(Icons.search),
            ),
          ),
          showSelectedItems: true,
          fit: FlexFit.loose,
        ),
        items: widget.dropDownList,
        enabled: widget.enabled ?? true,
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: CreationDecorations().inputDecoration(
            labelText: widget.labelText,
            hintText: widget.hintText,
          ),
        ),
        onChanged: widget.onChange,
        selectedItem: selectedVal,
      ),
    );
  }
}

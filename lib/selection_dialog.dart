import 'package:country_code_picker/country_code.dart';
import 'package:country_code_picker/country_codes.dart';
import 'package:country_code_picker/country_localizations.dart';
import 'package:flutter/material.dart';

/// selection dialog used for selection of the country code
class SelectionDialog extends StatefulWidget {
  final InputDecoration searchDecoration;
  final TextStyle? searchStyle;
  final TextStyle? textStyle;
  final BoxDecoration? boxDecoration;
  final WidgetBuilder? emptySearchBuilder;
  final double flagWidth;
  final Decoration? flagDecoration;
  final Size? size;
  final bool hideSearch;
  final Icon? closeIcon;
  final Function(CountryCode country) onSelect;

  /// Background color of SelectionDialog
  final Color? backgroundColor;

  /// Boxshaow color of SelectionDialog that matches CountryCodePicker barrier color
  final Color? barrierColor;

  /// Use this property to change the order of the options
  final Comparator<CountryCode>? comparator;

  /// used to customize the country list
  final List<String>? countryFilter;

  final Widget Function(CountryCode country) itemBuilder;

  final EdgeInsets? searchPadding;

  SelectionDialog(
      {Key? key,
      this.emptySearchBuilder,
      InputDecoration searchDecoration = const InputDecoration(),
      this.searchStyle,
      this.textStyle,
      this.boxDecoration,
      this.flagDecoration,
      this.flagWidth = 32,
      this.size,
      this.backgroundColor,
      this.barrierColor,
      this.hideSearch = false,
      this.closeIcon,
      required this.onSelect,
      this.comparator,
      this.countryFilter,
      required this.itemBuilder,
      this.searchPadding})
      : this.searchDecoration = searchDecoration.prefixIcon == null
            ? searchDecoration.copyWith(prefixIcon: Icon(Icons.search))
            : searchDecoration,
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    List<Map<String, String>> jsonList = codes;

    List<CountryCode> elements =
        jsonList.map((json) => CountryCode.fromJson(json)).toList();

    if (comparator != null) {
      elements.sort(comparator);
    }

    if (countryFilter != null && countryFilter!.isNotEmpty) {
      final uppercaseCustomList =
          countryFilter!.map((c) => c.toUpperCase()).toList();
      elements = elements
          .where((c) =>
              uppercaseCustomList.contains(c.code) ||
              uppercaseCustomList.contains(c.name) ||
              uppercaseCustomList.contains(c.dialCode))
          .toList();
    }

    return _SelectionDialogState(elements);
  }
}

class _SelectionDialogState extends State<SelectionDialog> {
  /// this is useful for filtering purpose
  late List<CountryCode> filteredElements;
  final List<CountryCode> elements;

  _SelectionDialogState(this.elements);

  @override
  void initState() {
    super.initState();
    filteredElements = elements;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: widget.boxDecoration ??
          BoxDecoration(
            color: widget.backgroundColor ?? Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!widget.hideSearch)
            Padding(
              padding:
                  widget.searchPadding ?? EdgeInsets.symmetric(horizontal: 24),
              child: TextField(
                style: widget.searchStyle,
                decoration: widget.searchDecoration,
                autofocus: true,
                onChanged: _filterElements,
              ),
            ),
          Expanded(
            child: (filteredElements.isEmpty)
                ? _buildEmptySearchWidget(context)
                : ListView.builder(
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
                    itemBuilder: (_, i) {
                      return _buildOption(filteredElements[i]);
                    },
                    itemCount: filteredElements.length,
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(CountryCode e) {
    return widget.itemBuilder(e);
  }

  Widget _buildEmptySearchWidget(BuildContext context) {
    if (widget.emptySearchBuilder != null) {
      return widget.emptySearchBuilder!(context);
    }

    return Center(
      child: Text(CountryLocalizations.of(context)?.translate('no_country') ??
          'No country found'),
    );
  }

  void _filterElements(String s) {
    s = s.toUpperCase();
    setState(() {
      filteredElements = elements
          .where((e) =>
              e.code!.contains(s) ||
              e.dialCode!.contains(s) ||
              e.name!.toUpperCase().contains(s))
          .toList();
    });
  }

  void _selectItem(CountryCode e) {
    widget.onSelect(e);
  }
}

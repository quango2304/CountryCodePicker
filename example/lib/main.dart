import 'package:country_code_picker/country_code.dart';
import 'package:country_code_picker/country_localizations.dart';
import 'package:country_code_picker/selection_dialog.dart';
import 'package:cupertino_rounded_corners/cupertino_rounded_corners.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      supportedLocales: [
        Locale("af"),
        Locale("am"),
        Locale("ar"),
        Locale("az"),
        Locale("be"),
        Locale("bg"),
        Locale("bn"),
        Locale("bs"),
        Locale("ca"),
        Locale("cs"),
        Locale("da"),
        Locale("de"),
        Locale("el"),
        Locale("en"),
        Locale("es"),
        Locale("et"),
        Locale("fa"),
        Locale("fi"),
        Locale("fr"),
        Locale("gl"),
        Locale("ha"),
        Locale("he"),
        Locale("hi"),
        Locale("hr"),
        Locale("hu"),
        Locale("hy"),
        Locale("id"),
        Locale("is"),
        Locale("it"),
        Locale("ja"),
        Locale("ka"),
        Locale("kk"),
        Locale("km"),
        Locale("ko"),
        Locale("ku"),
        Locale("ky"),
        Locale("lt"),
        Locale("lv"),
        Locale("mk"),
        Locale("ml"),
        Locale("mn"),
        Locale("ms"),
        Locale("nb"),
        Locale("nl"),
        Locale("nn"),
        Locale("no"),
        Locale("pl"),
        Locale("ps"),
        Locale("pt"),
        Locale("ro"),
        Locale("ru"),
        Locale("sd"),
        Locale("sk"),
        Locale("sl"),
        Locale("so"),
        Locale("sq"),
        Locale("sr"),
        Locale("sv"),
        Locale("ta"),
        Locale("tg"),
        Locale("th"),
        Locale("tk"),
        Locale("tr"),
        Locale("tt"),
        Locale("uk"),
        Locale("ug"),
        Locale("ur"),
        Locale("uz"),
        Locale("vi"),
        Locale("zh")
      ],
      localizationsDelegates: [
        CountryLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final _searchBoxBorder = OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(16.0),
        ),
        borderSide: BorderSide(color: Colors.transparent));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: SelectionDialog(
          onSelect: (countryCode) {},
          searchPadding: EdgeInsets.only(left: 24, right: 24, top: 10, bottom: 10),
          backgroundColor: Color(0xffF8F8F8),
          searchDecoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 12, right: 12, top: 2),
            border: _searchBoxBorder,
            focusedBorder: _searchBoxBorder,
            enabledBorder: _searchBoxBorder,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            filled: true,
            fillColor: Colors.grey.withOpacity(0.1),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 10, right: 8),
              child: Icon(
                Icons.search,
              ),
            ),
            prefixIconConstraints: BoxConstraints(),
            suffixIconConstraints: BoxConstraints(),
            hintText: "Search",
            hintStyle: TextStyle(color: Colors.grey),
          ),
          itemBuilder: (country) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
              child: Material(
                shape: SquircleBorder(
                  radius: BorderRadius.all(
                    Radius.circular(40.0),
                  ),
                ),
                color: Colors.white,
                elevation: 0,
                child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                  child: Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(right: 16.0),
                        child: Material(
                          clipBehavior: Clip.antiAlias,
                          shape: SquircleBorder(
                            radius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                          child: Image.asset(
                            country.flagUri,
                            package: 'country_code_picker',
                            width: 40,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          country.toCountryStringOnly(),
                        ),
                      ),
                      Text(
                        country.dialCode,
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

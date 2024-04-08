import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tut_application/presentation/resources/strings_manager.dart';
class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  @override
  _SearchPageState createState() => _SearchPageState();
}
class _SearchPageState extends State<SearchPage>
{
  @override
  Widget build(BuildContext context) {
  return Center(child: Text(AppStrings.search).tr(),);
  }
}

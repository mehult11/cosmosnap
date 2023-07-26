
import 'package:flutter/material.dart';
import 'package:nasa_apod/Constant/LabelConstant.dart';
import 'package:nasa_apod/Entity/NASAPicture.dart';
import 'package:nasa_apod/UI/Component/SingleImageWgt.dart';


class MyFavoriteImageDetailPage extends StatefulWidget {
  final NASAPicture nasaPicture;
  const MyFavoriteImageDetailPage({super.key, required this.nasaPicture});

  @override
  State<MyFavoriteImageDetailPage> createState() => _MyFavoriteImageDetailPageState();
}

class _MyFavoriteImageDetailPageState extends State<MyFavoriteImageDetailPage> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(LabelConstant.appBarLabel,style: TextStyle(fontWeight: FontWeight.bold),)),
        ),
        body: SingleImageWgt(
          nasaPicture: widget.nasaPicture,),
      ),
    );
  }
}

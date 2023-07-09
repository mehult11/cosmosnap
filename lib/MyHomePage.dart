import 'package:flutter/material.dart';
import 'package:nasa_apod/Constant/LabelConstant.dart';
import 'package:nasa_apod/Favorite/MyFavoriteImageListPage.dart';
import 'package:nasa_apod/NASAPicture.dart';
import 'package:nasa_apod/NASAPictureDataProvider.dart';
import 'package:nasa_apod/SingleImageWgt.dart';
import 'package:nasa_apod/Util.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  NASAPictureDataProvider nasaPictureDataProvider = NASAPictureDataProvider.instance;
  var currentDate = DateTime.now();
  TextEditingController searchDateController = TextEditingController();
  NASAPicture? nasaPicture;
  DateTime? selectedDate;
  @override
  void initState() {
    searchDateController.text = Util.getFormatedString(currentDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle,
            backgroundColor: Theme.of(context).colorScheme.secondary,        title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(LabelConstant.appBarLabel,style: TextStyle(fontWeight: FontWeight.bold),)),
                IconButton(onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>
                          MyFavoriteImageListPage()));
                }, icon: Icon(
                  Icons.favorite,
                  color: Colors.red.shade900,
                ))
              ],
            ),
          ),
          body: FutureBuilder(
            future: nasaPictureDataProvider.getImage(searchDateController.text),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator());
              }else if(snapshot.hasError){
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }else if(snapshot.hasData){
                nasaPicture = snapshot.data;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      getSearchPictureWidget(),
                      getPictureOfTheDayWidget(),
                    ],
                  ),
                );
              }else{
                return Container();
              }
            },
          )
      ),
    );
  }

  Widget getSearchPictureWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 130,
          child: TextField(
            controller: searchDateController,
            decoration: InputDecoration(
              icon: Icon(Icons.calendar_today),
            ),
            readOnly: true,
            onTap: () async {
              selectedDate = await showDatePicker(
                  context: context,
                  initialDate: (selectedDate != null)? selectedDate! : currentDate,
                  firstDate: DateTime(2000),
                  lastDate: currentDate);
              if (selectedDate != null) {
                String pickDateString = Util.getFormatedString(selectedDate!);
                if(pickDateString != searchDateController.text){
                  setState(() {
                    searchDateController.text = pickDateString;
                  });
                  nasaPictureDataProvider.getImage(searchDateController.text).then((NASAPicture value){
                  });
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Please select different date"),
                  ));
                }
              } else {}
            },
          ),
        ),
      ],
    );
  }

  Widget getPictureOfTheDayWidget() {
    return SingleImageWgt(
      nasaPicture: nasaPicture!,);
  }
}

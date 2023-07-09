
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nasa_apod/Constant/LabelConstant.dart';
import 'package:nasa_apod/Favorite/MyFavoriteImageDetailPage.dart';
import 'package:nasa_apod/NASAPictureDataProvider.dart';

class MyFavoriteImageListPage extends StatefulWidget {
  const MyFavoriteImageListPage({super.key});

  @override
  State<MyFavoriteImageListPage> createState() => _MyFavoriteImageListPageState();
}

class _MyFavoriteImageListPageState extends State<MyFavoriteImageListPage> {
  NASAPictureDataProvider dataProvider = NASAPictureDataProvider.instance;

  @override
  void initState() {
    dataProvider.setAllFavoritePictureIntoStream();
    super.initState();
  }

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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder< Map<String,dynamic>>(
              stream: dataProvider.getImagesFromDBStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  Map<String,dynamic>? dataMap = snapshot.data;
                  if (dataMap != null && dataMap.isNotEmpty) {
                    var imgList = dataMap.values;
                    return GridView.builder(
                      itemCount: imgList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: (MediaQuery.of(context).orientation == Orientation.portrait) ? 3 : 5,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (context,index){
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) =>
                                    MyFavoriteImageDetailPage(nasaPicture: imgList.elementAt(index))));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: CachedNetworkImage(
                              key: UniqueKey(),
                              imageUrl: imgList.elementAt(index).url,
                              fit: BoxFit.cover,
                              progressIndicatorBuilder: (context, url, downloadProgress) =>
                                  Center(
                                    child: CircularProgressIndicator(
                                        value: downloadProgress.progress,
                                    ),
                                  ),
                              errorWidget: (context,url,error) => Container(
                                color: Colors.black12,
                                child: Icon(Icons.error,color: Color(0xFF8C1D18)),
                              ),
                            ),
                          ),
                        );
                        });
                  } else {
                    return noDataMsg();
                  }
                } else {
                  return noDataMsg();
                }
              }),
        ),
      ),
    );
  }
  noDataMsg() => Center(
      child: Image.asset(
        "assets/images/nodata.png"
      )
  );
}

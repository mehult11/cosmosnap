import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:nasa_apod/Constant/KeyConst.dart';
import 'package:nasa_apod/Entity/NASAPicture.dart';
import 'package:nasa_apod/DataProvider/NASAPictureDataProvider.dart';
import 'package:nasa_apod/UI/Component/RenderVideo.dart';
import 'package:readmore/readmore.dart';
class SingleImageWgt extends StatefulWidget {
  final NASAPicture nasaPicture;
  const SingleImageWgt({super.key, required this.nasaPicture});

  @override
  State<SingleImageWgt> createState() => _SingleImageWgtState();
}

class _SingleImageWgtState extends State<SingleImageWgt> {
  NASAPictureDataProvider nasaPictureDataProvider = NASAPictureDataProvider.instance;
  @override
  void initState() {
    nasaPictureDataProvider.setIsFavoriteImageStream(widget.nasaPicture.date!.trim());
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              (widget.nasaPicture.mediaType != KeyConst.imageType)?
              ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: RenderVideo(url: widget.nasaPicture.url!)) :
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  key: UniqueKey(),
                  imageUrl: widget.nasaPicture.url!,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.5,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress,
                            color: Colors.green
                        ),
                      ),
                  errorWidget: (context,url,error) => Container(
                    color: Colors.black12,
                    child: Icon(Icons.error,color: Colors.red,size: 80,),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(0,4,0,4),
                child: Text(widget.nasaPicture.title!,style: TextStyle(
                    color: Theme.of(context).textTheme.labelLarge!.color! ,
                    fontSize: 20,fontWeight: FontWeight.bold),
                  overflow: TextOverflow.visible,
                  softWrap: true,
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,4,0,4),
                    child: Text(widget.nasaPicture.date!,style: TextStyle(fontSize: 18),),
                  ),
                  StreamBuilder<bool>(
                      stream: nasaPictureDataProvider.getIsFavoriteStream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasData) {
                          bool? isImgFavorite = snapshot.data;
                          if (isImgFavorite != null) {
                            return IconButton(onPressed: () async{
                              if(isImgFavorite){
                                nasaPictureDataProvider.removeFavoriteImage(widget.nasaPicture.date!);
                              }else{
                                nasaPictureDataProvider.addFavoriteImage(widget.nasaPicture);
                              }
                              /*setState(() {
                                nasaPictureDataProvider.setIsFavoriteImage(!isImgFavorite);
                              });*/
                              nasaPictureDataProvider.setIsFavoriteImage(!isImgFavorite);
                              /*
                              setState(() {
                                isImgFavorite = !isImgFavorite!;
                              });*/

                            }, icon: Icon(
                                color: Colors.red.shade900,
                                (isImgFavorite) ? Icons.favorite : Icons.favorite_border_outlined
                            )
                            );
                          } else {
                            return Container();
                          }
                        } else {
                          return Container();
                        }
                      }),
                /*  IconButton(onPressed: () async{
                    if(isSelected){
                      nasaPictureDataProvider.removeFavoriteImage(widget.nasaPicture.date!);
                    }else{
                      nasaPictureDataProvider.addFavoriteImage(widget.nasaPicture);
                    }
                    setState(() {
                      isSelected = !isSelected;
                    });
                  }, icon: Icon(
                      color: Colors.red.shade900,
                      (isSelected) ? Icons.favorite : Icons.favorite_border_outlined
                  )
                  )*/
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,4,0,4),
                child: ReadMoreText(
                  widget.nasaPicture.explanation!,
                  trimLines: 2,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 16),
                  moreStyle: TextStyle(color: Theme.of(context).textTheme.bodySmall!.color!),
                  lessStyle: TextStyle(color: Theme.of(context).textTheme.bodySmall!.color!),
                  trimMode: TrimMode.Line,
                  trimCollapsedText: '...Show more',
                  trimExpandedText: ' show less',
               ),
              ),
            ],
          ),
        ),
      );
  }
}

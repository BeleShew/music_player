import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/screen/album_details_page.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../controller/album_controller.dart';

class AlbumPage extends StatelessWidget {
  AlbumPage({super.key}){
    Get.put(AlbumController());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AlbumController>(
        builder: (controller) {
          return
            SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child:  controller.albums.isNotEmpty?
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.albums.length,
                  itemBuilder: (context,index){
                    return ListTile(
                      leading: QueryArtworkWidget(
                      type: ArtworkType.ALBUM,
                      id: controller.albums[index].id,
                      nullArtworkWidget: const Icon(Icons.music_note_sharp),
                    ),
                      title:Text(controller.albums[index].album,style:const TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Text(controller.albums[index].artist??"",style:const TextStyle(fontWeight: FontWeight.normal),),
                      trailing:const Icon(Icons.arrow_forward_ios_rounded,size: 14,),
                      onTap: (){
                        Get.to(()=>AlbumDetailsPage(selectedAlbum:controller.albums[index]));
                      },
                );
              }):Center(
                child: CircularProgressIndicator(
                  // color: Colors.green.shade200,
                  valueColor:AlwaysStoppedAnimation<Color>(Colors.red.shade300),
                  backgroundColor: Colors.yellow.shade200,
                  strokeWidth:2,
                ),
              ),
            ),
          );
        }
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/controller/artist_controller.dart';
import 'package:music_player/screen/artist_details_page.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ArtistPage extends StatelessWidget {
  ArtistPage({super.key}){
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ArtistController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: controller.artistList.isNotEmpty?
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.artistList.length,
                  itemBuilder: (context,index){
                    return ListTile(
                      leading: QueryArtworkWidget(
                        type: ArtworkType.ARTIST,
                        id: controller.artistList[index].id,
                        nullArtworkWidget: const Icon(Icons.music_note_sharp),
                      ),
                      title: Text(controller.artistList[index].artist,style: const TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: IntrinsicHeight(
                        child:  Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text("${controller.artistList[index].numberOfTracks}"),
                            const SizedBox(width: 5,),
                            (controller.artistList[index].numberOfTracks??0)>1?const Text("Songs"):const Text("Song"),
                          ],
                        ),
                      ),
                      trailing:const Icon(Icons.arrow_forward_ios_rounded,size: 14,),
                      onTap: (){
                        Get.to(()=>ArtistDetailsPage(selectedArtist: controller.artistList[index]));
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

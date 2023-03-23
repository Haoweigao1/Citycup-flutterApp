import 'package:flutter/material.dart';
import 'package:meta_transaction/widgets/animation/press_animation.dart';
import '../../config/application.dart';



///历史记录item
class HistoryItem extends StatelessWidget{

  final String url;
  final String summary;


  const HistoryItem({super.key, required this.url, required this.summary});

  @override
  Widget build(BuildContext context) {

    return AnimatedPress(
        child: GestureDetector(
          onTap: (){
            //跳转到webview;
            Application.navigateTo(context, "webView" ,params: {
              "title": summary,
              "url": url
            });
          },
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0, bottom: 20.0),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text(summary, style: const TextStyle(fontSize: 16),),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Text(url, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  )

                ],
              ),
            ),

          )
        )
    );

  }



}

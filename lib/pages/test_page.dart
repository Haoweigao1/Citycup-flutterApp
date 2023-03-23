import 'package:flutter/material.dart';
import 'package:meta_transaction/entity/comment_entity.dart';
import 'package:meta_transaction/entity/reply_entity.dart';
import 'package:meta_transaction/widgets/picture_show/picture_show.dart';
import 'package:meta_transaction/widgets/post_page_widget/comment_item.dart';

import '../widgets/goods_widget/goods_item.dart';

///用于测试
class TestPage extends StatefulWidget{

  const TestPage({super.key});

  @override
  State<StatefulWidget> createState() => _TestPageState();

}


class _TestPageState extends State<TestPage>{

  List<String> list = ['Java', 'Flutter', 'Kotlin', 'Swift', 'Objective-C'],
      selected = [];
  late TextEditingController tc;

  List<String> imageList = [
    'http://img1.mukewang.com/5c18cf540001ac8206000338.jpg',
    'http://img1.mukewang.com/5c18cf540001ac8206000338.jpg',
    'http://img1.mukewang.com/5c18cf540001ac8206000338.jpg',
    'http://img1.mukewang.com/5c18cf540001ac8206000338.jpg',
    'http://img1.mukewang.com/5c18cf540001ac8206000338.jpg',
    'http://img1.mukewang.com/5c18cf540001ac8206000338.jpg',
  ];
  @override
  void initState() {
    super.initState();
    tc = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Tags'),
        backgroundColor: Colors.green[800],
      ),
      body: Column(
//         mainAxisSize:MainAxisSize.min,
          children: [

            const Padding(
                padding: EdgeInsets.all(20),
                child: GoodsItem(url: 'http://img1.mukewang.com/5c18cf540001ac8206000338.jpg',title:"这是标题哈哈哈哈", price: 9.9),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                  controller: tc,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      prefixIcon: selected.isEmpty ? null
                          : Padding(
                        padding: const EdgeInsets.only(left:10, right:10),
                        child: Wrap(
                            spacing: 5,
                            runSpacing: 5,
                            children: selected.map((s) {
                              return Chip(
                                  backgroundColor: Colors.blue[100],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  label: Text(s,
                                      style:
                                      TextStyle(color: Colors.blue[900])),
                                  onDeleted: () {
                                    setState(() {
                                      selected.remove(s);
                                    });
                                  });
                            }).toList()),
                      ))),
            ),
            const SizedBox(height: 20),
            ListView.builder(
                shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: (c, i) {
                  return list[i].toLowerCase().contains(tc.text.toLowerCase()) ? ListTile(
                      title: Text(list[i],
                          style: TextStyle(color: Colors.blue[900])),
                      onTap: () {
                        setState(() {
                          if (!selected.contains(list[i])) {
                            selected.add(list[i]);
                          }
                        });
                      })
                      : Container();
                }),

          ]),
    );
  }

}
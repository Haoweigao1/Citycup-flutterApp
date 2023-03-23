import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http_parser/http_parser.dart';
import 'package:meta_transaction/service/post_service.dart';
import 'package:meta_transaction/util/common_toast.dart';
import 'package:meta_transaction/widgets/animation/press_animation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import '../../theme/app_theme.dart';
import 'package:bruno/bruno.dart';
import 'dart:io';
import 'dart:async';


///上传帖子页面
class UploadPostPage extends StatelessWidget{

  const UploadPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    //屏幕自适应 设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕
    ScreenUtil.init(
      context,
      designSize: const Size(AppTheme.wdp, AppTheme.hdp),
    );
     return const  UploadPostBody();
  }

}

class UploadPostBody extends StatefulWidget{
  const UploadPostBody({super.key});

  @override
  State<StatefulWidget> createState() => _UploadPostBodyState();

}

class _UploadPostBodyState extends State<UploadPostBody>{


  late TextEditingController _titleController;
  late TextEditingController _contentController;

  ///维护用户选择的标签集合
  late List<String> _tagList;

  List<XFile?> mFileList =[];
  XFile? mSelectedImageFile;
  List<MultipartFile> mSubmitFileList =[];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _contentController = TextEditingController();
    _tagList = [];
  }

  @override
  Widget build(BuildContext context) {
    Color themeColor = isDarkMode(context)? Theme.of(context).primaryColor.withAlpha(155)
        : Theme.of(context).primaryColor;
    int mGridCount;
    if (mFileList.isEmpty) {
      mGridCount = 1;
    } else if (mFileList.isNotEmpty && mFileList.length < 9) {
      mGridCount = mFileList.length + 1;
    } else {
      mGridCount = mFileList.length;
    }

     return Scaffold(
        appBar: AppBar(
          backgroundColor: isDarkMode(context)
              ? Theme.of(context).primaryColor.withAlpha(155)
              : Theme.of(context).primaryColor,
          title:const Text("发布话题"),
          centerTitle: true,
        ),
        resizeToAvoidBottomInset: false,
        floatingActionButton: SizedBox(
          width: 150.w,
          height: 40.w,
          child: AnimatedPress(
            child:OutlinedButton(
              onPressed: () async {
                  ///上传帖子
                  //debugPrint("触发上传帖子事件");
                  if(_contentController.text == ""){
                    CommonToast.showToast("内容不能为空！");
                    return;
                  }
                  ///获取需要上传的文件内容
                  mSubmitFileList.clear();
                  for (int i = 0; i < mFileList.length; i++) {
                    ///获取文件的类型
                    String? mimeType = lookupMimeType(mFileList.elementAt(i)?.path??"");
                    mSubmitFileList.add(
                        MultipartFile.fromFileSync(mFileList.elementAt(i)?.path??"" ,
                        contentType: MediaType("image", mimeType?.split("/")[1] ?? "jpg")));
                  }
                  ///将标签与标题拼接
                  Iterator<String> iterator = _tagList.iterator;
                  String title = _titleController.text;
                  while(iterator.moveNext()){
                      ///分隔符号为“#&”
                      String wrap = "#&${iterator.current}";
                      title += wrap;
                  }
                  _tagList.clear();
                  ///将帖子所有数据上传
                  bool res = await PostService.uploadPost(title, _contentController.text, mSubmitFileList);
                  debugPrint(res.toString());
                  if(res){
                    _tagList.clear();
                    mSubmitFileList.clear();
                    _contentController.clear();
                    _titleController.clear();
                    sleep(const Duration(seconds: 1));
                    if(mounted) { Navigator.pop(context); }
                  }
                },
              style: ButtonStyle(
                  side: MaterialStateProperty.all(BorderSide(color: themeColor)),
                  minimumSize: MaterialStateProperty.all(Size(150.w, 40.w)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.w)))
              ),
              child: Text("发布话题" ,style: TextStyle(color: themeColor, fontSize: 14.sp, fontWeight: FontWeight.w500),),
            ),
          ),
        ),

         floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
         body: CustomScrollView(
            slivers: [
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                  (context, index) {
                     return Padding(
                         padding: EdgeInsets.only(bottom: 48.h,left: 15.w,right: 15.w),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                               SizedBox(
                                 height: 16.h,
                               ),
                               ///添加图片或视频(使用宫格形式)
                             GridView.count(
                               shrinkWrap: true,
                               primary: false,
                               crossAxisCount: 3,
                               children: List.generate(mGridCount, (index) {
                                 /// 这个方法体用于生成GridView中的一个item
                                 Widget content;
                                 if (index == mFileList.length) {
                                   /// 添加图片按钮
                                   var addCell = Center(
                                       child: Image.asset(
                                         'assets/images/mine_feedback_add_image.png',
                                         width: double.infinity,
                                         height: double.infinity,
                                       ));
                                   content = GestureDetector(
                                     onTap: () {
                                       final ImagePicker picker = ImagePicker();
                                       final Future<XFile?> image =  picker.pickImage(source: ImageSource.gallery);
                                       image.then((result) {
                                         setState(() {
                                           if(result != null) {
                                             mSelectedImageFile = result;
                                             mFileList.add(result);
                                           }
                                         });
                                       });
                                     },
                                     child: addCell,
                                   );
                                 } else {
                                   /// 被选中的图片
                                   content = Stack(
                                     children: <Widget>[
                                       Center(
                                         child: Image.file(
                                           File(mFileList[index]?.path??"")  ,
                                           width: double.infinity,
                                           height: double.infinity,
                                           fit: BoxFit.cover,
                                         ),
                                       ),
                                       Align(
                                         alignment: Alignment.topRight,
                                         child: InkWell(
                                           onTap: () {
                                             mFileList.removeAt(index);
                                             mSelectedImageFile = null;
                                             setState(() {});
                                           },
                                           child: Image.asset(
                                            'assets/images/mine_feedback_ic_del.png',
                                             width: 20.0,
                                             height: 20.0,
                                           ),
                                         ),
                                       )
                                     ],
                                   );
                                 }
                                 return Container(
                                   margin: EdgeInsets.all(2.w),
                                   width: 120.w,
                                   height: 120.w,
                                   color: const Color(0xFFffffff),
                                   child: content,
                                 );
                               }),
                             ),
                               SizedBox(
                                 height: 12.h,
                               ),
                               TextField(
                                 controller: _titleController,
                                 textAlign: TextAlign.start,
                                 style: TextStyle(fontSize: 16.sp ,fontWeight: FontWeight.bold),
                                 decoration: InputDecoration(
                                   hintText: "请输入标题",
                                   hintStyle: TextStyle(color: Colors.grey,fontSize: 16.sp),
                                   prefixIcon: const Icon(Icons.title),
                                 ),
                               ),
                               SizedBox(
                                 height: 10.h,
                               ),
                               // TextField(
                               //   controller: _contentController,
                               //   style: TextStyle(fontSize: 14.sp),
                               //   decoration: InputDecoration(
                               //     hintText: "说点什么吧~",
                               //     hintStyle: TextStyle(color: Colors.grey,fontSize: 14.sp),
                               //   ),
                               //   minLines: 5,
                               //   maxLines: 100,
                               // ),
                              BrnInputText(
                                 maxHeight: 200.w,
                                 minHeight: 100.w,
                                 minLines: 1,
                                 autoFocus: false,
                                 maxLength: 800,
                                 borderRadius: 20.w,
                                 textEditingController: _contentController,
                                 textInputAction: TextInputAction.newline,
                                 maxHintLines: 20,
                                 hint: '说点什么吧~',
                                 padding: EdgeInsets.all(10.w),
                                 onTextChange: (text) {
                                 },
                                 onSubmit: (text) {
                                 },
                               ),

                               SizedBox(
                                 height: 16.h,
                               ),
                               ///添加帖子标签

                               AnimatedPress(
                                     child:  ElevatedButton(
                                         //从下方弹出选项卡
                                         onPressed: (){
                                           _showMulSelectTagPicker(context);
                                         },
                                         style: ButtonStyle(
                                             backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                                             minimumSize: MaterialStateProperty.all(Size(60.w, 30.w)),
                                             shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                                 borderRadius: BorderRadius.circular(15.w)))
                                         ),
                                         child: Text("添加标签" ,style: TextStyle(fontSize: 12.sp, color: Colors.white),)
                                     ),
                                   ),
                               _tagList.isEmpty ? SizedBox(width: 0.w,)
                                       :Wrap(
                                           spacing: 5.w,
                                           runSpacing: 5.w,
                                           children: _tagList.map((s) {
                                             return Chip(
                                                 backgroundColor: Colors.redAccent,
                                                 shape: RoundedRectangleBorder(
                                                   ///设置碎片的圆角
                                                   borderRadius: BorderRadius.circular(15.w),
                                                 ),
                                                 label: Text(s, style: TextStyle(fontSize: 12.sp, color: Colors.white)),
                                                 onDeleted: () {
                                                   setState(() {
                                                     _tagList.remove(s);
                                                   });
                                                 });
                                           }).toList()
                                       ),

                           ],
                         ),

                     );

                  },
                  childCount: 1
                  ),
              )

            ],
           )

        );

  }

  ///标签选择弹框
  void _showMulSelectTagPicker(BuildContext context) {
    Color themeColor = isDarkMode(context)? Theme.of(context).primaryColor.withAlpha(155)
        : Theme.of(context).primaryColor;
    ///标签列表
    List tags = [
      "nft",
      "元宇宙",
      "版权保护",
      "版权交易",
      "区块链",
      "数字作品",
    ];

    List<BrnTagItemBean> items = [];
    for (int i = 0; i < tags.length ;i++){
      String it = tags[i];
      BrnTagItemBean item = BrnTagItemBean(name: it,code: it,index: i, isSelect: _tagList.contains(it));
      items.add(item);
    }

    BrnMultiSelectTagsPicker(
      context: context,
      //排列样式 默认 平均分配排序
      layoutStyle: BrnMultiSelectTagsLayoutStyle.average,
      //一行多少个 默认3个
      crossAxisCount: 3,
      //最大选中数目 - 不设置 或者设置为0 则可以全选
      maxSelectItemCount: 3,
      onItemClick: (BrnTagItemBean onTapTag, bool isSelect) {
        ///如果被选择,加入集合
        if(isSelect && !_tagList.contains(onTapTag.name)){
          setState(() {
            _tagList.add(onTapTag.name);
          });
        }
        if(!isSelect && _tagList.contains(onTapTag.name)){
          setState(() {
            _tagList.remove(onTapTag.name);
          });
        }

      },
      onMaxSelectClick: () {
        CommonToast.showToast("最大标签数量不能超过3个!");
      },
      pickerTitleConfig: const BrnPickerTitleConfig(
        titleContent: '标签选择',
      ),
      tagPickerConfig: BrnTagsPickerConfig(
        tagItemSource: items,
        tagTitleFontSize: 12.sp,
        chipPadding: const EdgeInsets.only(left: 5, right: 5),
        tagTitleColor: const Color(0xFF666666),
        tagBackgroudColor: const Color(0xffF8F8F8),
        selectedTagBackgroudColor: const Color(0x140984F9),
        selectedTagTitleColor: themeColor,
      ),

      onConfirm: (value) {
        //BrnToast.show(value.toString(), context);
      },
      onCancel: () {},
      onTagValueGetter: (choice) {
        return choice.name;
      },
    ).show();
  }


}



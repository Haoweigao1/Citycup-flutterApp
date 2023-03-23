



import 'package:meta_transaction/entity/reply_entity.dart';

class CommentEntity{

  String cid = "";  //评论的id
  String uid = "";  //评论者id
  String? nickname;
  String content = "";
  String avatar = "";  //头像
  DateTime ?time;  //初始时间
  int favoriteNum = 0;  //点赞数量
  List<ReplyEntity> replyList = [];


}
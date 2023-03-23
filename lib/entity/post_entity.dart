


///帖子内容实体类
class PostEntity {

  String? pid;  //id
  String title = ""; //标题
  String  content = "";
  String images = ""; //图片地址
  String creatorId = "";
  String creatorAvatar = "";
  String creatorName = "";  //发布者的昵称
  DateTime? time;  //
  int favoriteNum = 0;
  int hot = 0;
  int commentNum = 0;
  int status = 0;


}
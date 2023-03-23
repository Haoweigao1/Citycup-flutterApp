
class API{
  static const String BASE_URL = "http://114.132.75.216:9999/";   //API基URL
  static const int pageSize = 10;
  // static const String POSTDATA_FILE = "$BASE_URL/files/postData";  //访问帖子图片（后接图片名）
  // static const String AVATAR_FILE = "$BASE_URL/files/avatars"; //访问用户头像

  ///用户部分基本接口
  static const String LOGIN = "${BASE_URL}users/login";
  static const String LOGOUT = "${BASE_URL}users/logout";
  static const String REGISTER = "${BASE_URL}users/register";
  static const String GET_INFO = "${BASE_URL}users/get_my_info";
  static const String SEND_CODE = "${BASE_URL}users/send_code";  //发送邮箱验证码
  static const String MODIFY_PWD = "${BASE_URL}users/modify_password";
  static const String MODIFY_INFO = "${BASE_URL}users/modify_information";
  static const String UPLOAD_AVATAR = "${BASE_URL}users/upload_avatar";


  ///资讯部分接口
  static const String GET_BANNER_LIST = "${BASE_URL}news/get_banner_list";
  static const String GET_NEWS_LIST = "${BASE_URL}news/get_news_list";

  ///社区部分接口
  static const String UPLOAD_POST = "${BASE_URL}post/upload_post";
  static const String DEL_POST = "${BASE_URL}post/delete_post";
  static const String DO_FAVORITE = "${BASE_URL}post/do_favorite";
  static const String CANCEL_FAVORITE = "${BASE_URL}post/cancel_favorite";
  static const String DO_COMMENT = "${BASE_URL}post/do_comment";
  static const String DEL_COMMENT = "${BASE_URL}post/delete_comment";
  static const String DO_REPLY = "${BASE_URL}post/do_reply";
  static const String DEL_REPLY = "${BASE_URL}post/delete_reply";
  static const String MODIFY_HOT = "${BASE_URL}post/modify_hot";
  static const String IS_FAVORITE = "${BASE_URL}post/is_favorite";
  static const String GET_COMMENT_LIST = "${BASE_URL}post/getCommentList";
  static const String GET_POST_BY_TIME = "${BASE_URL}post/getPostListByTime";
  static const String GET_POST_BY_HOT = "${BASE_URL}post/getPostListByHot";
  static const String GET_POST_BY_FAVORITE = "${BASE_URL}post/getPostListByFavorite";
  static const String GET_MY_POST_LIST = "${BASE_URL}post/getPostListById";
  static const String GET_POST_BY_KEY = "${BASE_URL}post/getPostListByKey";

  ///版权相关接口
  static const String UPLOAD_DETECT_EVENT = "${BASE_URL}detect/upload_detect";
  static const String UPLOAD_DEGITAL_TEMP = "${BASE_URL}digitalWorks/upload_digital_temp";
  static const String GET_DEGITAL_TEMP_LIST = "${BASE_URL}digitalWorks/get_my_temp_list";
  static const String GET_DETECT_LIST = "${BASE_URL}detect/get_my_list";


}
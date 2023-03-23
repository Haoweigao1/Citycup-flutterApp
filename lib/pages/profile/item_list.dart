

import 'package:flutter/material.dart';
import 'package:meta_transaction/config/application.dart';
import 'package:meta_transaction/util/common_toast.dart';
import 'package:remixicon/remixicon.dart';

import '../../widgets/ItemCell.dart';


///将个人中心页面子项定义于此，避免个人中心页面代码过于冗长


class ItemList {
  BuildContext context;

  ItemList(this.context);
  List<Widget> _orderList = [];
  List<Widget> _copyrightList = [];
  List<Widget> _otherList = [];



  void init(){
   _orderList = [
      ItemCell(
        iconData: Remix.shopping_bag_2_line,
        title:'全部订单',
        onClick: (){ CommonToast.showToast("功能开发中😭!");  },
        count: 0,),
      ItemCell(
          iconData: Remix.money_cny_circle_line,
          title: '待付款',
          onClick:  (){ CommonToast.showToast("功能开发中😭!"); },
          count: 0),
      ItemCell(
          iconData: Icons.shopping_cart_outlined,
          title: '购物车',
          onClick:  (){CommonToast.showToast("功能开发中😭!");  },
          count: 0),
      ItemCell(
          iconData: Icons.access_time,
          title: '待评价',
          onClick: (){CommonToast.showToast("功能开发中😭!");  },
          count: 0),
      ];


      _copyrightList = [
      ItemCell(
          iconData: Remix.file_edit_line,
          title: '版权登记',
          onClick:  (){
            Application.navigateTo(context, "copyrightRegister");
          },
          count: 0),
      ItemCell(
          iconData: Remix.file_search_line,
          title: '侵权检测',
          onClick:  (){
            Application.navigateTo(context, "copyrightDetect");
          },
          count: 0 ),

      ItemCell(
          iconData: Remix.phone_line,
          title: '维权通道',
          onClick:  (){
            Application.navigateTo(context, "copyrightProtect");
          },
          count:  0),
    ];



    _otherList = [
      ItemCell(
          iconData: Icons.remove_red_eye_outlined,
          title: '浏览历史',
          onClick:  (){
            Application.navigateTo(context, "newsHistory");
          },
          count: 0),
      ItemCell(
          //iconData: Remix.message_3_line,
          iconData: Remix.hashtag,
          title: '我的话题',
          onClick:  (){
            Application.navigateTo(context, "postManage");
          },
          count: 0 ),
      ItemCell(
          iconData: Remix.gift_2_line,
          title: '藏品赠送',
          onClick:  (){  Application.navigateTo(context, "digitalWorkDonate"); },
          count:  0),
      ItemCell(
          iconData: Remix.heart_2_line,
          title: '我的关注',
          onClick:  (){ Application.navigateTo(context, "myFollow"); },
          count: 0),

      ItemCell(
          iconData: Remix.customer_service_2_line,
          title: '联系我们',
          onClick:  (){Application.navigateTo(context, "callUs");},
          count: 0 ),
      ItemCell(
          iconData: Remix.database_2_line,
          title: '积分兑换',
          onClick:  (){ CommonToast.showToast("敬请期待!");  },
          count:  0),

      ItemCell(
          iconData: Remix.message_3_line,
          title: "我的消息",
          onClick: (){Application.navigateTo(context, "myMessage"); },
          count: 0
      ),

    ];
  }

  List<Widget> get orderList => _orderList;

  set orderList(List<Widget> value) {
    _orderList = value;
  }

  List<Widget> get copyrightList => _copyrightList;

  set copyrightList(List<Widget> value) {
    _copyrightList = value;
  }

  List<Widget> get otherList => _otherList;

  set otherList(List<Widget> value) {
    _otherList = value;
  }

}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_transaction/index.dart';
import 'package:meta_transaction/theme/app_theme.dart';
import 'package:meta_transaction/widgets/will_pop_scope_route/will_pop_scope_route.dart';
import 'package:provider/provider.dart';

import 'config/application.dart';
import 'config/routers.dart';
import 'constant/constant.dart';
import 'db/sharedPreference_db.dart';
import 'model/application/applicationViewModel.dart';


void main() async{
  await ScreenUtil.ensureScreenSize();
  ///初始化路由
  Routers.configureRoutes(Application.router);
  /// 强制竖屏
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runApp(const MainAPP());
}


class MainAPP extends StatelessWidget{

  const MainAPP({super.key});

  @override
  Widget build(BuildContext context) {
      return MultiProvider(
        /// 状态管理
        providers: [
          ChangeNotifierProvider(create: (_) => ApplicationViewModel()),
        ],
        builder: (context, child) {
          final watchApplicationViewModel = context.watch<ApplicationViewModel>();

          return MaterialApp(
            /// 网格
            debugShowMaterialGrid: false,
            /// Debug标志
            debugShowCheckedModeBanner: false,
            /// 打开性能监控，覆盖在屏幕最上面
            showPerformanceOverlay: false,
            /// 语义视图（无障碍）
            showSemanticsDebugger: false,
            /// 主题
            themeMode: watchApplicationViewModel.themeMode,
            theme: AppTheme(getMultipleThemesMode(context)).multipleThemesLightMode(),
            darkTheme: AppTheme(getMultipleThemesMode(context)).multipleThemesDarkMode(),

            /// 路由钩子
            onGenerateRoute: Application.router.generator,

            title: Constant.APP_NAME,

            /// Home
            home: const WillPopScopeRoute(child: Init()),
          );
        },
      );
  }

}

class Init extends StatefulWidget {
  const Init({Key? key}) : super(key: key);

  @override
  State<Init> createState() => _InitState();
}

class _InitState extends State<Init> with WidgetsBindingObserver {
  /// 应用初始化
  void init() async {
    ApplicationViewModel applicationViewModel =
    Provider.of<ApplicationViewModel>(context, listen: false);
    /// 触发获取APP主题深色模式
    PreferencesDB().getAppThemeDarkMode(applicationViewModel);

    /// 触发获取APP多主题模式
    PreferencesDB().getMultipleThemesMode(applicationViewModel);

    /// 初始化用户登录状态
    PreferencesDB().getUserToken().then((value) =>
        value == 'default'? applicationViewModel.setLoginState(false) :
            applicationViewModel.setLoginState(true)
    );

  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        debugPrint("app 恢复");
        break;
      case AppLifecycleState.inactive:
        debugPrint("app 闲置");
        break;
      case AppLifecycleState.paused:
        debugPrint("app 暂停");
        break;
      case AppLifecycleState.detached:
        debugPrint("app 退出");
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    init();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Tabs();
  }
}





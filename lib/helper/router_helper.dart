import 'package:fluro/fluro.dart';
import 'package:gluecose_monitor/utill/routes.dart';
import 'package:gluecose_monitor/view/screens/auth/login_screen.dart';
import 'package:gluecose_monitor/view/screens/auth/register_screen.dart';
import 'package:gluecose_monitor/view/screens/glucose/analize_screen.dart';
import 'package:gluecose_monitor/view/screens/glucose/history_screen.dart';
import 'package:gluecose_monitor/view/screens/glucose/input_glucose_screen.dart';
import 'package:gluecose_monitor/view/screens/glucose/update_glucose_screen.dart';
import 'package:gluecose_monitor/view/screens/home/home_screen.dart';
import 'package:gluecose_monitor/view/screens/profile/create_profile_screen.dart';
import 'package:gluecose_monitor/view/screens/profile/profile_screen.dart';

class RouterHelper {
  static final FluroRouter router = FluroRouter();

  static Handler _registerHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) => RegisterScreen());
  static Handler _createProfileHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) =>
          CreateProfileScreen());
  static Handler _loginHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) => LoginScreen());
  static Handler _homeHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) => HomeScreen());
  static Handler _profileHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) => ProfileScreen());
  static Handler _inputGlucoseHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) =>
          InputGlucoseScreen());
  static Handler _historyHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) => HistoryScreen(
            date: '',
          ));
  static Handler _updateGlucoseHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) =>
          UpdateGlucoseScreen(
            gluecoseModel: null,
          ));
  static Handler _analizeHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) => AnalizeScreen(
            gluecoseId: null,
          ));

  static void setupRouter() {
    router.define(Routes.REGISTER_SCREEN,
        handler: _registerHandler, transitionType: TransitionType.inFromRight);
    router.define(Routes.CREATE_PROFILE_SCREEN,
        handler: _createProfileHandler,
        transitionType: TransitionType.inFromRight);
    router.define(Routes.LOGIN_SCREEN,
        handler: _loginHandler, transitionType: TransitionType.inFromRight);
    router.define(Routes.HOME_SCREEN,
        handler: _homeHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.PROFILE_SCREEN,
        handler: _profileHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.INPUT_GLUCOSE_SCREEN,
        handler: _inputGlucoseHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.HISTORY_SCREEN,
        handler: _historyHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.UPDATE_GLUCOSE_SCREEN,
        handler: _updateGlucoseHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.ANALIZE_SCREEN,
        handler: _analizeHandler, transitionType: TransitionType.fadeIn);
  }
}

abstract class AppStates {}

class InitialState extends AppStates {}
class SplashscreenLoading extends AppStates {}
class LogInInitialState extends AppStates{}

class LogInSuccessState extends AppStates{}

class LogInErrorState extends AppStates{}

class getProfileInitialState extends AppStates{}
class getProfileSuccessState extends AppStates{}
class getProfileErrorState extends AppStates{}
class getFirstModeState extends AppStates {}
class UploadProfileImageLoadingState extends AppStates{}

class UploadProfileImageSuccessState extends AppStates{}

class UploadProfileImageErrorState extends AppStates
{
  final String error;
  UploadProfileImageErrorState(this.error);
}



class ChangeAppLanguageState extends AppStates {}
class ChangeAppLanguageSuccessState extends AppStates {}
class GetNotificationSuccessState extends AppStates{}

class ChangeOptionState extends AppStates{}
class ThemeChangedState extends AppStates {}
class ChangeLanguageContainerStatusState extends AppStates {}
class PrimaryColorIndexState extends AppStates {}
class ChangeThemeContainerStatusState extends AppStates {}
class changeItemState extends AppStates{}

class GetNotificationErrorState extends AppStates{}
class GetOrdersErrorState extends AppStates{
  final String msg;

  GetOrdersErrorState({required this.msg});
}
class GetOrdersLoadingState extends AppStates{}
class GetOrdersSucessState extends AppStates{}
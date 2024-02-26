
abstract class SocialLoginStates{}

class SocialLoginInitialStates extends SocialLoginStates{}

class SocialLoginLoadingStates extends SocialLoginStates{}

class SocialLoginSuccessStates extends SocialLoginStates{
  final String uId;
  SocialLoginSuccessStates({required this.uId});
}

class SocialLoginErrorStates extends SocialLoginStates{
  String error;
  SocialLoginErrorStates({required this.error});
}


class SocialCreateUserGoogleSuccessStates extends SocialLoginStates{
final String uId;
  SocialCreateUserGoogleSuccessStates({required this.uId});
}

class SocialCreateUserGoogleErrorStates extends SocialLoginStates{

}

class SocialLoginWithGoogleLoadingStates extends SocialLoginStates{}



class SocialLoginWithGoogleSuccessStates extends SocialLoginStates{
final String uId;
  SocialLoginWithGoogleSuccessStates({required this.uId});
}

class SocialLoginWithGoogleErrorStates extends SocialLoginStates{

}

class SocialChangePasswordVisible extends SocialLoginStates{}
class LastSocialScreenOnBoardng extends SocialLoginStates{}
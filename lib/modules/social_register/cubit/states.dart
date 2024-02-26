
abstract class SocialRegisterStates{}

class SocialRegisterInitialStates extends SocialRegisterStates{}

class SocialRegisterLoadingStates extends SocialRegisterStates{}

class SocialRegisterSuccessStates extends SocialRegisterStates{
  
}

class SocialRegisterErrorStates extends SocialRegisterStates{
  
}

class SocialCreateUserLoadingStates extends SocialRegisterStates{}

class SocialCreateUserSuccessStates extends SocialRegisterStates{
 final String uId;
  SocialCreateUserSuccessStates({required this.uId});
}

class SocialCreateUserErrorStates extends SocialRegisterStates{
  
}

class SocialRegisterChangePasswordVisible extends SocialRegisterStates{}
class SocialLastScreenOnBoardng extends SocialRegisterStates{}
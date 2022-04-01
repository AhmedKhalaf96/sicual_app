abstract class ModulesStates{}

class ModulesInitialState extends ModulesStates{}

class UserLoginLoad extends ModulesStates{}

class UserLoginSuccess extends ModulesStates{
  String uid;

  UserLoginSuccess(this.uid);
}


class UserLoginError extends ModulesStates{
  String error;

  UserLoginError(this.error);
}

class UserRegisterLoad extends ModulesStates{}

class UserRegisterSuccess extends ModulesStates{}

class UserRegisterError extends ModulesStates{
  String error;

  UserRegisterError(this.error);
}

class UserCreatedSuccess extends ModulesStates{
  String uid;

  UserCreatedSuccess(this.uid);
}

class UserCreatedError extends ModulesStates{
  String error;

  UserCreatedError(this.error);
}
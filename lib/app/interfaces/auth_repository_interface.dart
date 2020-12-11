import 'package:dartz/dartz.dart';
import 'package:party_mobile/app/models/auth_user_model.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';
import 'package:party_mobile/app/view_models/facebook_login_vm.dart';
import 'package:party_mobile/app/view_models/user_login_vm.dart';

abstract class IAuthRepositoryInterface {
  Future<Either<Failure, AuthUserModel>> authLogin(UserLoginVM userLogin);

  Future<Either<Failure, AuthUserModel>> authFacebook(FacebookLoginVM fbLogin);
}

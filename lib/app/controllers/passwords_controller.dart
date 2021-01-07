import 'package:party_mobile/app/repositories/passwords_repository.dart';

class PasswordsController {
  PasswordsRepository _passwordsRepository;

  PasswordsController() {
    _passwordsRepository = PasswordsRepository();
  }
}



import '../model/UserModel.dart';

class UserController {


  Future handleSignup(UserModel model)async {
    // Simulate user signup by saving the user data
    // In a real application, you would send this data to a server or database
    print('User signed up successfully:');
    print('Username: ${model.username}');
    print('Email: ${model.email}');
    print('Password: ${model.password}');
  }

}
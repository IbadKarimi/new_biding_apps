

class UserModel {
  String password;
  String email;
  String phoneNo;
  String fullName;
  String imagePath;
  String feedBack;
  String role;

  UserModel({ required this.email,required this.password,required this.fullName,required this.phoneNo, required this.imagePath,required this.feedBack,required this.role});


  factory UserModel.fromFirestore(Map<String, dynamic> data) {
    return UserModel(

      fullName: data['fullName'] ?? '',
      imagePath: data['imagePath'] ?? '',
      feedBack: data['feedBack'] ?? '',
      email: data['email'] ?? '',
      role: data['role'] ?? '', password: '', phoneNo: '',
    );
  }

// Additional methods for validation or data manipulation can be added here
}
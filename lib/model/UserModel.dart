

class UserModel {
  String password;
  String email;
  String phoneNo;
  String fullName;
  String imagePath;
  String feedBack;
  String role;

  UserModel({ this.email,this.password,this.fullName,this.phoneNo, this.imagePath,this.feedBack,this.role});


  factory UserModel.fromFirestore(Map<String, dynamic> data) {
    return UserModel(

      fullName: data['fullName'] ?? '',
      imagePath: data['imagePath'] ?? '',
      feedBack: data['feedBack'] ?? '',
      email: data['email'] ?? '',
      role: data['role'] ?? '',
    );
  }

// Additional methods for validation or data manipulation can be added here
}
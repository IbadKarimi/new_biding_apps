

class UserModel {
  String password;
  String email;
  String phoneNo;
  String fullName;
  String imagePath;
  String feedBack;

  UserModel({ this.email,this.password,this.fullName,this.phoneNo, this.imagePath,this.feedBack});


  factory UserModel.fromFirestore(Map<String, dynamic> data) {
    return UserModel(

      fullName: data['fullName'] ?? '',
      imagePath: data['imagePath'] ?? '',
      feedBack: data['feedBack'] ?? '',
      email: data['email'] ?? '',
    );
  }

// Additional methods for validation or data manipulation can be added here
}
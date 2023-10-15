

class UserModel {
  String password;
  String email;
  String phoneNo;
  String fullName;
  String imagePath;

  UserModel({ this.email,this.password,this.fullName,this.phoneNo, this.imagePath});


  factory UserModel.fromFirestore(Map<String, dynamic> data) {
    return UserModel(

      fullName: data['fullName'] ?? '',
      imagePath: data['imagePath'] ?? '',
    );
  }

// Additional methods for validation or data manipulation can be added here
}
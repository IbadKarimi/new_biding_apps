

class VehicleModel{
  String buyerDocId="";
  String vehicleType="";
  String condition="";
  String auctionType="";
  String vehicleName="";
  String model="";
  String registerArea="";
  String registerYear="";
  String enginePower="";
  String setBidPrice="";
  String setBidEndTime="";
  String cityName="";
  String completeAddress="";
  String description="";
  String status="";
  String imagePath="";
  String categoryName="";
  String userId="";

  VehicleModel({required this.userId,required this.buyerDocId,required this.vehicleType,required this.condition,required this.auctionType,required this.vehicleName,required this.model,
    required this.registerArea,required this.registerYear,required this.enginePower,required this.setBidPrice,required this.setBidEndTime,required this.cityName,
    required this.completeAddress,required this.description,required this.status,required this.imagePath,required this.categoryName
  });

  factory  VehicleModel.fromFirestore(Map<String, dynamic> data) {
    return VehicleModel(


        buyerDocId: data['buyerDocId'] ??"",
        vehicleType:data['vehicleType'] ??"",
        condition:data['condition']??"",
        auctionType:data['auctionType']??"",
        vehicleName:data['vehicleName']??"",
        model:data['model']??"",
        registerArea:data['registerArea']??"",
        registerYear:data['registerYear']??"",
        enginePower:data['enginePower']??"",
        setBidPrice:data['setBidPrice']??"",
        setBidEndTime:data['setBidEndTime']??"",
        cityName:data['cityName']??"",
        completeAddress:data['completeAddress']??"",
        description:data['description']??"",
        status:data['status']??"",
        imagePath:data['imagePath']??"",
      categoryName:data['categoryName']??"",
      userId: data['id'] ??"",


    );
  }


}
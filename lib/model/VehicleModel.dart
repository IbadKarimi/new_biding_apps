

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

  VehicleModel({this.buyerDocId,this.vehicleType,this.condition,this.auctionType,this.vehicleName,this.model,
    this.registerArea,this.registerYear,this.enginePower,this.setBidPrice,this.setBidEndTime,this.cityName,
    this.completeAddress,this.description,this.status,this.imagePath
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


    );
  }


}